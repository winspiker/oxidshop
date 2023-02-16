<?php

session_start();

echo "<pre>";
if ($_REQUEST["test_start"]) {
    $_SESSION["session_test"]=$_REQUEST["test_start"];
    echo "session save\n";

}


print_r($_SESSION);

echo "</pre>";

?>


<form method="post" action="/test_session_child.php">

    <input type="submit">

</form>
