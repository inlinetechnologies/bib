
################################################################################

sub do_update_rubrics {

	$_REQUEST {_label} or die "#_label#:Âû çàáûëè ââåñòè íàèìåíîâàíèå";
	
	do_update_DEFAULT ();
	
	esc ();

}

################################################################################

sub get_item_of_rubrics {

	my $data = sql ('rubrics');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}

################################################################################

sub select_rubrics { # Ğóáğèêè

	sql (
	
		{},
		
		rubrics => [
				
			['UPPER(label) LIKE %?%' => $i18n -> uc ($_REQUEST {q})],
			
			[ LIMIT => 'start, 50'],
		
		],
					
	);
	
}

1;
