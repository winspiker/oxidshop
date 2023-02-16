<?php

/** 
 * CrefoPay Order Controller
 */
class crefopay_order extends crefopay_order_parent
{
    protected function _getNextStep($iSuccess)
    {
        $sNextStep = 'thankyou';
        $logger = oxNew('crefoPayLogger');
        
        //little trick with switch for multiple cases
        switch (true) {
            case ($iSuccess === oxOrder::ORDER_STATE_MAILINGERROR):
                $sNextStep = 'thankyou?mailerror=1';
                break;
            case ($iSuccess === oxOrder::ORDER_STATE_INVALIDDElADDRESSCHANGED):
                $sNextStep = 'order?iAddressError=1';
                break;
            case ($iSuccess === oxOrder::ORDER_STATE_BELOWMINPRICE):
                $sNextStep = 'order';
                break;
            case ($iSuccess === oxOrder::ORDER_STATE_PAYMENTERROR):
                // no authentication, kick back to payment methods
                oxRegistry::getSession()->setVariable('payerror', 2); 
                $sNextStep = 'payment?payerror=2';
                break;
            case ($iSuccess === oxOrder::ORDER_STATE_ORDEREXISTS):
                break; // reload blocker activ
            case (is_numeric($iSuccess) && $iSuccess > 3): 
                oxRegistry::getSession()->setVariable('payerror', $iSuccess);
                $sNextStep = 'payment?payerror=' . $iSuccess;
                break;
            case (!is_numeric($iSuccess) && $iSuccess):                
                if (filter_var($iSuccess, FILTER_VALIDATE_URL)) { 
                    // redirect payment method
                    $logger->log(0, __FILE__, "Redirect required. URL target: " . print_r($iSuccess, true));
                    oxRegistry::getUtils()->redirect($iSuccess, false);
                    $logger->log(0, __FILE__, "Reach code that should nevern been reached");
                } else {
                    //instead of error code getting error text and setting payerror to -1
                    oxRegistry::getSession()->setVariable('payerror', -1);
                    $logger->log(1, __FILE__, "Got Payment Error: " . $iSuccess);
                    $iSuccess = urlencode($iSuccess);
                    $sNextStep = 'payment?payerror=-1&payerrortext=' . $iSuccess;
                }
                break;
            default:
                break;
        }

        return $sNextStep;
    }

}
