

################################################################################

sub draw_item_of_books_to_give {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
				
#			no_edit => $data -> {no_del} || $data -> {no},
			
			path => [
				{type => 'books', name => "$data->{title}->{author}. $data->{title}->{label}"},
				{type => 'books', name => $data -> {no}, id => $data -> {id}},
			],
			
			label_ok => '������ (Ctrl-Enter)',
			
		},
		
		$data,
		
		[

			{
				name    => 'title.label',
				label   => '������������',
				type    => static,
			},
			{
				name    => 'title.author',
				label   => '�����',
				type    => static,
			},
			{
				name    => 'no',
				size    => 80,
				type    => static,
			},
			{
				name    => 'id_user',
				empty   => '[�������� ��������]',
			},

		],

	)

	;

}


1;
