

################################################################################

sub draw_books_mint {

	my ($data) = @_;

	return

		draw_table (

			[
				{
					label  => 'Наименование',
					order  => 'books.label',
				},
				{
					label  => 'Номер',
				},
				
			],

			sub {
				
				my @today = Date::Calc::Today ();

				draw_cells ({
					href => "/?type=books&id=$$i{id}",
				},[

					$i -> {title} -> {label},
					$i -> {no},
					
				])

			},

			$data -> {books},

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

				],
				
			}

		);

}

1;
