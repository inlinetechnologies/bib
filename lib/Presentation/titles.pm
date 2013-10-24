

################################################################################

sub draw_item_of_titles {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'titles', name => action_type_label},
				{type => 'titles', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[

			{
				name    => 'label',
				size    => 80,
				max_len => 255,
			},
			{
				name    => 'author',
				size    => 80,
				max_len => 255,
			},
			{
				name   => 'id_rubric',
				label  => 'Рубрика',
				type   => 'select',
				values => $data -> {rubrics},
				empty  => '[Выберите рубрику]',
				other  => '/?type=rubrics',
			},
			{
				name    => 'publishing',
				size    => 80,
				max_len => 255,
			},
			{
				name    => 'year',
				size    => 4,
			},

		],

	)

	.

	draw_table (
	
		[
			[
				{
					label   => '№',
					rowspan => 2,
				},
				{
					label   => 'Поступил',
					rowspan => 2,
				},
				{
					label   => 'Выдан',
					colspan => 3,
				},
			],
			[
				'Кому',
				'До каких пор',
				'Телефон',
			],
		],

		sub {
		
			__d ($i);
		
			draw_cells ({
				href => "/?type=" . (!$i -> {id_user} && $_USER -> {id_user_client} ? 'books_to_give' : 'books') . "&id=$i->{id}",
				bgcolor => ($i -> {dt_to} || '9999') le today () ? '#ffddaa' : undef,
			},[				
				{
					label => $i -> {no},
					status => {icon =>
						!$i -> {dt_to} ? 100 :
						101
					}
				},
				$i -> {dt},
				$i -> {user} -> {label},
				$i -> {dt_to},
				$i -> {user} -> {phone},
			]),

		},
		
		$data -> {books},
		
		{
			
			title => {label => 'Экземпляры'},
			
			off   => !$_REQUEST{__read_only},
			
			name  => 't1',
						
			top_toolbar => [{
				keep_params => ['type', 'id'],
			},
				{
					icon  => 'create',
					label => '&Добавить',
					href  => "?type=books&action=create&_id_title=$data->{id}",
					off   => !$_USER -> {is_mgr},
				},
				
				fake_select (),
				
			],
			
		}

	);

}

################################################################################

sub draw_titles {

	my ($data) = @_;

	return

		draw_table (

			[
				'Наименование',
				'Автор',
				'Рубрика',
				'Издательство',
				'Год',
				'Всего',
				'Свободно',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=titles&id=$$i{id}",
				},[
	
					$i -> {label},
					$i -> {author},
					$i -> {rubric} -> {label},
					$i -> {publishing},
					$i -> {year},
					{
						label => $i -> {cnt},
						picture => '###',
					},
					{
						label => $i -> {cnt_free},
						picture => '###',
					},
				])

			},

			$data -> {titles},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => '?type=titles&action=create',
						off   => !$_USER -> {is_mgr},
					},

					{
						type  => 'input_text',
						label => 'Наименование',
						name  => 'q',
						keep_params => [],
					},
					{
						type  => 'input_text',
						label => 'Автор',
						name  => 'a',
						keep_params => [],
					},

					{
						type   => 'input_select',
						name   => 'id_rubric',
						values => $data -> {rubrics},
						empty  => '[Все рубрики]',
					},

					{
						type    => 'pager',
					},

					fake_select (),

				],

			}

		);

}

1;
