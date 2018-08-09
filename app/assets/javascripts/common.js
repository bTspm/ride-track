common = (function () {
    function initAjax(url, data) {
        $.ajax({
            url: 'ride_track/estimate',
            data: data,
        });
    }

    return {
        initAjax: initAjax
    };
})();