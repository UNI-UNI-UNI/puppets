class openssh {
        package { 'openssh':
                ensure => installed,
                name => 'openssh',
        }

        file { '/etc/ssh/sshd_config':
                notify  => Service['sshd'],
                mode    => '0600',
                owner   => 'root',
                group   => 'root',
                require => Package['openssh'],
        }

        service { 'sshd':
                require => Package['openssh'],
                ensure  => running,
                enable  => true,
        }

}

