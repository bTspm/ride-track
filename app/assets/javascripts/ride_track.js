coordinatesSearch = (function () {
    function initCordSearch() {
        $("#destination_address").geocomplete({
            details: ".destination_details",
            detailsAttribute: "data-destination"
        });


        $("#origin_address").geocomplete({
            details: ".origin_details",
            detailsAttribute: "data-origin"
        });

        $('.estimate').click(function () {
            estimate();
        });
    }

    function estimate() {
        var origin_data = extractData('origin', document);
        var destination_data = extractData('destination', document);
        common.initAjax('ride_track/estimate', {origin_details: origin_data, destination_details: destination_data});
    }

    function extractData(type, element){
        if (type.length === 0 || element.length === 0) {
            return {};
        }
        var data = {
            latitude: element.getElementById(type.concat('_latitude')).innerText,
            longitude: element.getElementById(type.concat('_longitude')).innerText,
            locality: element.getElementById(type.concat('_locality')).innerText,
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

initMaps = (function () {

    function directionMaps(from_lat, from_lng, to_lat, to_lng) {

        var directionsDisplay = new google.maps.DirectionsRenderer();
        var directionsService = new google.maps.DirectionsService();

        function calcRoute() {
            var request = {
                origin: new google.maps.LatLng(from_lat, from_lng),
                destination: new google.maps.LatLng(to_lat, to_lng),
                travelMode: google.maps.TravelMode.DRIVING
            };
            directionsService.route(request, function (response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                }
            });
        }

        calcRoute();

        var handler = Gmaps.build('Google');
        handler.buildMap({internal: {id: 'directions'}}, function () {
            directionsDisplay.setMap(handler.getMap());
        });
    }

    return {
        directionMaps: directionMaps
    };

})();