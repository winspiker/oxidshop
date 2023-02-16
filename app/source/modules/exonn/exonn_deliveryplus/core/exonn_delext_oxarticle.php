<?php

/**
 *  add to metadata.php in extend section: 'oxarticle' => 'exonn_deliveryext/core/exonn_delext_oxarticle',
 **/ 
class exonn_delext_oxarticle extends exonn_delext_oxarticle_parent {

    public function getArtTitle() {
        $title = $this->oxarticles__oxtitle->value;
        if(!$title) {
            if ($pid = $this->oxarticles__oxparentid->value) {
                $parent = oxNew("oxarticle");
                $parent->load($pid);
                $title = $parent->oxarticles__oxtitle->value;
            }
        }

        $title .= $this->oxarticles__oxvarselect->value ? " " . $this->oxarticles__oxvarselect->value : "";

        return $title;
    }

    public function getArticleParts($artPrice = 0)
    {
        $addWeightsVal = $this->oxarticles__addweight->value;
        $parts = $addWeightsVal ? explode(",", $addWeightsVal) : array();
        $partsInfo = array();

        if (count($parts)) {

            $i = 1;
            $priceSumm = 0;
            $price = $artPrice ? $artPrice : $this->getPrice()->getPrice();
            $partsCount = count($parts);
            foreach ($parts as $part) {
                $partInfo = explode(":", $part);

                $info = array();
                $info["weight"] = $partInfo[0];
                $info["pricepart"] = $partInfo[1];

                if ($partPrice = $partInfo[1]) {
                    $info["price"] = $partPrice * 100 / $price;
                } else {
                    $info["price"] = $price / $partsCount;
                    $info["pricepart"] =  100 / $partsCount;
                }
                if ($i < $partsCount) {
                    $priceSumm += $info["price"];
                }

                $partsInfo[$i] = $info;
                $i++;
            }
            //make price exact by cents
            $partsInfo[$partsCount]["price"] = $price - $priceSumm;
        }

        return $partsInfo;
    }

    public function getDeliveryWeight() {
        return $this->oxarticles__oxweight->value;
    }

    public function getDeliveryTitle() {
        return $this->getArtTitle();
    }

}
