jQuery(function($) {
    $('a[data-ajax]').on('click', function(e) {
        e.stopPropagation();
        $.ajax({url: this.href,
                method: 'get',
                success: function(){alert("should be open i guess")},
                error: function(){alert("shit, something busted")}});
    });
});
