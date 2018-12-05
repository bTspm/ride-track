var coordinatesSearch = {
    init: function() {
        this.origin = $("#origin-address");
        this.destination = $("#destination-address");

        this.originLatitudeSelector = $("#origin-latitude");
        this.originLongitudeSelector = $("#origin-longitude");
        this.destinationLongitudeSelector = $("#destination-latitude");
        this.destinationitudeSelector = $("#destination-longitude");

        coordinatesSearch.bindEvents();
    },

    bindEvents: function() {
        this.origin.on("input", function() {
            $("#origin-latitude").val("");
            $("#origin-longitude").val("");
        });

        this.destination.on("input", function() {
            $("#destination-latitude").val("");
            $("#destination-longitude").val("");
        });

        var originAutoComplete = new google.maps.places.Autocomplete(
            coordinatesSearch.origin[0]
            ),
            destinationAutoComplete = new google.maps.places.Autocomplete(
                coordinatesSearch.destination[0]
            );

        coordinatesSearch.bindChange(originAutoComplete, "origin");
        coordinatesSearch.bindChange(destinationAutoComplete, "destination");
    },

    bindChange: function(autoComplete, type) {
        google.maps.event.addListener(autoComplete, "place_changed", function() {
            var place = autoComplete.getPlace();
            coordinatesSearch.fillInAddress(type, place);
        });
    },

    fillInAddress: function(type, place) {
        var location = place.geometry.location;
        if (type === "origin") {
            coordinatesSearch.originLatitudeSelector.val(location.lat());
            coordinatesSearch.originLongitudeSelector.val(location.lng());
        } else if (type === "destination") {
            coordinatesSearch.destinationLongitudeSelector.val(location.lat());
            coordinatesSearch.destinationitudeSelector.val(location.lng());
        } else {
            console.log("unknown type " + type);
        }
    }
};
