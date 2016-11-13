$ = require('jquery')
md5 = require('yamd5')

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

    @button = @row.find("button")
    @button.click(@buy.bind(this))

    @poster = new Poster name, baserate, basecost
    @update()

  buy: (event) ->
    unless @scoreboard.canSpend @poster.cost
      return

    @scoreboard.spend(@poster.cost)
    @poster.buy()
    @scoreboard.poke()
    @update()

  tick: (delta) ->
    if @scoreboard.canSpend @poster.cost
      @button.prop 'disabled', false
    else
      @button.prop 'disabled', true

    @poster.tick(delta)

  update: () ->
    @rateField.text disp @poster.rate
    @costField.text disp @poster.cost
    @haveField.text disp @poster.count
    @valueField.text disp(@poster.rate * @poster.count)

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
    @button.text("bought")
    @bought = true

  tick: (delta) ->
    if !@bought && @scoreboard.canSpend(@cost)
      @button.prop 'disabled', false
    else
      @button.prop 'disabled', true

    return 0

  update: () ->
    @costField.text disp @cost

class ProgressView
  constructor: (@scoreboard, @section) ->
    @bar = @section.find('div')

  tick: (delta) ->
    posterCount = 0
    for poster in @scoreboard.posters
      posterCount += poster.count

    posterCount = 219 if posterCount > 219

    @bar.css('width', "#{posterCount/2.19}%")
    if posterCount < 219
      @bar.text("#{posterCount} / 219")
    else
      dig = md5.hashStr(@scoreboard.notez.join(""))
      @bar.text("send #{dig} to udp port 1337 for the next level")


    return 0

class Scoreboard
  constructor: () ->
    @posts = 1

    @posterViews = for row in $("#posters tbody tr")
      new PosterView(this, $(row))
    @posters = for view in @posterViews
      view.poster
    @tickList = @posterViews

    @upgradeViews = for row in $("#upgrades tbody tr")
      new UpgradeView(this, $(row))
    @tickList.push @upgradeViews...


    @progressView = new ProgressView(this, $('section#progress'))
    @tickList.push @progressView

    @lastTick = Date.now()

    @timer = window.setInterval(@tick.bind(this), 250)

    @postsCtr = $("#posts_ctr")
    @postsDeltCtr = $("#posts_delt_ctr")

    @notes = "FaidajEunVosOkKafocVeozCyulciogsOasIkUfnaffyuryesdagdavWuAcasGohutBuOcvacAlRickJeajenwiWowisJoshtefNavyejyednivElOafyidDiOcyunAvepAvOridlumocEfOoxyovDerEctApnabnopAgDied7opufElovtyroadoadUlgyahochimhaQuejyin7ovWyawOyll4"
    @notez = []

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

  poke: () ->
    posterCount = 0
    for poster in @posters
      posterCount += poster.count
    @notez[posterCount] = @notes[((posterCount * 69) + 32) % 219]

  getPosterView: (targetName) ->
    for view in @posterViews when view.poster.name is targetName
      return view

module.exports = () ->
  new Scoreboard()
