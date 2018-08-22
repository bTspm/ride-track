common = (function () {
    function initAjax(url, data) {
        $.ajax({
            url: url,
            data: data,
        });
    }

    return {
        initAjax: initAjax
    };
})();