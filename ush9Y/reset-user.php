<!DOCTYPE html>
<html>

<head>
    <title>Elastic User</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->

    <!-- Theme style -->
    <link rel="stylesheet" href="admin.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/8.11.8/sweetalert2.js"></script>
    <link rel="stylesheet" type="text/css"
        href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/8.11.8/sweetalert2.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="bootstrap-tagsinput.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="bootstrap-tagsinput.min.js"></script>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>


<?php
if(isset($_POST['submit']))
{
$clientname=$_POST['clientname'];
$pass=$_POST['pass'];
if(strlen($clientname)<3)
{
echo "<body class='hold-transition register-page'>";
echo "<script language='javascript'>";
    echo "Swal.fire('Username should contain atleast 5 characters','', 'error')";
    echo "</script>";
echo "</body>";
    }
else if (strlen($pass)<6)
 {
 echo "<body class='hold-transition register-page'>";
echo "<script language='javascript'>";
    echo "Swal.fire('Password Should contain alteast 5 characters','', 'error')";
    echo "</script>";
echo "</body>";
    }
else
{
$status=shell_exec("bash /var/www/rbac/reset-password.sh -u '".$clientname."' -p '".$pass."'");
$new_str = preg_replace("/\s+/", "", $status);
echo $new_str;
if ($new_str=="user-not-exist")
{
	echo "<body class='hold-transition register-page'>";
	echo "<script language='javascript'>";
   	echo "Swal.fire('User Dosen't Exist in the System','', 'error')";
    	echo "</script>";
	echo "</body>";
}
else {
        echo "<body class='hold-transition register-page'>";
        echo "<script language='javascript'>";
        echo "Swal.fire('Password Updated Successfully','', 'success')";
        echo "</script>";
        echo "</body>";
}
}
}
?>

<body class="hold-transition register-page">
    <div class="register-box">
        <div class="register-box-body">
            <div class="register-logo">
                <img width="116" height="56" src="https://inq.inc/wp-content/uploads/2020/06/inq-logo.png"
                    class="attachment-full size-full" alt="">
            </div>

            <div class="register-logo">
                <div id="container">

                    <h4><strong>Nigeria</strong> </h4>
                </div>

                <form method="post" enctype="multipart/form-data">
                    <div class="form-group has-feedback">
                        <input type="text" class="form-control" name="clientname" placeholder="Username">
                    </div>
                    <div class="form-group has-feedback">
                        <input type="password" class="form-control" name="pass" placeholder="Password">
                    </div>
            </div>
            <br />
            <center>
                <button type="submit" name="submit" style="width: 130px" class="btn btn-primary btn-block btn-flat">Reset Password</button>
            </center>
            </form>
            <br />

        </div>
        <!-- /.form-box -->
    </div>
    <!-- /.register-box -->
</body>

</html>
