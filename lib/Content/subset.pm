
################################################################################

sub select_subset {

	$_USER -> {is_mgr} = $_USER -> {is_lib} = 1 if $_USER -> {login} eq $preconf -> {admin} -> {login};

	undef;

}

1;
