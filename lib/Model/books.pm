label => '�����',

columns => {

	id_title => '(titles)',       # ������������
	no       => 'string',         # �����
	id_user  => 'select(users)',  # ���� ������
	dt       => 'date',           # ���� �����������
	dt_from  => 'date',           # � ����� ����
	dt_to    => 'date',           # �� ����� ����
	cnt      => 'int',            # ������� �����

},

keys => {
	id_title => 'id_title',
	id_user  => 'id_user',
	no       => 'no',
},

