

################################################################################

sub do_take_books {

	sql_do ('UPDATE books SET id_user = NULL, dt_to = NULL WHERE id = ?', $_REQUEST {id});	

}

################################################################################

sub do_undelete_books {

	my $data = sql (books => $_REQUEST {id});	

	vld_unique (books => {field => 'no', value => $data -> {no}}) or die "#_no#:İòîò íîìåğ çàğåãèñòğèğîâàí äëÿ àêòóàëüíîé êíèãè. Âîññòàíîâëåíèå íåâîçìîæíî";

	sql_do ("UPDATE books SET fake = 0 WHERE id = ?", $_REQUEST {id});

	esc ();

}

################################################################################

sub recalculate_books {

	my $data = sql (books => $_REQUEST {id});
	
	my ($cnt, $cnt_free) = sql_select_array (qq {
	
		SELECT
			COUNT(*),
			SUM(CASE WHEN id_user IS NOT NULL THEN 1 ELSE 0 END)
		FROM
			books
		WHERE
			fake = 0
			AND id_title = ?
			
	}, $data -> {id_title});
	
	sql_do (
	
		'UPDATE titles SET cnt = ?, cnt_free = ? WHERE id = ?',
	
		$cnt,
		
		$cnt_free,
		
		$data -> {id_title},
		
	);

}

################################################################################

sub do_update_books {

	$_REQUEST {_no} or die "#_no#:Âû çàáûëè ââåñòè íîìåğ";
	
	vld_unique (books => {field => 'no'}) or die "#_no#:İòîò íîìåğ óæå çàğåãèñòğèğîâàí";

	$_REQUEST {_dt} or die "#_dt#:Âû çàáûëè ââåñòè äàòó ïîñòóïëåíèÿ";
	
	vld_date ('dt');
	
	$_REQUEST {_dt} le today () or die "#_dt#:İòà äàòà åù¸ íå íàñòóïèëà";
	
	my $data = sql (books => $_REQUEST {id}, 'titles');

	$_REQUEST {_dt} ge $data -> {title} -> {year} . '-01-01' or die "#_dt#:Êíèãà íå ìîãëà ïîñòóïèòü â áèáëèîòåêó ğàíåå, ÷åì áûëà èçäàíà";

	do_update_DEFAULT ();
	
	esc ();

}

################################################################################

sub get_item_of_books { # İêçåìïëÿğû êíèã

	my $data = sql (books => $_REQUEST {id}, 'titles', 'users');

	$data -> {dt} ||= today ();

	$data -> {no_del} ||= 1 if !$_USER -> {is_mgr};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}

1;
