
################################################################################

sub draw_item_of_users {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'users', name => action_type_label},
				{type => 'users', name => $data -> {label}, id => $data -> {id}},
			],
			additional_buttons => [
				{
					icon  => 'tv',
					label => 'Это &ndash; мой клиент',
					href  => {action => 'mark'},
					target => 'invisible',
					confirm => "$data->{label} &ndash; это тот, кто сейчас перед Вами?",
					off   =>
						!$data -> {id_level}
						|| $data -> {id} == $_USER -> {id_user_client}
						|| !$_USER -> {is_lib}
						|| !$_REQUEST {__read_only}
					,
				},
				{
					icon  => 'tv_1',
					label => 'Всё, готово',
					href  => {action => 'unmark'},
					target => 'invisible',
					confirm => "Вы теперь свободны?",
					off   =>
						$data -> {id} != $_USER -> {id_user_client}
						|| !$_USER -> {is_lib}
						|| !$_REQUEST {__read_only}
					,
				},
			],
			
		},
		
		$data,
		
		[

			{
				name    => 'id',
				label   => 'Номер карточки',
				type    => 'static',
			},
			{
				name    => 'label',
				label   => 'ФИО',
				size    => 80,
				max_len => 255,
			},
			{
				name    => 'phone',
				size    => 80,
				max_len => 255,
			},
			{
				name    => 'mail',
				label   => 'E-mail',
				size    => 80,
				max_len => 255,
				href    => "mailto:$data->{mail}",
			},
			
			'is_lib',
			'is_mgr',

			{
				name   => 'id_level',
				empty  => '',
			},
			{
				name       => 'login',
				label      => 'Login',
				size       => 40,
				read_only  => $data -> {login} eq $preconf -> {admin} -> {login},
				add_hidden => 1,
			},
			{
				name       => 'password',
				label      => 'Пароль',
				type       => 'password',
				size       => 40,
			},

		],

	)

	.

	draw_table (

		sub {
		
			__d ($i);
		
			draw_cells ({
				href => "/?type=books&id=$i->{id}",
				bgcolor => ($i -> {dt_to} || '9999') le today () ? '#ffddaa' : undef,
			},[				
				{
					label => $i -> {no},
					status => {icon =>
						!$i -> {dt_to} ? 100 :
						101
					}
				},
				$i -> {title} -> {label},
				$i -> {title} -> {author},
				$i -> {dt_to},
			]),

		},
		
		$data -> {books},
		
		{
			
			title => {label => 'Выданные книги'},
			
			off   => !$_REQUEST{__read_only},
			
			name  => 't1',
						
			top_toolbar => [{
				keep_params => ['type', 'id'],
			},
				
			],
			
		}

	)

	;

}



################################################################################

sub draw_users {

	my ($data) = @_;

	return

		draw_table (

			[
				'№',
				'ФИО',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=users&id=$$i{id}",
				},[
	
					$i -> {id},
					$i -> {label},

				])

			},

			$data -> {users},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => '?type=users&action=create',
						off   => !$_USER -> {is_mgr},
					},
					{
						type  => 'input_text',
						label => '№',
						size  => 5,
						name  => 'id',
						keep_params => [],
					},
					{
						type  => 'input_text',
						label => 'Искать',
						name  => 'q',
						keep_params => [],
					},

#					{
#						type   => 'input_select',
#						name   => 'id_...',
#						values => $data -> {...},
#						empty  => '[Все ...]',
#					},

					{
						type    => 'pager',
					},

					fake_select (),

				],
				
			}

		);

}

1;
