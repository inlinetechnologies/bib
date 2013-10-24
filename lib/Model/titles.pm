label => 'Книги',

columns => {

	label      => 'string',          # Наименование
	author     => 'string',          # Автор
	publishing => 'string',          # Издательство
	id_rubric  => 'select(rubrics)', # Рубрика
	year       => 'int',             # Год
	cnt        => 'int',             # Количество экземпляров
	cnt_free   => 'int',             # Количество свободных экземпляров
	notes      => 'text',            # Описание

},

keys => {
	label => 'label',
},

