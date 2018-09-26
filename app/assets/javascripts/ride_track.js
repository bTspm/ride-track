coordinatesSearch = (function () {
    function initCordSearch() {
        $("#destination_address").geocomplete({
            details: "#destination_details",
            detailsAttribute: "data-destination"
        });


        $("#origin_address").geocomplete({
            details: "#origin_details",
            detailsAttribute: "data-origin"
        });

        $('#estimate').click(function () {
            estimate();
        });
    }

    function estimate() {
        var origin_data = extractData('origin', document);
        var destination_data = extractData('destination', document);
        common.initAjax('ride_track/price_estimate', {origin_details: origin_data, destination_details: destination_data});
    }

    function extractData(type, element){
        if (type.length === 0 || element.length === 0) {
            return {};
        }
        var data = {
            latitude: element.getElementById(type.concat('_latitude')).innerText,
            longitude: element.getElementById(type.concat('_longitude')).innerText,
            city: element.getElementById(type.concat('_city')).innerText,
            state: element.getElementById(type.concat('_state')).innerText,
            postal_code: element.getElementById(type.concat('_postal_code')).innerText,
            country: element.getElementById(type.concat('_country')).innerText
        };
        return data;
    }

    return {
        initCordSearch: initCordSearch
    };
})();