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
                mode    => '0600',
                owner   => 'root',
                group   => 'root',
                require => Package['httpd'],
        }


}

