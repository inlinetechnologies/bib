

################################################################################

sub do_create_users { # И что это за процедура?

	$_REQUEST {id} = sql_do_insert (users => {
		id_level  => 1,
	});

}



################################################################################

sub do_unmark_users {

	sql_do ('UPDATE users SET id_user_client = NULL WHERE id = ?', $_USER -> {id});

}

################################################################################

sub do_mark_users {

	sql_do ('UPDATE users SET id_user_client = ? WHERE id = ?', $_REQUEST {id}, $_USER -> {id});

}

################################################################################

sub do_update_users {

	$_REQUEST {_label} or die "#_label#:Вы забыли ввести ФИО";
	
	if ($_REQUEST {_login}) {
	
		if ($_REQUEST {_login} eq $preconf -> {admin} -> {login}) {
		
			my $data = sql ('users');
			
			$_REQUEST {_login} eq $data -> {login} or die "#_login#:Извините, имя '$_REQUEST{_login}' зарезервировано для администратора системы.";
			
		}
		
		vld_unique ('users', {field => 'login'}) or die "#_login#:Извините, login \"$_REQUEST{_login}\" в настоящее время занят.";
		
		if ($_REQUEST {_password}) {
							
			$_REQUEST {_password} = _users_encrypt_password ($_REQUEST {_password});
	
		}
		else {
	
	        	delete $_REQUEST {_password};
	
		}
	
	}
	
	do_update_DEFAULT ();

}


################################################################################

sub get_item_of_users {

	my $data = sql ('users');

	$data -> {no_del} ||= 1 if !$_USER -> {is_mgr};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	sql ($data, books => [
		[id_user  => $data -> {id}],
		[ORDER    => 'no'],
	], 'titles(*)');

	return $data;

}

################################################################################

sub select_users { # Люди

	sql (
	
		add_vocabularies ({},
			levels => {},
		),
		
		users => [
	
			'id_level',
			'is_lib',
			'is_mgr',
			
			['UPPER(label) LIKE %?%' => $i18n -> uc ($_REQUEST {q}) || undef],
			
			[ LIMIT => 'start, 50'],
		
		],
		
		'levels',
					
	);
	
}

1;
