

################################################################################

sub draw_titles_boring {

	my ($data) = @_;

	return

		draw_table (

			[
				'Наименование',
				'Среднее число выдач в месяц',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=titles&id=$$i{id}",
				},[
	
					$i -> {label},
					{
						label => 0 + $i -> {freq},
#						picture => '###,#',
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
						icon  => 'print',
						label => 'Ms Excel',
						href  => {xls => 1},
						target => 1,
					},

#					{
#						type  => 'input_text',
#						label => 'Искать',
#						name  => 'q',
#						keep_params => [],
#					},
#
#					{
#						type   => 'input_select',
#						name   => 'id_...',
#						values => $data -> {...},
#						empty  => '[Все ...]',
#					},
#
#					{
#						type    => 'pager',
#					},

					fake_select (),

				],

			}

		);

}


1;
