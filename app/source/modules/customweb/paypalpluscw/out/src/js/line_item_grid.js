(function($) {
	
	var PayPalPlusCwLineItemGrid = {
		decimalPlaces: 2,
		currencyCode: 'EUR',
		
		init: function() {
			this.decimalPlaces = parseFloat($("#paypalpluscw-decimal-places").val());
			this.currencyCode = $("#paypalpluscw-currency-code").val();
			this.attachListeners();
		},
		
		attachListeners: function() {
			$(".paypalpluscw-line-item-grid input.line-item-quantity").each(function() {
				PayPalPlusCwLineItemGrid.attachListener(this);
			});
			$(".paypalpluscw-line-item-grid input.line-item-price-excluding").each(function() {
				PayPalPlusCwLineItemGrid.attachListener(this);
			});
			$(".paypalpluscw-line-item-grid input.line-item-price-including").each(function() {
				PayPalPlusCwLineItemGrid.attachListener(this);
			});
		},
		
		attachListener: function(element) {
			$(element).change(function() {
				PayPalPlusCwLineItemGrid.recalculate(this);
			});
			
			$(element).attr('data-before-change', $(element).val());
			$(element).attr('data-original', $(element).val());
		},
		
		recalculate: function(eventElement) {
			var lineItemIndex = $(eventElement).parents('tr').attr('data-line-item-index');
			var row = $('.paypalpluscw-line-item-grid tr[data-line-item-index="' + lineItemIndex + '"]');
			var taxRate = parseFloat(row.find('input.tax-rate').val());

			var quantityBefore = parseFloat(row.find('input.line-item-quantity').attr('data-before-change'));
			var quantityValue = row.find('input.line-item-quantity').val();
			if (quantityValue == '' || isNaN(quantityValue)) {
				var quantity = quantityBefore;
			} else {
				var quantity = parseFloat(quantityValue);
			}
			
			var priceExcludingBefore = parseFloat(row.find('input.line-item-price-excluding').attr('data-before-change'));
			var priceExcludingValue = row.find('input.line-item-price-excluding').val();
			if (priceExcludingValue == '' || isNaN(priceExcludingValue)) {
				var priceExcluding = priceExcludingBefore;
			} else {
				var priceExcluding = parseFloat(priceExcludingValue);
			}

			var priceIncludingBefore = parseFloat(row.find('input.line-item-price-including').attr('data-before-change'));
			var priceIncludingValue = row.find('input.line-item-price-including').val();
			if (priceIncludingValue == '' || isNaN(priceIncludingValue)) {
				var priceIncluding = priceIncludingBefore;
			} else {
				var priceIncluding = parseFloat(priceIncludingValue);
			}
			
			if ($(eventElement).hasClass('line-item-quantity')) {
				if (quantityBefore == 0) {
					quantityBefore = parseFloat(row.find('input.line-item-quantity').attr('data-original'));
					priceExcludingBefore = parseFloat(row.find('input.line-item-price-excluding').attr('data-original'));
				}
				var pricePerItemExcluding = parseFloat(priceExcludingBefore / quantityBefore);
				priceExcluding = quantity * pricePerItemExcluding;
				priceIncluding = (taxRate / 100 + 1) * priceExcluding;
			}
			else if ($(eventElement).hasClass('line-item-price-excluding')) {
				priceIncluding = (taxRate / 100 + 1) * priceExcluding;
			}
			else if ($(eventElement).hasClass('line-item-price-including')) {
				priceExcluding = priceIncluding / (taxRate / 100 + 1);
			}
			
			quantity = quantity.toFixed(0);
			priceExcluding = priceExcluding.toFixed(this.decimalPlaces);
			priceIncluding = priceIncluding.toFixed(this.decimalPlaces);
			
				
			row.find('input.line-item-quantity').val(quantity);
			row.find('input.line-item-price-excluding').val(priceExcluding);
			row.find('input.line-item-price-including').val(priceIncluding);
			
			row.find('input.line-item-quantity').attr('data-before-change', quantity);
			row.find('input.line-item-price-excluding').attr('data-before-change', priceExcluding);
			row.find('input.line-item-price-including').attr('data-before-change', priceIncluding);
			
			// Update total
			var totalAmount = 0;
			$(".paypalpluscw-line-item-grid input.line-item-price-including").each(function() {
				totalAmount += parseFloat($(this).val());
			});
			
			$('#line-item-total').html(totalAmount.toFixed(this.decimalPlaces));
			$('#line-item-total').append(" " + this.currencyCode);
		},
		
	};
	
	$(document).ready(function() {
		PayPalPlusCwLineItemGrid.init();
	});

})(jQuery);