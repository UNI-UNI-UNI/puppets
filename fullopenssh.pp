# Installs and configures openssh package
# Ensures root login is disabled.
class packages::fullopenssh {
        package { 'openssh':
                ensure => installed,
                name   => 'openssh',
        }
        file { '/etc/ssh/sshd_config':
                mode    => '0600',
                owner   => 'root',
                group   => 'root',
                notify  => Service['sshd'],
                require => Package['openssh'],
        }


        service { 'sshd':
                ensure  => running,
                require => Package['openssh'],
                enable  => true,
        }

        # Disable Root SSH - 4a
        file_line { 'disable_root_ssh':
                ensure => present,
                path   => '/etc/ssh/sshd_config',
                line   => 'PermitRootLogin no',
                match  => '^#?PermitRootLogin',
        }
}

# Note I couldn't get the file subscription to work, it looked like it should, said it had subscribed…, but when I went to check in, it didn't work.
# [root@lsc7pup manifests]# puppet agent -td | grep -i sshd
# Debug: /File[/etc/ssh/sshd_config]/seluser: Found seluser default 'system_u' for /etc/ssh/sshd_config
# Debug: /File[/etc/ssh/sshd_config]/selrole: Found selrole default 'object_r' for /etc/ssh/sshd_config
# Debug: /File[/etc/ssh/sshd_config]/seltype: Found seltype default 'etc_t' for /etc/ssh/sshd_config
# Debug: /File[/etc/ssh/sshd_config]/selrange: Found selrange default 's0' for /etc/ssh/sshd_config
# Debug: /Stage[main]/Packages::Fullopenssh/File[/etc/ssh/sshd_config]/require: subscribes to Package[openssh]
# Debug: /Stage[main]/Packages::Fullopenssh/File[/etc/ssh/sshd_config]/notify: subscribes to Service[sshd]
# Debug: /Stage[main]/Packages::Fullopenssh/Service[sshd]/require: subscribes to Package[openssh]
# Debug: /Stage[main]/Packages::Fullopenssh/File_line[disable_root_ssh]: Adding autorequire relationship with File[/etc/ssh/sshd_config]
# Debug: Executing: '/bin/systemctl is-active sshd'
# Debug: Executing: '/bin/systemctl is-enabled sshd'
# I probably missed something basic here.
