var mapService = {
    directions: function(
        fromLatitude,
        fromLongitude,
        toLatitude,
        toLongitude,
        selector
    ) {
        var mapContainer = $(selector);
        this.origin = new google.maps.LatLng(fromLatitude, fromLongitude);
        this.destination = new google.maps.LatLng(toLatitude, toLongitude);

        this.map = new google.maps.Map(mapContainer[0]);
        this.directionsService = new google.maps.DirectionsService();
        this.directionsDisplay = new google.maps.DirectionsRenderer({
            map: mapService.map
        });

        mapContainer.show();
        mapService.calculateAndDisplayRoute();
    },

    calculateAndDisplayRoute: function() {
        mapService.directionsService.route(
            {
                origin: mapService.origin,
                destination: mapService.destination,
                travelMode: google.maps.TravelMode.DRIVING
            },
            function(response, status) {
                if (status === google.maps.DirectionsStatus.OK) {
                    mapService.directionsDisplay.setDirections(response);
                }
            }
        );
    }
};
