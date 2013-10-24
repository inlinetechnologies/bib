label => 'Книги',

columns => {

	id_title => '(titles)',       # Наименование
	no       => 'string',         # Номер
	id_user  => 'select(users)',  # Кому выдана
	dt       => 'date',           # Дата поступления
	dt_from  => 'date',           # С какой даты
	dt_to    => 'date',           # До какой даты
	cnt      => 'int',            # Счётчик выдач

},

keys => {
	id_title => 'id_title',
	id_user  => 'id_user',
	no       => 'no',
},

