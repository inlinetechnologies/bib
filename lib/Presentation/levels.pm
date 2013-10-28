

################################################################################

sub draw_item_of_levels {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'levels', name => action_type_label},
				{type => 'levels', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[

			{
				name    => 'label',
				label   => 'Наименование',
				size    => 40,
				max_len => 255,
			},
			{
				name    => 'amount',
				size    => 5,
			},
			{
				name    => 'days',
				size    => 5,
			},

		],

	)

}

################################################################################

sub draw_levels {

	my ($data) = @_;

	return

		draw_table (

			[
				'Наименование',
				'Максимум книг',
				'Максимальная длительность',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=levels&id=$$i{id}",
				},[
	
					$i -> {label},
					{
						label => $i -> {amount},
						picture => '###',
					},
					{
						label => $i -> {days},
						picture => '###',
					},

				])

			},

			$data -> {levels},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => '?type=levels&action=create',
					},
					
					{
						type  => 'input_text',
						label => 'Искать',
						name  => 'q',
						keep_params => [],
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
