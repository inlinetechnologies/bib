

################################################################################

sub select_books_mint { # ���������� ����������

	sql (
	
		{},
				
		books => [
	
			['cnt...' => 0],
			
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],

		'titles',
				
	);
	

}


1;
