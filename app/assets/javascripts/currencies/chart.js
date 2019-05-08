var chart = {
    init: function (data, selector) {
        var ctx = document.getElementById(selector).getContext("2d");
        new Chart(ctx, chart.configData(data));
    },

    configData: function (data) {
        return {
            type: 'line',
            data: {
                labels: data.dates,
                datasets: [{
                    label: data.label,
                    backgroundColor: 'rgb(21, 91, 148)',
                    borderColor: 'rgb(21, 91, 148)',
                    data: data.rates,
                    fill: false
                }]
            }
        };
    }
};

