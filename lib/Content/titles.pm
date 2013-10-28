
################################################################################

sub do_update_titles {

	$_REQUEST {_label}  or die "#_label#:�� ������ ������ ������������";
	$_REQUEST {_author} or die "#_author#:�� ������ ������ ������";
	
	$_REQUEST {_id_rubric} or die "#_id_rubric#:�� ������ ������� �������";

	$_REQUEST {_publishing} or die "#_publishing#:�� ������ ������� ������������";

	$_REQUEST {_year} or die "#_year#:�� ������ ������� ���";
	$_REQUEST {_year} =~ /^\d\d\d\d$/ or die "#_year#:�� �������� � ������� ����";
	$_REQUEST {_year} > 1900 or die "#_year#:��������, ��� �����, ��������, ���������� ����� � �����";
	
	my ($y) = Date::Calc::Today ();
	
	$_REQUEST {_year} <= $y or die "#_year#:�� ����� ����: ���� ��� ��� �� ��������";

	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_titles {

	my $data = sql ('titles');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	add_vocabularies ($data,
		rubrics => {},
	);
	
	sql ($data, books => [
		[id_title => $data -> {id}],
		[ORDER    => 'no'],
	], 'users(label, phone)');

	return $data;

}

################################################################################

sub select_titles { # �����

	sql (
	
		add_vocabularies ({},
			rubrics => {},
		),
		
		titles => [
	
			'id_rubric',

			['UPPER(label) LIKE %?%' => $i18n -> uc ($_REQUEST {q})],
			['UPPER(author) LIKE %?%' => $i18n -> uc ($_REQUEST {a})],

			[ LIMIT => 'start, 50'],
		
		],
			
		'rubrics'
		
	);	

}

1;
