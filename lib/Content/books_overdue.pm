

################################################################################

sub select_books_overdue { # Должники

	sql (
	
		{},
		
		books => [	
			['id_user > ' => 0],
			['dt_to < ' => today ()],
			[ LIMIT => 'start, 50'],		
		],
			
		'users(label,phone)',
		'titles',
		
	);
	

}


1;
