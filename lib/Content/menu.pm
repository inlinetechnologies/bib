################################################################################

sub select_menu {
	
	return [
		
		{
			name  => 'users',
			label => 'Люди',
			items => [
				{
					name  => 'books_overdue',
					label => 'Должники',
					off   => !$_USER -> {is_mgr},
				},		
			],
		},
		
		($_USER -> {id_user_client} ? {
			href  => "/?type=users&id=$_USER->{id_user_client}",
			label => sql ('users(label)' => $_USER->{id_user_client}),
		} : ()),
		
		{
			name  => 'titles',
			label => 'Книги',
			items => [
#				{
#					name  => 'titles_boring',
#					label => 'Неинтересные',
#					off   => !$_USER -> {is_mgr},
#				},
				{
					name  => 'books_mint',
					label => 'Нечитанные',
					off   => !$_USER -> {is_mgr},
				},
			],
		},
		{
			name  => 'rubrics',
			label => 'Рубрики',
			off   => !$_USER -> {is_mgr},
		},

	];

}

1;
