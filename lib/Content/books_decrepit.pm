

################################################################################

sub select_books_decrepit { # Ветхие книги

	sql (
	
		{},
				
		books => [
		
			['cnt > ' => 0],
				
#			['label LIKE %?%' => $_REQUEST {q}],
			
			[ ORDER => 'cnt DESC'],
			[ LIMIT => 'start, 50'],
		
		],
			
		'titles',
		
	);
	
}

1;
