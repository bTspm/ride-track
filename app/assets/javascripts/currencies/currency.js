var Currency = {
    init: function () {
        this.fromCurrency = $("#from-currency");
        this.toCurrency = $("#to-currency");

        this.fromAmount = $("#from-amount");
        this.toAmount = $("#to-amount");

        this.exchangeRate = $("#exchange-rate");

        this.selectDropdown =  $(".select2");

        return this;
    },

    bindEvents: function () {
        Currency.bindSelectChange(Currency.fromCurrency);
        Currency.bindSelectChange(Currency.toCurrency);

        Currency.bindInputChange(Currency.fromAmount);
        Currency.bindInputChange(Currency.toAmount);

        Currency.initCurrencyDropdown();
    },

    initCurrencyDropdown: function(){
        function formatCurrency (state) {
            if (!state.id) {
                return state.text;
            }
            return $(
                '<span><i class="currency-flag currency-flag-' + state.element.value.toLowerCase() + '"></i> ' + state.text + '</span>'
            );
        }

        Currency.selectDropdown.select2({
            width: 'resolve',
            templateResult: formatCurrency,
            templateSelection: formatCurrency,
        });
    },

    selectFormatCurrency: function(currency){
        return $('<span><i class="currency-flag currency-flag-' +
            currency.element.value.toLowerCase() +
            '"></i> ' + currency.text + '</span>')
    },

    bindInputChange: function (selector) {
        selector.on("change paste keyup", function () {
            Currency.inputExchangeRateCurrency(this);
        });
    },

    bindSelectChange: function (selector) {
        selector.on("change", function (e) {
            Currency.convert();
        });
    },

    currencyParams: function () {
        return {
            to: Currency.toCurrency.val(),
            from: Currency.fromCurrency.val()
        };
    },

    convert: function () {
        var data = Currency.currencyParams();
        if (data.to === data.from) {
            return;
        }

        // window.location.href = '/currencies/convert'.concat('?from=').concat(data.from).concat('&to=').concat(data.to);

        // common.get("/currencies/convert", data);

        // $.ajax({
        //     url: '/currencies/convert',
        //     type: "GET",
        //     dataType: "script",
        //     data: data
        // })
    },

    history: function(from, to){
        var data = {from: from, to: to};
        common.get("/currencies/history", data);
    },

    inputExchangeRateCurrency(element) {
        var exchangeRateValue = Currency.exchangeRate.text();
        var fromAmountValue = Currency.fromAmount.val();
        var toAmountValue = Currency.toAmount.val();

        if (
            fromAmountValue.length === 0 ||
            toAmountValue.length === 0
        ) {
            Currency.emptyInputFields();
            return;
        }

        if (element.id === "from-amount") {
            var toCalcAmount = Number(fromAmountValue * exchangeRateValue).toFixed(6);
            Currency.toAmount.val(toCalcAmount);
        } else {
            var fromCalcAmount = Number(toAmountValue / exchangeRateValue).toFixed(6);
            Currency.fromAmount.val(fromCalcAmount);
        }
    },

    emptyInputFields: function () {
        Currency.fromAmount.val("");
        Currency.toAmount.val("");
    }
};

