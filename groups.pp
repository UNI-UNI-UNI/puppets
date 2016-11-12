
# Group REF https://docs.puppet.com/puppet/latest/reference/types/group.html
# Create sysadmin group
group { 'sysadmin':
	ensure => 'present',
}
# Create cars group
group { 'cars':
	ensure => 'present',
}
# Create trucks group
group { 'trucks':
	ensure => 'present',
}
# Create ambulances group
group { 'ambulances':
	ensure => 'present',
}

