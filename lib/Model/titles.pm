label => '�����',

columns => {

	label      => 'string',          # ������������
	author     => 'string',          # �����
	publishing => 'string',          # ������������
	id_rubric  => 'select(rubrics)', # �������
	year       => 'int',             # ���
	cnt        => 'int',             # ���������� �����������
	cnt_free   => 'int',             # ���������� ��������� �����������
	notes      => 'text',            # ��������

},

keys => {
	label => 'label',
},

