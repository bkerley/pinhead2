jQuery(function($) {
    $('a[data-ajax]').on('click', function(e) {
        e.preventDefault();
        $.ajax({url: this.href,
                method: 'get',
                success: function(){alert("should have worked i guess")},
                error: function(){alert("shit, something busted")}});
    });
});
