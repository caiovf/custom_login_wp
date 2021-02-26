<?php
	include('../../../../wp-blog-header.php');
	header("HTTP/1.1 200 OK");
	
    $user = wp_signon(array(
        'user_login'    => $_POST['login'],
        'user_password' => $_POST['password']
    ),false);

	if(is_wp_error($user)){		
		$message = $user->get_error_message();
		$status = false;		
	}else{
		$client_type = get_field('tipo_de_usuario',$user);
		$link_redirect = get_term_link($client_type,'restrito');
		
		$status = true;
		$message = "Login Realizado com sucesso. Dentro de alguns segundos voce será direcionado ";
		$link = $link_redirect;
	}

	$returnAjax = array(
        'status' => $status,
        'message' => $message,
		'link' => $link_redirect
    );

    echo json_encode($returnAjax);
?>
