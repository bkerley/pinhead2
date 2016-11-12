$ = require('jquery')

disp = (num, factor = 100, divisor = 100) ->
  Math.round(num * factor) / divisor

class Poster
  constructor: (@name, @baserate, @basecost) ->
    @rate = @baserate
    @cost = @basecost
    @count = 0

  tick: (delta) ->
    delta * @rate * @count

  buy: () ->
    @cost *= (5/3)
    @count += 1

  toHash: () ->
    h =
      rate: @rate
      cost: @cost
      count: @count

class PosterView
  constructor: (@scoreboard, @row) ->
    els = @row.find("td")
    @nameField = $(els[0])
    @rateField = $(els[1])
    @costField = $(els[2])
    @haveField = $(els[3])
    @valueField = $(els[4])

    name = @nameField.text()
    baserate = @row.data("baserate")
    basecost = @row.data("basecost")

    @row.find("button").click(@buy.bind(this))

    @poster = new Poster name, baserate, basecost
    @update()

  buy: (event) ->
    unless @scoreboard.canSpend @poster.cost
      return

    @scoreboard.spend(@poster.cost)
    @poster.buy()
    @update()

  tick: (delta) ->
    @poster.tick(delta)

  update: () ->
    @rateField.text disp @poster.rate
    @costField.text disp @poster.cost
    @haveField.text disp @poster.count
    @valueField.text disp(@poster.rate / @poster.cost, 1000000, 1)

class UpgradeView
  constructor: (@scoreboard, @row) ->
    els = @row.find("td")
    @costField = $(els[1])

    targetName = @row.data("target")
    @cost = @row.data("cost")
    @multiplier = @row.data("mult") || 1
    @adder = @row.data("add") || 0

    @button = @row.find("button")

    @button.click(@buy.bind(this))

    @target = @scoreboard.getPosterView targetName
    @bought = false

    @update()

  buy: (event) ->
    if @bought
      return
    unless @scoreboard.canSpend @cost
      return

    @scoreboard.spend(@cost)
    @target.poster.rate += @adder
    @target.poster.rate *= @multiplier
    @target.update()
    @button.prop("disabled", true)
    @bought = true

  update: () ->
    @costField.text disp @cost

class Scoreboard
  constructor: () ->
    @posts = 1

    @posterViews = for row in $("#posters tbody tr")
      new PosterView(this, $(row))
    @posters = for view in @posterViews
      view.poster

    @upgradeViews = for row in $("#upgrades tbody tr")
      new UpgradeView(this, $(row))

    @tickList = @posterViews

    @lastTick = Date.now()

    @timer = window.setInterval(@tick.bind(this), 250)

    @postsCtr = $("#posts_ctr")
    @postsDeltCtr = $("#posts_delt_ctr")

  tick: () ->
    curTick = Date.now()
    delta = (curTick - @lastTick) / 1000.0

    postChange = 0
    postChange += ticker.tick(delta) for ticker in @tickList

    @posts += postChange
    @update(postChange / delta)
    @lastTick = curTick

  update: (rate) ->
    @postsCtr.text disp @posts
    @postsDeltCtr.text disp rate

  canSpend: (amount) ->
    @posts >= amount

  spend: (amount) ->
    @posts -= amount

  getPosterView: (targetName) ->
    for view in @posterViews when view.poster.name is targetName
      return view

module.exports = () ->
  new Scoreboard()
