
################################################################################

sub select_logon {}

################################################################################

sub do_execute_ws_logon {

	my $xml = '';

	eval {

		$xml = $r -> post_data ();
		
		my $dt_from = '';
		
		if ($xml =~ /dt_from>(\d\d\d\d-\d\d-\d\d)</) {
			$dt_from = $1;
		}
		
		my $titles = sql_select_all (q {
			SELECT
				titles.author
				, titles.label
				, titles.publishing
				, titles.year
				, rubrics.label rubric
			FROM
				titles
				LEFT JOIN rubrics ON titles.id_rubric = rubrics.id
			WHERE
				titles.fake = 0
				AND titles.id IN (
					SELECT
						id_title
					FROM
						books
					GROUP BY
						id_title
					HAVING
						MIN(dt) >= ?
						
				)
		}, $dt_from);
		
		foreach my $i (@$titles) {
		
			foreach my $k (keys %$i) {
			
				$i -> {$k} = encode_entities ($i -> {$k}, '<>&"');
			
			}
		
		}
	
		out_html ({},
	qq {<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://example.org/soapformat">
	   <soapenv:Header/>
	   <soapenv:Body>
	      <soap:getNewTitlesResponse>
@{[ map {<<EOR} @$titles]}
	         <soap:title>
	            <soap:label>$_->{label}</soap:label>
	            <soap:author>$_->{author}</soap:author>
	            <soap:publishing>$_->{publishing}</soap:publishing>
	            <soap:rubric>$_->{rubric}</soap:rubric>
	            <soap:year>$_->{year}</soap:year>
	         </soap:title>
EOR
	      </soap:getNewTitlesResponse>
	   </soapenv:Body>
	</soapenv:Envelope>});

	};
	
	if ($@) {
	
		warn "SOAP body:\n $xml\n\n $@\n";
		
		$r -> status (500);

		out_html ({},
		
		qq {<env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope">
			<env:Header/>
			<env:Body>
			<env:Fault>
				<env:Code>ERROR</env:Code>
			</env:Fault>
			</env:Body>
		</env:Envelope>});
	
	}

}

################################################################################

sub do_execute_logon {

	$_REQUEST {login} or die "#_login#:Вы забыли ввести имя пользователя";
	
	my $is_admin = $_REQUEST {login} eq $preconf -> {admin} -> {login};
	
	sql_select_id (users => {
		login    => $_REQUEST {login},
		-fake    => 0,
		-id_role => 1,
		label    => 'Администратор',
	}, ['login']) if $is_admin;
	
	our $_USER  = sql_select_hash ('SELECT * FROM users WHERE login = ? ORDER BY fake DESC', $_REQUEST {login});
	
	$_USER -> {id} or die "#_login#:Пользователь с таким именем не зарегистрирован. Возможно, Вы опечатались при вводе login'а";
	
	$_USER -> {fake} == 0 or die "#_login#:Учётная запись с таким именем удалена из системы";
	
	($_USER -> {password} eq _users_encrypt_password ($_REQUEST {password}))
	
		or ($is_admin and $_REQUEST {password} eq $preconf -> {admin} -> {password})
	
		or die "#_password#:Вероятно, Вы опечатались, вводя пароль.";

	$_REQUEST {sid} = rand() . rand();
	$_REQUEST {sid} =~ s{\D}{}g;
	$_REQUEST {sid} = substr $_REQUEST {sid}, 0, 18;

	sql_do ("DELETE FROM sessions WHERE id_user = ?", $_USER -> {id});
	sql_do ("INSERT INTO sessions (id, id_user) VALUES (?, ?)", $_REQUEST {sid}, $_USER -> {id});

	delete $_REQUEST {type};
	delete $_REQUEST {login};
	delete $_REQUEST {password};

}

1;
