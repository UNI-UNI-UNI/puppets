class packages::mysql {

        package { 'mariadb':
                ensure => installed,
                name => 'mariadb',
        }





}
