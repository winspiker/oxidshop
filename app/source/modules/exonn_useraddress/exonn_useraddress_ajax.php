<?php


class exonn_useraddress_ajax extends oxUBase
{

    public function zip_search()
    {
        //http://www.tvrus-shop.de/index.php?cl=exonn_useraddress_ajax&fnc=zip_search&searchparam=33611
        $db = mysqli_connect('exonn.de', 'd017f6d0', 'A2L8AZTKm8geAkMM', 'd017f6d0');
        mysqli_query($db,"SET NAMES UTF8");



        $oConfig = $this->getConfig();
        $sZIP  = trim($oConfig->getRequestParameter( "zip" ));
        $sStreet  = trim($oConfig->getRequestParameter( "street" ));


        $result=mysqli_query($db,"select a.strassenname from strassen a left join orts b on (a.ortscode=b.ortscode) where a.plz='".addslashes($sZIP)."' ".(($sStreet) ? " && strassenname like '".addslashes($sStreet)."%' " : "")." group by a.strassenname order by a.strassenname ");

        $xml='<?xml version="1.0" encoding="UTF-8" ?><addresslist>';
        while($row=mysqli_fetch_row($result))
        {
            $xml.='<address oxtitle="'.$row[0].'" key2="'.$row[0].'" />';
        }

        $xml.='</addresslist>';


        echo $xml;


        exit();
    }


    public function zipcity_search()
    {
        //http://www.tvrus-shop.de/index.php?cl=exonn_useraddress_ajax&fnc=zip_search&searchparam=33611
        $db = mysqli_connect('exonn.de', 'd017f6d0', 'A2L8AZTKm8geAkMM', 'd017f6d0');
        mysqli_query($db,"SET NAMES UTF8");



        $oConfig = $this->getConfig();
        $sZIP  = trim($oConfig->getRequestParameter( "zip" ));
        $sStreet  = trim($oConfig->getRequestParameter( "street" ));


        $result=mysqli_query($db,"select b.ortsname from strassen a left join orts b on (a.ortscode=b.ortscode) where a.plz='".addslashes($sZIP)."'  group by b.ortsname order by b.ortsname ");

        $xml='<?xml version="1.0" encoding="UTF-8" ?><addresslist>';
        while($row=mysqli_fetch_row($result))
        {
            $xml.='<address oxtitle="'.$row[0].'" key1="'.$row[0].'"  />';
        }

        $xml.='</addresslist>';


        echo $xml;


        exit();
    }

    private  function _getXML( $oList, $rootname, $aFieldList )
    {

        $sXML='<?xml version="1.0" encoding="UTF-8" ?>';
        $sXML.='<'.$rootname.'>';

        foreach($oList as $oBase)
        {
            $sXML.='<'.$oBase->getCoreTableName();
            foreach($aFieldList as $sFieldName)
            {
                if (is_array($sFieldName))
                {
                    $sVar = $oBase->getCoreTableName()."__".$sFieldName['value'];
                    $sXML.=' '.$sFieldName['key'].'="'.$oBase->{$sVar}->value.'"';

                }
                else
                {
                    $sVar = $oBase->getCoreTableName()."__".$sFieldName;
                    $sXML.=' '.$sFieldName.'="'.$oBase->{$sVar}->value.'"';
                }
            }
            $sXML.=' />';
        }


        $sXML.='</'.$rootname.'>';

        return $sXML;

    }

}
