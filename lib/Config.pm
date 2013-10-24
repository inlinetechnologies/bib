use Digest::SHA1;

our $conf = {

	page_title => '����������',
	
	portion => 15,
	session_timeout => 30,
	
	max_len => 50,
	
	number_format => {
		-thousands_sep   => ' ',
		-decimal_point   => ',',
	},
	
	core_auto_esc   => 2,
	core_auto_edit  => 1,
	core_show_icons => 1,
	core_hide_row_buttons => 2,
	core_recycle_ids => 0,
	core_unlimit_xls => 1,
	
	kb_options_menu    => {alt => 1},
	kb_options_buttons => {ctrl => 1},
		
	i18n => {
	
		RUS => {
		
			edit   => '������������� (F4)',
			cancel => '��������� (Esc)',
			ok     => '��������� (Ctrl-Enter)',
			delete => '������� (Ctrl-Del)',
			confirm_open_vocabulary => '������� ���� �����������?',
		
		}
	
	}

};

our @month_names = ('������', '�������', '�����', '������', '���', '����', '����', '�������', '��������', '�������', '������', '�������');

our $DB_MODEL = {

	default_columns => {
		id   => {TYPE_NAME  => 'int', _EXTRA => 'auto_increment', _PK    => 1},
		fake => {TYPE_NAME  => 'bigint'},
	},

};

################################################################################

sub today {

	dt_iso (Date::Calc::Today ());

}

################################################################################

sub now {

	sprintf ('%04d-%02d-%02d %02d:%02d:%02d', Date::Calc::Today_and_Now ());

}

################################################################################

sub _users_encrypt_password { Digest::SHA1::sha1_hex (Encode::encode_utf8 ($_[0])) }

1;