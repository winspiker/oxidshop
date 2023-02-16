<?php

class exonn_google_oxarticle extends exonn_google_oxarticle_parent {

    public function exonncleanup() {
        //cleanup everything from attributes
        foreach (get_class_vars(__CLASS__) as $clsVar => $_) {
            $prop = new ReflectionProperty(__CLASS__, $clsVar);
            if (!$prop->isStatic()) {
                unset($this->$clsVar);
            }
        }
        /*
        //cleanup all objects inside data array
        if (is_array($this->_data)) {
            foreach ($this->_data as $value) {
                if (is_object($value) && method_exists($value, 'cleanUp')) {
                    $value->cleanUp();
                }
            }
        }*/
    }
}

 
