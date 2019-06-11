var Currency = {
    init: function() {
        this.elements = {
            fromAmount: $("#from-amount"),
            fromCurrency: $("#from-currency"),
            toCurrency: $("#to-currency"),
            toAmount: $("#to-amount"),
            exchangeRate: $("#exchange-rate"),
            selectDropdown: $(".select2"),
            currencyInput: $(".currency-input")
        };
        return this;
    },

    bindEvents: function() {
        Currency.bindInputChange();
        Currency.initCurrencyDropdown();
    },

    bindInputChange: function() {
        Currency.elements.currencyInput.on("change paste keyup", function() {
            debugger;
            Currency.inputExchangeRateCurrency(this);
        });
    },

    emptyInputFields: function() {
        Currency.elements.fromAmount.val("0");
        Currency.elements.toAmount.val("0");
    },

    initCurrencyDropdown: function() {
        Currency.elements.selectDropdown.select2({
            width: "resolve",
            templateResult: Currency.selectFormatCurrency,
            templateSelection: Currency.selectFormatCurrency
        });
    },

    inputExchangeRateCurrency(element) {
        var fromAmountValue = Currency.elements.fromAmount.val();
        var toAmountValue = Currency.elements.toAmount.val();

        if (fromAmountValue.length === 0 || toAmountValue.length === 0) {
            Currency.emptyInputFields();
            return;
        }

        Currency.updateExchangeRateValue(
            Currency.elements.fromCurrency.val(),
            Currency.elements.toCurrency.val()
        );
        var exchangeRateValue = Currency.elements.exchangeRate.text();

        if (element.id === "from-amount") {
            var toCalcAmount = Number(fromAmountValue * exchangeRateValue).toFixed(6);
            Currency.elements.toAmount.val(toCalcAmount);
        } else {
            var fromCalcAmount = Number(toAmountValue / exchangeRateValue).toFixed(6);
            Currency.elements.fromAmount.val(fromCalcAmount);
        }
    },

    selectFormatCurrency: function (currency) {
        if (!currency.id) {
            return currency.text;
        }
        return $(
            '<span><i class="currency-flag currency-flag-' +
            currency.element.value.toLowerCase() +
            '"></i> ' +
            currency.text +
            "</span>"
        );
    },

    updateExchangeRateValue: function(from, to) {
        if (to === from) {
            return 1;
        }

        $.ajax({
            url: "/currencies/exchange_rate",
            type: "GET",
            dataType: "JSON",
            data: { from: from, to: to },
            success: function(data) {
                Currency.elements.exchangeRate.text(data);
            }
        });
    },
};
