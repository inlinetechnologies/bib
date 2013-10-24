

################################################################################

sub draw_books_overdue {

	my ($data) = @_;

	return

		draw_table (

			[
				{
					label  => 'ФИО',
					order  => 'users.label',
				},
				{
					label  => 'Телефон',
				},
				{
					label  => 'Наименование',
					order  => 'books.label',
				},
				{
					label  => 'Номер',
				},
				{
					label  => 'Дней',
					order  => 'dt_to',
				},
				
			],

			sub {
				
				my @today = Date::Calc::Today ();

				draw_cells ({
					href => "/?type=books&id=$$i{id}",
				},[

					$i -> {user} -> {label},
					$i -> {user} -> {phone},
					$i -> {title} -> {label},
					$i -> {no},
					{
						label   => (Date::Calc::Delta_Days ((split /\-/, $i -> {dt_to}), @today)),
						picture => '### ###',
					},

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
