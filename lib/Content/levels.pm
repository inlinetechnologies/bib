

################################################################################

sub do_update_levels {

	$_REQUEST {_label}             or die "#_label#:�� ������ ������ ������������";
	$_REQUEST {_amount} =~ /^\d+$/ or die "#_amount#:����� ���� ������ ���� �������������";
	$_REQUEST {_days}   =~ /^\-?\d+$/ or die "#_days#:����� ���� ������ ���� ������";
	
	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_levels {

	my $data = sql ('levels');

	$data -> {no_del} ||= 1 if !$_USER -> {is_mgr};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);
	
	return $data;

}

################################################################################

sub select_levels { # ������ �������

	sql (
	
		{},
		
		levels => [
				
			['UPPER(label) LIKE %?%' => $i18n -> uc ($_REQUEST {q})],
			
			[ LIMIT => 'start, 50'],
		
		],
					
	);	

}

1;
