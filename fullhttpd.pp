
class packages:fullhttpd {
       # 4b - Apache Create directory
        file { "/var/www/s3462188":
                ensure => directory,
                mode => '0755',
        }
        # Apache set docroot
        file_line { 'docRoot':
                ensure => present,
                path => '/etc/httpd/conf/httpd.conf',
                line => 'DocumentRoot "/var/www/s3462188"',
                match => '^DocumentRoot',
        }
 

        service { 'httpd':
                name    => 'httpd',
                ensure  => running,
                enable  => true,
        }

        file { '/etc/httpd/httpd.conf':
                notify  => Service['httpd'],  # this sets up the relationship
                mode    => '0600',
                owner   => 'root',
                group   => 'root',
                require => Package['httpd'],
        }


}

