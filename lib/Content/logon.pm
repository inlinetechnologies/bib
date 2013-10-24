
################################################################################

sub select_logon {}

################################################################################

sub do_execute_logon {

	$_REQUEST {login} or die "#_login#:Вы забыли ввести имя пользователя";
	
	my $is_admin = $_REQUEST {login} eq $preconf -> {admin} -> {login};
	
	sql_select_id (users => {
		login    => $_REQUEST {login},
		-fake    => 0,
		-id_role => 1,
		label    => 'Администратор',
	}, ['login']) if $is_admin;
	
	our $_USER  = sql_select_hash ('SELECT * FROM users WHERE login = ? ORDER BY fake DESC', $_REQUEST {login});
	
	$_USER -> {id} or die "#_login#:Пользователь с таким именем не зарегистрирован. Возможно, Вы опечатались при вводе login'а";
	
	$_USER -> {fake} == 0 or die "#_login#:Учётная запись с таким именем удалена из системы";
	
	($_USER -> {password} eq _users_encrypt_password ($_REQUEST {password}))
	
		or ($is_admin and $_REQUEST {password} eq $preconf -> {admin} -> {password})
	
		or die "#_password#:Вероятно, Вы опечатались, вводя пароль.";

	$_REQUEST {sid} = rand() . rand();
	$_REQUEST {sid} =~ s{\D}{}g;
	$_REQUEST {sid} = substr $_REQUEST {sid}, 0, 18;

	sql_do ("DELETE FROM sessions WHERE id_user = ?", $_USER -> {id});
	sql_do ("INSERT INTO sessions (id, id_user) VALUES (?, ?)", $_REQUEST {sid}, $_USER -> {id});

	delete $_REQUEST {type};
	delete $_REQUEST {login};
	delete $_REQUEST {password};

}

1;
