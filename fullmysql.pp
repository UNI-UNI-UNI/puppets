# Package is used to install mysql
class packages::fullmysql {

        package { 'mariadb':
                ensure => installed,
                name   => 'mariadb',
        }



}
