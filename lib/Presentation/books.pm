

################################################################################

sub draw_item_of_books {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],

			additional_buttons => [
				{
					icon  => 'right',
					label => '������...',
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
					label  => '�������',
					href   => {action => 'take'},
					confirm => "$data->{user}->{label} ������������� ������ ��� �����?",
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
				label   => '������������',
				type    => 'static',
			},
			{
				name    => 'title.author',
				label   => '�����',
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
				label   => '���� ������',
				type    => 'static',
				href    => "/?type=users&id=$data->{id_user}",
				off     => !$data -> {id_user},
			},
			{
				name    => 'user.phone',
				label   => '�������',
				type    => 'static',
				off     => !$data -> {id_user},
			},
			],
			{
				name    => 'dt_to',
				label   => '�� ������ �����',
				type    => 'static',
				off     => !$data -> {id_user},
			},

		],

	)

}


1;
