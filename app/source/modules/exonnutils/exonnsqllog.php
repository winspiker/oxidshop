<?php


class exonnsqllog
{

    static protected $_aTableNoLog = array(
        'oxamazon_action',
        'oxebay_action',
        'ebayorderserr',
        'ebaycat_specifics_recom',
        'specifics_vals',
        'oxcounters',
        'ebaycat_specifics',
        'ebay_category',
        'oxbankingprocess',
        'oxebayarticles',
        'oxsession',
        'ebay_config_num',
        'paypalpluscw_transaction',
        'oxarticlestock',
        'oxusersession',
        'oxcronjobswawi',
        'oxsoftphoneforwarding',
        'oxuser_insert',

    );


static protected $fields_arc = array('arc_ip','arc_user_id','arc_date','arc_url','arc_sql','mybacktrace','class_function');
static protected $fields_arc2 = array(
array(
'COLUMN_NAME' => 'arc_ip',
'DATA_TYPE' => 'varchar',
'CHARACTER_MAXIMUM_LENGTH' => '20',
'CHARACTER_SET_NAME' => 'latin1',
'COLLATION_NAME' => 'latin1_general_ci',
'IS_NULLABLE' => 'NO',
'COLUMN_DEFAULT' => ''
),
array(
'COLUMN_NAME' => 'arc_user_id',
'DATA_TYPE' => 'varchar',
'CHARACTER_MAXIMUM_LENGTH' => '32',
'CHARACTER_SET_NAME' => 'latin1',
'COLLATION_NAME' => 'latin1_general_ci',
'IS_NULLABLE' => 'NO',
'COLUMN_DEFAULT' => ''
),
array(
'COLUMN_NAME' => 'arc_date',
'DATA_TYPE' => 'datetime',
'CHARACTER_MAXIMUM_LENGTH' => '',
'CHARACTER_SET_NAME' => '',
'COLLATION_NAME' => '',
'IS_NULLABLE' => 'NO',
'COLUMN_DEFAULT' => ''
),
array(
'COLUMN_NAME' => 'arc_url',
'DATA_TYPE' => 'text',
'CHARACTER_MAXIMUM_LENGTH' => '',
'CHARACTER_SET_NAME' => 'utf8',
'COLLATION_NAME' => 'utf8_general_ci',
'IS_NULLABLE' => 'NO',
'COLUMN_DEFAULT' => ''
),
array(
'COLUMN_NAME' => 'arc_sql',
'DATA_TYPE' => 'text',
'CHARACTER_MAXIMUM_LENGTH' => '',
'CHARACTER_SET_NAME' => 'utf8',
'COLLATION_NAME' => 'utf8_general_ci',
'IS_NULLABLE' => 'NO',
'COLUMN_DEFAULT' => ''
),
array(
'COLUMN_NAME' => 'mybacktrace',
'DATA_TYPE' => 'text',
'CHARACTER_MAXIMUM_LENGTH' => '',
'CHARACTER_SET_NAME' => 'utf8',
'COLLATION_NAME' => 'utf8_general_ci',
'IS_NULLABLE' => 'NO',
'COLUMN_DEFAULT' => ''
),
array(
'COLUMN_NAME' => 'class_function',
'DATA_TYPE' => 'varchar',
'CHARACTER_MAXIMUM_LENGTH' => '80',
'CHARACTER_SET_NAME' => 'latin1',
'COLLATION_NAME' => 'latin1_general_ci',
'IS_NULLABLE' => 'NO',
'COLUMN_DEFAULT' => ''
),
);


    static public function sqllogsave($query, $oConnection)
    {

        $query = trim($query);

        $queryType = trim(strtoupper(substr($query,0,7)));

        $myConfig = oxRegistry::getConfig();

        //$sWawiId = getWawiId();


        if (/*$sWawiId==$myConfig->getConfigParam('sVerwaltungWawiId') || $sWawiId==$myConfig->getConfigParam('sDemoWawiOxid') || $sWawiId==$myConfig->getConfigParam('sLeerWawiOxid') || $myConfig->getConfigParam('blDemoWawiMain') || */!in_array($queryType,array("UPDATE","DELETE", "INSERT")))
            return;

        $pos_where = self::_searchStrInNoQuote($query,"where");

        $str_pos=0;
        $str_pos1=0;
        $backtrace = '';
        switch ($queryType) {
            case "UPDATE":
                $str_pos = self::_searchStrInNoQuote($query,"set");
                $str_pos1=7;
                //$backtrace = print_r(debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS), true);
                break;

            case "INSERT":
                $str_pos = self::_searchStrInNoQuote($query,"set");
                $str_pos1=12;
                break;

            case "DELETE":
                $str_pos=((!$pos_where) ? strlen($query) : $pos_where);
                $str_pos1=self::_searchStrInNoQuote($query,"from");
                $str_pos1+=5;
                break;
        }




        if ($str_pos) {

            if (!$pos_where)
                $where="";
            else
                $where=substr($query,$pos_where);


            $tables=explode(",",substr($query,$str_pos1,($str_pos-$str_pos1)));
            foreach ($tables as $table)
            {
                $table_name_array=explode(" ",trim($table));

                $insert_Tablename = "";
                $table_alias = "";
                foreach($table_name_array as $temp) {
                    if (!$temp || strtolower($temp)=="as")
                        continue;

                    $temp = addslashes(str_replace("`", "", trim($temp)));
                    if (!$insert_Tablename)
                        $insert_Tablename = $temp;
                    else {
                        $table_alias = $temp;
                        break;
                    }
                }

                if (in_array($insert_Tablename, self::$_aTableNoLog))
                    continue;


                // проверка изменяются ли данные в этой таблице
                if ($queryType=="UPDATE") {
                    if ($pos_where)
                        $sSETData = substr($query, $str_pos+3, $pos_where-($str_pos+3));
                    else
                        $sSETData = substr($query, $str_pos+3);


                    $flag_SET_IS = false;
                    $sSETData.=",";
                    while(true) {
                        $pos_coma = self::_searchStrInNoQuote($sSETData,",", false);
                        if (!$pos_coma) {
                            break;
                        }
                        $aFieldSET = explode("=", substr($sSETData,0,$pos_coma));

                        $sSETData = substr($sSETData,$pos_coma+1);

                        $aFieldNameSET = explode(".", $aFieldSET[0]);

                        if (count($aFieldNameSET)==2) {
                            if ($table_alias != "") {
                                if (str_replace("`", "", trim($aFieldNameSET[0]))==$table_alias) {
                                    $flag_SET_IS = true;
                                    break;
                                }
                            } else {
                                if (str_replace("`", "", trim($aFieldNameSET[0]))==$insert_Tablename) {
                                    $flag_SET_IS = true;
                                    break;
                                }
                            }
                        } else {
                            $flag_SET_IS = true;
                            break;
                        }

                    }

                    if (!$flag_SET_IS)
                        continue;

                }


                if (isset($_SESSION["auth"])) {
                    $session_auth = $_SESSION["auth"];
                } elseif (isset($_SESSION["usr"])) {
                    $session_auth = $_SESSION["usr"];
                } else {
                    $session_auth = "";
                }



                if ($queryType=="INSERT") {
                    $query_log="insert into ".$insert_Tablename."_arc set
                                            ".self::$fields_arc[0]."='".addslashes($_SERVER['REMOTE_ADDR'])."',
                                            ".self::$fields_arc[1]."='".addslashes($session_auth)."',
                                            ".self::$fields_arc[2]."=now(),
                                            ".self::$fields_arc[3]."='".addslashes($_SERVER['REQUEST_URI'])."',
                                            ".self::$fields_arc[4]."='".addslashes($query)."',
                                            ".self::$fields_arc[5]."='".addslashes(print_r($backtrace,true))."',
                                            ".self::$fields_arc[6]."='".addslashes($_REQUEST["cl"].":".$_REQUEST["fnc"])."',
                                            ".substr($query,$str_pos+3);
                } else {


                    $iCurFetchMode = oxDb::getFetchMode();
                    try {
                        $fields=implode(",",array_merge(self::$fields_arc, oxDb::getDb()->getCol("SHOW COLUMNS FROM ".$insert_Tablename)));
                    } catch (\OxidEsales\Eshop\Core\Exception\DatabaseErrorException $exception) {
                        oxDb::getDb($iCurFetchMode);
                        return;
                    }
                    oxDb::getDb($iCurFetchMode);

                    $sql_ende=(($table_alias != "") ? $table_alias."." : $insert_Tablename.".")."*
                                    from ".implode(",",$tables).(($table_alias=="" && count($tables)==1) ? " ".$insert_Tablename." " : " ").$where;
                    $query_log="insert into ".$insert_Tablename."_arc (".$fields.")
                                    select '".addslashes($_SERVER['REMOTE_ADDR'])."' as arc_ip,
                                            '".addslashes($session_auth)."' as arc_user_id,
                                            now(),
                                            '".addslashes($_SERVER['REQUEST_URI'])."' as arc_url,
                                            '".addslashes($query)."' as arc_sql,
                                            '".addslashes(print_r($backtrace,true))."' as mybacktrace,
                                            '".addslashes($_REQUEST["cl"].":".$_REQUEST["fnc"])."' as class_function,
                                            ".$sql_ende;
                }

                try {
                    $oConnection->executeUpdate($query_log);
                } catch (\Doctrine\DBAL\DBALException $exception) {

                    if ($errorno = $exception->getErrorCode()) {
                        self::catchSQLError($query_log, $errorno, $insert_Tablename, $oConnection);
                    }

                }
            }

        }
    }



    static protected function catchSQLError($query_log, $errorno, $insert_Tablename, $oConnection)
    {
        switch ($errorno) {
            case 1146:
                // Tabelle existiert nicht, muss erstellt werden

                $iCurFetchMode = oxDb::getFetchMode();
                try {

                    list($temp, $query_create) = oxDb::getDb()->getRow("SHOW CREATE TABLE ".$insert_Tablename);
                } catch (\OxidEsales\Eshop\Core\Exception\DatabaseErrorException $exception) {
                    oxDb::getDb($iCurFetchMode);
                    return;
                }
                oxDb::getDb($iCurFetchMode);


                $pos_table_create_start = stripos($query_create,'PRIMARY KEY (');
                if ($pos_table_create_start ) {
                    $query_create = substr($query_create,0,$pos_table_create_start).'PRIMARY KEY (`arc_id`)) ENGINE=MyISAM';
                }

                $query_create = str_ireplace("AUTO_INCREMENT", " ", $query_create);

                $query_create = str_replace("CREATE TABLE `".$insert_Tablename."` (", "CREATE TABLE `".$insert_Tablename."_arc` (
                                  `arc_id` int NOT NULL AUTO_INCREMENT,
                                  `".self::$fields_arc[0]."` varchar(20) NOT NULL DEFAULT '',
                                  `".self::$fields_arc[1]."` varchar(32) NOT NULL DEFAULT '',
                                  `".self::$fields_arc[2]."` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
                                  `".self::$fields_arc[3]."` text CHARACTER SET utf8 NOT NULL,
                                  `".self::$fields_arc[4]."` text CHARACTER SET utf8 NOT NULL,
                                  `".self::$fields_arc[5]."` text CHARACTER SET utf8 NOT NULL,
                                  `".self::$fields_arc[6]."` varchar(80) NOT NULL DEFAULT '', ",
                    $query_create);


                try {
                    $oConnection->executeUpdate($query_create);
                } catch (\Doctrine\DBAL\DBALException $exception) {

                    file_put_contents('log/error_sqllog_newtable.txt', $query_create."\n\n".print_r($exception->getMessage(), true)."\n", FILE_APPEND);
                    return;
                }

                break;

            case 1054:
                // нет поля
                $iCurFetchMode = oxDb::getFetchMode();
                $aFieldsOriginal = self::$fields_arc2;
                try {
                    if ($aFieldsOriginal_2=oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->getAll( "SELECT COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, CHARACTER_SET_NAME, COLLATION_NAME, COLUMN_TYPE  FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='".$insert_Tablename."' order by ORDINAL_POSITION ")) {

                        $aFieldsOriginal = array_merge($aFieldsOriginal, $aFieldsOriginal_2);

                        $art_fields = oxDb::getDb()->getCol("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='" . $insert_Tablename . "_arc' order by ORDINAL_POSITION ");

                        foreach ($aFieldsOriginal as $f) {
                            if (!in_array($f["COLUMN_NAME"], $art_fields)) {
                                self::_addFieldToArc($insert_Tablename, $f, $oConnection);

                            }
                        }
                        oxDb::getDb($iCurFetchMode);
                    } else {
                        oxDb::getDb($iCurFetchMode);
                        return;
                    }
                } catch (\OxidEsales\Eshop\Core\Exception\DatabaseErrorException $exception) {
                    oxDb::getDb($iCurFetchMode);
                    return;
                }
                break;

        }

        //mysql_query($query_log, $this->connectionId);
        try {
            $oConnection->executeUpdate($query_log);
        } catch (\Doctrine\DBAL\DBALException $exception) {

        }

    }




    static protected function _addFieldToArc($insert_Tablename, $aktOrigField, $oConnection)
    {
        $query_addfield = "ALTER TABLE  ".$insert_Tablename."_arc ADD  `".$aktOrigField['COLUMN_NAME']."` ".$aktOrigField['COLUMN_TYPE'];
        /*if ($aktOrigField['CHARACTER_MAXIMUM_LENGTH'])
            $query_addfield.=" ( ".$aktOrigField['CHARACTER_MAXIMUM_LENGTH']." ) ";*/

        if ($aktOrigField['CHARACTER_SET_NAME'])
            $query_addfield.=" CHARACTER SET ".$aktOrigField['CHARACTER_SET_NAME']." ";

        if ($aktOrigField['COLLATION_NAME'])
            $query_addfield.=" COLLATE ".$aktOrigField['COLLATION_NAME']." ";

        if ($aktOrigField['IS_NULLABLE']=="NO")
            $query_addfield.=" NOT NULL ";

        if ($aktOrigField['COLUMN_DEFAULT']!==null) {
            if ($aktOrigField['COLUMN_DEFAULT']=="CURRENT_TIMESTAMP") {
                $query_addfield .= " DEFAULT CURRENT_TIMESTAMP ";
            } else {
                $query_addfield .= " DEFAULT '" . $aktOrigField['COLUMN_DEFAULT'] . "'";
            }
        }


        try {
            $oConnection->executeUpdate($query_addfield);
        } catch (\Doctrine\DBAL\DBALException $exception) {
            file_put_contents('log/error_sqllog_newfield.txt', $query_addfield."\n\n".print_r($exception->getMessage(), true)."\n", FILE_APPEND);

        }


    }





    static protected function _searchStrInNoQuote($str, $needle, $blWorld=true )
    {

        // убираем из строки двойной слеш
        while(true){
            $str_neu = str_replace('\\\\','\\-', $str);
            if ($str_neu==$str) {
                $str = $str_neu;
                break;
            }
            $str = $str_neu;
        }

        $resfunktion = false;
        $pos_needle = 0;
        $pos_quote=0;

        if ($blWorld)
            $sReg="/\b".$needle."\b/i";
        else
            $sReg="/".$needle."/i";

        while (preg_match($sReg, $str, $res_needle, PREG_OFFSET_CAPTURE, $pos_needle )) {

            $pos_needle = $res_needle[0][1];


            // ищем первую каывчку
            while (preg_match("/(^|[^\\\\])([\"'])/i", $str, $res_quote, PREG_OFFSET_CAPTURE, $pos_quote)) {

                if ($res_quote[2][1]>$pos_needle) {
                    // $res_needle - правильный
                    $resfunktion = $res_needle;
                    break 2;
                }

                // ищем вторую кавычку (substr - необходимо так как если в кавычках пустая строка, то работать не будет
                $temp_pos = $res_quote[2][1]+1;
                preg_match("/(^|[^\\\\])(".$res_quote[2][0].")/i", substr($str,$temp_pos), $res_quote_2, PREG_OFFSET_CAPTURE);
                if (!$res_quote_2[2])  {
                    // вторая кавычка не найдена. Ошибка в строке.
                    return false;
                }

                $pos_quote_2 = $temp_pos + $res_quote_2[2][1];

                if ($pos_quote_2>$pos_needle) {
                    // $res_needle - находится внутри кавычек
                    $pos_needle = $pos_quote_2;
                    continue 2;
                }

                $pos_quote = $pos_quote_2+1;

            }

            // $res_needle - правильный
            $resfunktion = $res_needle;
            break;

        }

        return $resfunktion[0][1];
    }

}