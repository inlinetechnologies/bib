
################################################################################

sub do_mail_books_overdue {

	my ($books, $users) = sql_select_array (q {
	
		SELECT
			COUNT(id)
			, COUNT(DISTINCT id_user)
		FROM
			books		
		WHERE
			fake = 0
			AND id_user > 0
			AND dt_to   < current_date
	
	});
	
	send_mail ({
		to           => sql (users => [[is_mgr => 1]]),
		subject      => 'Список должников',
		text         => "В настоящее время количество просроченных книг - $books, число же должников - $users. http://$preconf->{mail}->{server_name}/?type=books_overdue",
	});

}

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
