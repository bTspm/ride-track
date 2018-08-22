maps = (function () {

    function initDirectionMaps(from_lat, from_lng, to_lat, to_lng) {

        var directionsDisplay = new google.maps.DirectionsRenderer();
        var directionsService = new google.maps.DirectionsService();

        function calcRoute() {
            var request = {
                origin: new google.maps.LatLng(from_lat, from_lng),
                destination: new google.maps.LatLng(to_lat, to_lng),
                travelMode: google.maps.TravelMode.DRIVING
            };
            directionsService.route(request, function (response, status) {
                if (status === google.maps.DirectionsStatus.OK) {
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
        initDirectionMaps: initDirectionMaps
    };

})();