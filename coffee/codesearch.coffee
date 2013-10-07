jQuery ->

    basename = (path) ->
        splits = path.split('/')
        length = splits.length
        splits[splits.length - 1]

    $("ul").on "click", "a", (event) ->
        $('#myModal').modal(show=true)

        href = $(event.target).attr "href"
        url = "#{href}&ajax=1"

        event.preventDefault()

        $.get url, null, (data) ->
            $(".modal-title").text basename href
            $("#link").attr "href", href
            $('.modal-body').html(data)
            $('#myModal').modal(show=true)


    search = (event) ->
        term = escape jQuery.trim $(event.target).val()

        if not term
            $("ul").empty()
            return

        populate = (data) ->
            jQuery("ul").empty()
            for filename in data
                li = "<li class=\"list-group-item\"><a href=\"/display?f=#{filename}\">#{filename}</a></li>"
                jQuery("ul").append li

        jQuery.getJSON "/search?q=#{term}", null, populate

    jQuery('input[type="search"]').keyup search
    jQuery('input[type="search"]').change search
