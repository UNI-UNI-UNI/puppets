# Package is used to install mysql
class packages::fullmysql {

        package { 'mariadb-server':
                ensure => installed,
                name   => 'mariadb-server',
        }
        package { 'mariadb':
                ensure => installed,
                name   => 'mariadb',
        }
        service { 'mariadb':
                ensure => running,
                name   => 'mariadb',
                enable => true,
        }

}
