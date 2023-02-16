<?php

class exonn_csv_export extends oxAdminDetails
{

    public function render()
    {
        $myConfig = $this->getConfig();
        parent::render();

        return "csv_export.tpl";
    }

    public function do_export() {
        $csv_export = oxNew("csv_export");
        echo "---";
        $this->_aViewData["result"] = $csv_export->csv_do_export();
        $this->_aViewData["result"] = $csv_export->csv_do_export_stock();
        echo "+++";
        $this->_aViewData["ok"] = 1;
    }
}