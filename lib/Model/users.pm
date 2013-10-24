columns => {

	label       => 'string', # ФИО
	mail        => 'string', # E-mail
	phone       => 'string', # Телефон
	is_lib      => 'checkbox', # Является ли библиотекарем
	is_mgr      => 'checkbox', # Является ли менеджером
	id_level    => 'select(levels)', # Уровень доверия
	id_user_client => 'select(users)', # Текущий клиент

},

keys => {
	label              => 'label',
},
