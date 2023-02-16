<?php


class exonnutils
{

    static function createUserName($sLname,$i="")
    {
        return preg_replace('/[^a-zA-Z]/','',$sLname).$i.time()."@nomail.de";

    }

    static function getCurrencyRates()
    {
        $aCurrencyRates = array();

        $oRates = simplexml_load_file('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml');
        foreach($oRates->Cube->Cube->Cube as $aRate)
        {
            $aCurrencyRates[trim($aRate["currency"])]=(real)($aRate["rate"]);
        }

        return $aCurrencyRates;
    }

    static function create_kennwort($only_up=false,$slog_count=3,$onlyDezimal=0)
    {
        if ($onlyDezimal)
        {
            $arr1 = array (1,2,3,4,5,6,7,8,9);
            $arr2 = array (1,2,3,4,5,6,7,8,9);
            $arr3 = array (1,2,3,4,5,6,7,8,9);
        }
        else
        {
            $arr1 = array (1,2,3,4,5,6,7,8,9);
            $arr2 = array ('b','c','d','f','g','h','j','k','m','n','p','q','r','s','t','v','w','x','z');
            $arr3 = array ('a','e','u','y');
        }


        $kennwort = '';

        for ($x=0; $x<$slog_count; $x++)
        {
            $rnd1 = rand(0,sizeof($arr1)-1);
            $rnd2 = rand(0,sizeof($arr2)-1);
            $rnd3 = rand(0,sizeof($arr3)-1);

            $kennwort.=$arr1[$rnd1];

            if ($rnd1 % 2 || $only_up) $kennwort.=strtoupper($arr2[$rnd2]);
            else $kennwort.=$arr2[$rnd2];

            if ($rnd2 % 2 && !$only_up) $kennwort.=$arr3[$rnd3];
            else $kennwort.=strtoupper($arr3[$rnd3]);
        }

        return $kennwort;
    }

    static function explodeWithApostrForMysql($aArray, $sSeparator=", ")
    {
        $aRes = array();
        foreach($aArray as $sValue)
            $aRes[]=oxDb::getDb()->quote($sValue);
        //fff

        return implode($sSeparator,$aRes);
    }

    static function MySQLLocalTimeToGMT($d)
    {
        return gmdate('Y-m-d\TH:i:s', $d);
    }


    static function GMTtoLocalTime($d)
    {
        return date('Y-m-d H:i:s', gmmktime(
            substr($d,11,2),
            substr($d,14,2),
            substr($d,17,2),
            substr($d,5,2),
            substr($d,8,2),
            substr($d,0,4)
        ));
    }

    static function GMTtoMktime($d)
    {
        return gmmktime(
            substr($d,11,2),
            substr($d,14,2),
            substr($d,17,2),
            substr($d,5,2),
            substr($d,8,2),
            substr($d,0,4)
        );
    }


    static function explodeWithApostrForMysqlWhere($aArray, $sSeparator=" AND ")
    {
        $aRes = array();
        foreach($aArray as $key => $sValue)
            $aRes[]=$key." = ".oxDb::getDb()->quote($sValue);

        return implode($sSeparator,$aRes);
    }

    static function createFilename($path, $filename)
    {
        $aName = explode(".", $filename);
        $fileType = "";
        if (count($aName)>1)
            $fileType = ".".array_pop($aName);
        $filenameWithoutType = implode(".", $aName);

        $i=0;
        $filenameNew = "";
        while(true) {
            if ($i==0)
                $filenameNew = $filenameWithoutType.$fileType;
            else
                $filenameNew = $filenameWithoutType."(".$i.")".$fileType;
            if (!file_exists($path.$filenameNew))
                break;
            $i++;
        }

        return $filenameNew;

    }


    static function rowArrayToAssocArray($aRow, $aHeader)
    {
        $res=array();
        foreach($aRow as $iR => $aR)
            $res[$aHeader[$iR]]=$aR;


        return $res;
    }



    static function my_fputcsv($handle, $data, $separator, $witchoutApostrov=false, $toCharset="")
    {
        if ($witchoutApostrov)
        {
            fputs($handle,implode($separator,$data)."\r\n");
        }
        else
        {
            $f = fopen('php://memory', 'w+');
            fputcsv($f,$data,$separator);
            fseek($f,0);
            $csv_string=fread($f,999999);
            if ($toCharset)
                $csv_string=mb_convert_encoding($csv_string,$toCharset,"UTF-8");
            fclose($f);
            fputs($handle,substr($csv_string,0,-1)."\r\n");
        }



    }



    static function debug_backtrace()
    {
        $res = array();
        $deb = debug_backtrace();
        foreach($deb as $value)
        {
            $res[]=array(
                'file' => $value["file"],
                'line' => $value["line"],
            );
        }

        return $res;
    }



    static function strToReal($str,&$countZiffrnNachKomma=0)
    {
        $pos1=strpos($str,".");
        $pos2=strpos($str,",");
        if (!($pos1===false) && !($pos2===false))
        {
            if ($pos1<$pos2)
                $str=str_replace(".","",$str);
            else
                $str=str_replace(",","",$str);
        }

        $str=str_replace(" ","",str_replace(",",".",$str));
        if ($countZiffrnNachKomma==-1)
        {
            $str=trim($str);
            $pos=strpos($str,".");
            if ($pos===false)
                $countZiffrnNachKomma=0;
            else
                $countZiffrnNachKomma=strlen($str)-$pos-1;
        }
        return (real)$str;
    }


    static  function mktimeFromMysqlDate($date)
    {
        $date_time=explode(" ",$date);
        if (strpos($date_time[0],"."))
        {
            $date_array=explode(".",$date_time[0]);
            $t = $date_array[0];
            $date_array[0]=$date_array[2];
            $date_array[2]=$t;
        }
        else
        {
            $date_array=explode("-",$date_time[0]);
        }
        $time_array=explode(":",$date_time[1]);
        return mktime((int)$time_array[0],(int)$time_array[1],(int)$time_array[2],(int)$date_array[1],(int)$date_array[2],(int)$date_array[0]);
    }



    static public function tmpClear($sCompileDir="") {
        $myConfig = oxRegistry::getConfig();

        if (!$sCompileDir) {
            $sCompileDir = $myConfig->getConfigParam( 'sCompileDir' );
        } else {
            $sCompileDir = $myConfig->getConfigParam('sShopDir').DIRECTORY_SEPARATOR.str_replace('/', 'AAA', $sCompileDir);
        }

        $files = glob($sCompileDir . '/*'); // get all file names
        foreach($files as $file){ // iterate files
            if(is_file($file))
            {
                unlink($file); // delete file
            }
            elseif ($file==$sCompileDir . "/smarty") {

                $files_smarty = glob($sCompileDir . '/smarty/*'); // get all file names
                if ($files_smarty) {
                    foreach($files_smarty as $file_smarty){ // iterate files
                        if(is_file($file_smarty))
                            unlink($file_smarty); // delete file
                    }
                }
            }

        }


    }


    static function array_mb_convert_encoding($array,$codirung_to,$codirung_from)
    {
        if (is_array($array))
        {
            foreach ($array as $key => $value)
                $array[$key]=self::array_mb_convert_encoding($value,$codirung_to,$codirung_from);
            $result=$array;
        }
        else
        {
            $result=mb_convert_encoding($array,$codirung_to,$codirung_from);

        }
        return $result;
    }




    static public function moveFields($sFrom, $sTo) {

        if (!is_dir($sFrom)) {
            return;
        }

        $files = glob($sFrom . '/*'); // get all file names
        $error=false;
        if (is_array($files)) {
            foreach($files as $file){ // iterate files
                $a = explode("/", $file);
                $filename = array_pop($a);
                if(is_file($file))
                {
                    if (copy($file, $sTo."/".$filename )) {
                        unlink($file); // delete file
                    } else {
                        $error = true;
                    }
                } else {

                    $files2 = glob($file . '/*'); // get all file names
                    $error2=false;
                    if (is_array($files2)) {

                        mkdir($sTo."/".$filename);

                        foreach($files2 as $file2){ // iterate files
                            if(is_file($file2))
                            {
                                $filename2 = array_pop(explode("/", $file2));
                                if (copy($file2, $sTo."/".$filename."/".$filename2 )) {
                                    unlink($file2); // delete file
                                } else {
                                    $error2 = true;
                                }

                            }
                        }
                    }

                    if (!$error2) {
                        rmdir($file);
                    }



                }
            }
        }

        if (!$error) {
            rmdir($sFrom);
        }

    }

}