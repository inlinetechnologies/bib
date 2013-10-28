label => 'Уровни доступа',

columns => {

	label    => 'string',         # Наименование
	amount   => 'int',            # Максимум книг
	days     => 'int',            # Максимальная длительность

},

#keys => {
#	id_user => 'id_user',
#},

data => [
	{id => 1, fake => 0, label => 'базовый',     amount => 2, days => 5},
	{id => 2, fake => 0, label => 'расширенный', amount => 5, days => 10},
],
