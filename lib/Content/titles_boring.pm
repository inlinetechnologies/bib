

################################################################################

sub select_titles_boring { # Неинтересные книги

	my $data = {};

	$data -> {titles} = sql_select_all (q {
	
		SELECT
			titles.*
			, stats.freq
		FROM
			titles
			LEFT JOIN (
				SELECT
					books.id_title
					, 30 * AVG(1.0 * books.cnt / (1 + current_date - books.dt::date)) freq
				FROM
					books
				GROUP BY
					books.id_title
			) stats ON titles.id = stats.id_title
		WHERE
			titles.fake = 0
		ORDER BY
			stats.freq NULLS FIRST
		
	});
	
	$data;	

}

1;
