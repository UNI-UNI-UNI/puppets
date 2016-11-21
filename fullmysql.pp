class packages::fullmysql {

        package { 'mariadb':
                ensure => installed,
                name   => 'mariadb',
        }





}
