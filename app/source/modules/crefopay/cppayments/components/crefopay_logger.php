<?php

class crefoPayLogger
{
    private $cpLogFile;
    private $cpLogLevel = 0;

    function __construct()
    {
        $cpConfig = oxRegistry::getConfig();

        $cpLogLevel = $cpConfig->getConfigParam('CrefoPayLogLevel');
        $cpLogFileName = $cpConfig->getConfigParam('CrefoPayLogFile');

        if (strlen($cpLogFileName) > 1)
        {
            $this->cpLogFile = $cpConfig->getLogsDir() . $cpLogFileName;
        } else {
            $this->cpLogFile = $cpConfig->getLogsDir() . 'crefopay.log';
        }

        // Logdatei generieren, falls nicht vorhanden
        if (! file_exists($this->cpLogFile)) {
            try {
                $cpfd = fopen($this->cpLogFile, "a");
                fwrite($cpfd, self::timestamp() . " Logfile erstellt\n");
                fclose($cpfd);
            } catch (Exception $e) {
                error_log($e->getMesage());
            }
        }
    }

    private function timestamp($timestamp = null)
    {
        if ($timestamp == null)
        {
            $timestamp = time();
        }
        return "[" . date("d:m:Y-H:i:s", $timestamp) . "]";
    }

    public function log($level, $file, $message, $newline = true)
    {
        $cpMessage = self::timestamp();
        
        switch ($level) {
            case '0':
                $cpMessage .= '[DEBUG]';
                break;
            case '1':
                $cpMessage .= '[WARN]';
                break;
            case '2':
                $cpMessage .= '[ERROR]';
                break;
            case '3':
                $cpMessage .= '[CRITICAL]';
                break;
            default:
                $cpMessage .= '[UNKNOWN]';
                break;
        }

        $cpMessage .= "[" . basename($file) . "]:";
        $cpMessage .= $message;
        if ($newline)
        {
            $cpMessage .= "\n";
        }
        
        $cpfd = fopen($this->cpLogFile, "a");
        fwrite($cpfd, $cpMessage);
        fclose($cpfd);   
    }

    public function debug($file, $message, $nl = true)
    {
        if ($this->getLevel() == 0) {
            $this->log(0, $file, $message, $nl);
        }
        return;
    }

    public function warn($file, $message, $nl = true)
    {
        if ($this->getLevel() <= 1)
        {
            $this->log(1, $file, $message, $nl);
        }
    }

    public function error($file, $message, $nl = true)
    {
        if ($this->getLevel() <= 2)
        {
            $this->log(2, $file, $message, $nl);
        }
    }

    public function crit($file, $message, $nl = true)
    {
        $this->log(3, $file, $message, $nl);
    }

    public function getLevel()
    {
        return $this->cpLogLevel;
    }

}