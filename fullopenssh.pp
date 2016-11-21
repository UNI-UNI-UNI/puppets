# Installs and configures openssh package
# Ensures root login is disabled.
class packages::fullopenssh {
        package { 'openssh':
                ensure => installed,
                name   => 'openssh',
        }
        # Disable Root SSH - 4a
        file_line { 'disable_root_ssh':
                ensure => present,
                path   => '/etc/ssh/sshd_config',
                line   => 'PermitRootLogin no',
                match  => '^#?PermitRootLogin',
        }

        # Notify service 
        file { '/etc/ssh/sshd_config':
                notify  => Service['sshd'],
                mode    => '0600',
                owner   => 'root',
                group   => 'root',
                require => Package['openssh'],
        }

        service { 'sshd':
                ensure  => running,
                require => Package['openssh'],
                enable  => true,
        }

}

