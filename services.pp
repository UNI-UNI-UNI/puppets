
# Can't seem to manage runlevels directly - https://tickets.puppetlabs.com/browse/PUP-2664
# General enable => true will cover runlevel 3
# REF: https://docs.puppet.com/puppet/4.8/reference/types/service.html
class httpd {
        service { 'httpd':
                name => 'httpd',
                ensure => running,
                enable => true,
        }

        file { '/etc/httpd/httpd.conf':
                notify  => Service['httpd'],  # this sets up the relationship
                mode    => '0600',
                owner   => 'root',
                group   => 'root',
                require => Package['httpd'],
        }


}

class openssh {
        service { 'openssh':
                name => 'openssh',
                ensure => running,
                enable => true,
        }

        file { '/etc/ssh/sshd_config':
                notify => Service['sshd'],
                mode => '0600',
                owner => 'root',
                group => 'root',
                require => Package['openssh-server'],
        }
}

service { 'vncserver':
        name => 'vncserver',
        ensure => running,
        enable => true,
}

service { 'httpd':
        name => 'httpd',
        ensure => running,
        enable => true,
}
