

################################################################################

sub select_titles_boring { # Неинтересные книги

	sql (
	
		add_vocabularies ({},
			users => {},
		),
		
		titles_boring => [
	
			'id_user',
			
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
			
		'users' # , other joined tables
		
	);
	

}


1;
