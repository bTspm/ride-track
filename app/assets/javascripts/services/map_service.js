var MapService = {

    location: function(data){
        var map = new google.maps.Map(document.getElementById(data.selector), {
            zoom: 6,
            center: data.coordinates
        });

        var marker = new google.maps.Marker({
            position: data.coordinates,
            map: map,
            title: data.title
        });
    }

};