

################################################################################

sub draw_item_of_books {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],

			additional_buttons => [
				{
					icon  => 'right',
					label => 'Âûäàòü...',
					href  => {type => 'books_to_give'},
					keep_esc => 1,
					off   =>
						$data -> {id_user}
						|| !$_USER -> {is_lib}
						|| !$_REQUEST {__read_only}
					,
				},
				{
					icon   => 'left',
					label  => 'Âîçâğàò',
					href   => {action => 'take'},
					confirm => "$data->{user}->{label} äåéñòâèòåëüíî âåğíóë ıòó êíèãó?",
					target => 'invisible',
					off   =>
						!$data -> {id_user}
						|| !$_USER -> {is_lib}
						|| !$_REQUEST {__read_only}
					,
				},
			],
			
			no_edit => $data -> {no_del} || $data -> {no},
			
			path => [
				{type => 'books', name => "$data->{title}->{author}. $data->{title}->{label}"},
				{type => 'books', name => $data -> {no}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[

			{
				name    => 'title.label',
				label   => 'Íàèìåíîâàíèå',
				type    => 'static',
			},
			{
				name    => 'title.author',
				label   => 'Àâòîğ',
				type    => 'static',
			},
			{
				name    => 'no',
				size    => 80,
			},
			{
				name    => 'dt',
			},
			[
			{
				name    => 'user.label',
				label   => 'Êîìó âûäàíà',
				type    => 'static',
				href    => "/?type=users&id=$data->{id_user}",
				off     => !$data -> {id_user},
			},
			{
				name    => 'user.phone',
				label   => 'Òåëåôîí',
				type    => 'static',
				off     => !$data -> {id_user},
			},
			],
			{
				name    => 'dt_to',
				label   => 'Äî êàêîãî ÷èñëà',
				type    => 'static',
				off     => !$data -> {id_user},
			},

		],

	)

}


1;
