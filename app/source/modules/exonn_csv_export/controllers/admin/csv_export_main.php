<?php

class csv_export_main extends oxAdminDetails
{

    public function render()
    {
        $myConfig = $this->getConfig();
        parent::render();

        return "csv_export.tpl";
    }

    public function do_export() {

        $csv_export = oxNew("csv_export");
        $this->_aViewData["result"] = $csv_export->csv_do_export();
        $this->_aViewData["result"] = $csv_export->csv_do_export_stock();
        $this->_aViewData["ok"] = 1;
    }

    public function do_export_germes() {
        $csv_export = oxNew("csv_export");
        $this->_aViewData["result"] = $csv_export->csv_do_export_germes();
        $this->_aViewData["germes_ok"] = 1;
    }

    public function fixPrice($price) {
        $price = str_replace(".", "", $price);
        $price = str_replace(",", ".", $price);
        $price = preg_replace("/[^0-9,.]/", "", $price);
        return $price;
    }

    public function do_import() {
        $rows = $this->csv_import_file("newprice.csv", "OXARTNUM", "OXARTNUM;OXTITLE;OXPRICE;OXPRICEA;OXPRICEB;OXPRICEC;OXBPRICE");
        foreach ($rows as $row) {

                $q = "update oxarticles set "
                . ($row["OXPRICE"] != "~~~" ? "OXPRICE='" . $this->fixPrice($row["OXPRICE"]) . "', " : "")
                . "OXPRICEA='" . $this->fixPrice($row["OXPRICEA"]) . "', "
                . "OXPRICEB='" . $this->fixPrice($row["OXPRICEB"]) . "', "
                . "OXPRICEC='" . $this->fixPrice($row["OXPRICEC"]) . "', "
                . "OXBPRICE='" . $this->fixPrice($row["OXBPRICE"]) . "' where oxartnum = '".$row["OXARTNUM"]."' ";
                $db = oxDb::getDb();
                //echo $q ."<br/>";
                $db->execute($q);

        }
    }

    public function csv_import_file($file_name, $indexField, $columnsStr, $calback = "", $devider = "\t")
    {
        $columnsTitles = explode(";", $columnsStr);
        $columns = array();
        $i = 0;
        foreach ($columnsTitles as $title) {
            $columns[$title] = $i++;
        }
        //        ini_set("memory_limit", "500M");
        $myConfig = $this->getConfig();

        $file = fopen($myConfig->getConfigParam('sShopDir') . "/export/newprice.csv", "r");
        if ($file === FALSE) {
            $this->importresult = $file_name;
            return;
        }
        $result = array();
        $i = 0;

        while (($daten = fgetcsv($file, 0, $devider)) !== false) {
            if ($i == 0) {
                $i = 1;
                continue;
            }

            $row = array();
            foreach ($columns as $colname => $idx) {
                $row[$colname] = $daten[$idx];
            }

            if ($calback) {
                $this->$calback($row);
            } else {
                if ($indexField) {
                    $result[$daten[$columns[$indexField]]] = $row;
                } else {
                    $result[] = $row;
                }
            }
            $i++;
        }
        return $result;
    }
}
