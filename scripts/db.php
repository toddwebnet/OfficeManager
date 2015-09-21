<?php

//print encryptPassword("password");


$username = "root";
$password = "";
$database = "office_manager";
$server   = "127.0.0.1";

$dbh = new dbh($username, $password, $database, $server);

$fileList = ConvertDirArrayToList( getcwd(), dirToArray(getcwd())  );

$sqlArray = getSQLArray($fileList);


$count = count($sqlArray);
print "\n" . number_format($count) . " transactions to process:\n";
$c = 0;
foreach($sqlArray as $sql)
{
    $c++;
    if($c % 200 == 0) {
        print ".";
    }
    if($c % 10000 == 0)
    {print " - " . percentage($c,$count) . " \n";}
    if(strlen(trim($sql))>0)
    {
        $dbh->runSQL($sql);
    }

}
print " - " . percentage($c,$count) . " \nCompleted\n\n";

function percentage($top, $bottom)
{
    return round($top*100/$bottom,0) . "%";

}
function encryptPassword($password)
{
    $options = [
        'cost' => 12,
    ];
    return password_hash($password, PASSWORD_BCRYPT, $options)."\n";
}
function getSQLArray($fileList)
{
    $return = array();
    foreach($fileList as $file)
    {
        $contents = file_get_contents($file);
        $return = array_merge($return, explode(";", $contents));
    }
    return $return;
}


function ConvertDirArrayToList($root, $array)
{
    $return = array();
    foreach($array as $dir=>$o)
    {
        if(is_array($o))
        {
            $return = array_merge($return,
                ConvertDirArrayToList($root . "/" . $dir,  $o)
            );
        }
        else
        {
            if (pathinfo($o)["extension"] == "sql") {
                $return[] = $root . "/" . $o;
            }
        }

    }
    return $return;

}

function dirToArray($dir) {

    $result = array();

    $cdir = scandir($dir);
    foreach ($cdir as $key => $value)
    {
        if (!in_array($value,array(".","..")))
        {
            if (is_dir($dir . DIRECTORY_SEPARATOR . $value))
            {$result[$value] = dirToArray($dir . DIRECTORY_SEPARATOR . $value);}
            else
            {$result[] = $value;}
        }
    }

    return $result;
}




class dbh
{
    private $db;

    function __construct($username, $password, $database, $server)
    {
        $this->db = new PDO('mysql:host=' . $server . ";dbname=" . $database . ";charset=utf8", $username,  $password);
        $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $this->db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    }


    function runSQL($sql)
    {
        try {
            $this->db->query($sql);
        } catch (PDOException $ex) {
            echo "An Error occured!:\n\n";
            print $ex->getMessage();
            print "\n\n $sql\n\n";
            print "\n\n $sql\n\n";
            die();
        }
    }

}



?>