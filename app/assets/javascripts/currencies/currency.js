var currency = {
    init: function () {
        this.fromCurrency = $("#from-currency");
        this.toCurrency = $("#to-currency");

        this.fromCurrencyCode = $("#from-currency-code");
        this.toCurrencyCode = $("#to-currency-code");

        this.fromCurrencyAddon = $("#from-currency-addon");
        this.toCurrencyAddon = $("#to-currency-addon");

        this.fromCurrencyName = $("#from-currency-name");
        this.toCurrencyName = $("#to-currency-name");

        this.fromAmount = $("#from-amount");
        this.toAmount = $("#to-amount");

        this.exchangeRate = $("#exchange-rate");

        currency.convertAndHistory();
        currency.bindEvents();
    },

    bindEvents: function () {
        currency.bindSelectChange(currency.fromCurrency);
        currency.bindSelectChange(currency.toCurrency);

        currency.bindInputChange(currency.fromAmount);
        currency.bindInputChange(currency.toAmount);
    },

    bindInputChange: function (selector) {
        selector.on("change paste keyup", function () {
            currency.inputExchangeRateCurrency(this);
        });
    },

    bindSelectChange: function (selector) {
        selector.on("change", function (e) {
            currency.convertAndHistory();
        });
    },

    convertData: function () {
        return {
            to_currency_code: currency.toCurrency.val(),
            from_currency_code: currency.fromCurrency.val()
        };
    },

    convertAndHistory: function () {
        var data = currency.convertData();
        if (data.to_currency_code === data.from_currency_code) {
            return;
        }
        currency.convert(data);
        currency.history(data);
    },

    convert: function (data) {
        common.get("/currencies/convert", data, function (successData) {
                currency.convertSuccessResponse(successData);
            }
        );
    },

    history: function(data){
        common.get("/currencies/history", data, function (successData) {
            chart.init(successData, 'currency-history');
            }
        );
    },

    convertSuccessResponse: function (data) {
        var fromCurrencyCodeValue = String(data.from_rate)
            .concat(" ")
            .concat(data.from_currency_code);
        currency.fromCurrencyCode.text(fromCurrencyCodeValue);
        currency.toCurrencyCode.text(data.to_currency_code);

        currency.fromCurrencyAddon.text(data.from_currency_code);
        currency.toCurrencyAddon.text(data.to_currency_code);

        currency.fromAmount.val(data.from_rate);
        currency.toAmount.val(data.to_rate);

        currency.exchangeRate.text(data.to_rate);

        currency.setCurrencyName();
    },

    setCurrencyName: function () {
        currency.fromCurrencyName.text(
            $("#from-currency option:selected").attr("currency_name")
        );
        currency.toCurrencyName.text(
            $("#to-currency option:selected").attr("currency_name")
        );
    },

    inputExchangeRateCurrency(element) {
        var exchangeRateValue = currency.exchangeRate.text();
        var fromAmountValue = currency.fromAmount.val();
        var toAmountValue = currency.toAmount.val();

        if (
            exchangeRateValue.length === 0 ||
            fromAmountValue.length === 0 ||
            toAmountValue.length === 0
        ) {
            currency.emptyInputFields();
            return;
        }

        if (element.id === "from-amount") {
            var toCalcAmount = Number(fromAmountValue * exchangeRateValue).toFixed(6);
            currency.toAmount.val(toCalcAmount);
        } else {
            var fromCalcAmount = Number(toAmountValue / exchangeRateValue).toFixed(6);
            currency.fromAmount.val(fromCalcAmount);
        }
    },

    emptyInputFields: function () {
        currency.fromAmount.val("");
        currency.toAmount.val("");
    }
};
