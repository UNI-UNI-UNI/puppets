# Install and configure HTTPD
# Set document root to /var/www/s3462188 and ensure directory exists
class packages::fullhttpd {
        package { 'httpd':
                ensure => present,
                name   => httpd,
        }
        # 4b - Apache Create directory
        file { '/var/www/s3462188':
                ensure => directory,
                mode   => '0755',
        }
        # Apache set docroot
        file_line { 'docRoot':
                ensure => present,
                path   => '/etc/httpd/conf/httpd.conf',
                line   => 'DocumentRoot "/var/www/s3462188"',
                match  => '^DocumentRoot',
        }

        service { 'httpd':
                ensure => running,
                name   => 'httpd',
                enable => true,
        }

        file { '/etc/httpd/httpd.conf':
                notify  => Service['httpd'],  # this sets up the relationship
                require => Package['httpd'],
                mode    => '0600',
                owner   => 'root',
                group   => 'root',
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

