
# Can't seem to manage runlevels directly - https://tickets.puppetlabs.com/browse/PUP-2664
# REF: https://docs.puppet.com/puppet/4.8/reference/types/service.html
service { 'httpd':
        name => 'httpd',
        ensure => running,
        enable => true,
}

service { 'openssh':
        name => 'openssh',
        ensure => running,
        enable => true,
}

service { 'sshfs':
        name => 'sshfs',
        ensure => running,
        enable => true,
}

service { 'httpd':
        name => 'httpd',
        ensure => running,
        enable => true,
}

service { 'httpd':
        name => 'httpd',
        ensure => running,
        enable => true,
}

