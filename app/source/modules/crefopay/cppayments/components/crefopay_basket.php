<?php

/**
 *  CrefoPay Basket
 */
class crefoPayBasket
{      
    // Additional Information
    private $basketItems = array();
    private $totalAmount;

    
    function init($oxBasket) {        
        $basketDiscounts     = $oxBasket->getDiscounts();

        $this->totalAmount = 0;
        
        // DEFAULT
        $this->defaultBasketItems($oxBasket->getContents());
        
        // COUPON
        $this->couponBasketItems($oxBasket->getVouchers());
     
        // SHIPPINGCOSTS
        $this->shippingcostsBasketItems($oxBasket->getDeliveryCosts());
    }
    
    public function getTotalAmount() 
    {
        return json_encode(
            array
            (   
                'amount' => $this->totalAmount
            )
        );
    }

    public function getBasketItems()
    {
        return json_encode($this->basketItems);
    }
    
    private function defaultBasketItems($items) 
    {
        foreach ($items as $basketItem)
        {
            $amount = $basketItem->getPrice()->getBruttoPrice() * 100;
            // update total amount
            $this->totalAmount += $amount;
            
            // add basket item
            $this->basketItems[] = array(                
                'basketItemText'   => $basketItem->getTitle(),
                'basketItemID'     => substr( $basketItem->getProductId() , 0 , 20),
                'basketItemCount'  => $basketItem->getAmount(),
                'basketItemAmount' => array
                (
                    'amount'  => $amount
                ),
                'basketItemType'   => 'DEFAULT'
            );
        }
    }
    
    private function couponBasketItems($items)
    {
        foreach ($items as $voucher)
        {
            $amount = $voucher->getDiscount() * 100;
            
            // update total amount
            $this->totalAmount -= $amount;
            
            // add basket item
            $this->basketItems[] = array(                
                'basketItemText'   => $voucher->getDiscountType(),
                'basketItemCount'  => 1,
                'basketItemAmount' => array
                (
                    'amount'  => $amount
                ),
                'basketItemType'   => 'COUPON'
            );
        }
    }
    
    private function shippingcostsBasketItems($value, $text = 'Shipping Costs')
    {
        if ($value)
        {
            $amount = $value * 100;
            $this->totalAmount += $amount;
            
            $this->basketItems[] = array(                
                'basketItemText'   => $text,
                'basketItemCount'  => 1,
                'basketItemAmount' => array
                (
                    'amount'  => $amount
                ),
                'basketItemType'   => 'SHIPPINGCOSTS'
            );
        }
    }
}