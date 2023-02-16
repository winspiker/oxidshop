<?php

/**
 *
 *
 * @author EXONN
 */
class exonn_connector_oxemail extends exonn_connector_oxemail_parent
{



    public function sendOrderEmailToOwner($order, $subject = null)
    {
        $config = $this->getConfig();

        if ($config->getConfigParam('EXONN_CONNECTOR_EMAIL_COPY_BACK')) {
            return true;
        }

        return parent::sendOrderEmailToOwner($order, $subject);

    }


    public function setFrom($address, $name = null, $auto = true)
    {
        $success = parent::setFrom($address, $name, $auto);

        if ($this->getConfig()->getConfigParam('EXONN_CONNECTOR_NOT_EMAIL_OWNER')){
            parent::AddBCC($address, $name);
        }


        return $success;
    }

}
