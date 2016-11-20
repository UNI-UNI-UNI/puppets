
# Agent configuration
# Disable Root SSH - 4a
file_line { 'disable_root_ssh':
        ensure => present,
        path => '/etc/ssh/sshd_config',
        line => 'PermitRootLogin no',
        match => '^#?PermitRootLogin',
}

class apache {

        file { "/var/www/s3462188":
                ensure => directory,
                mode => '0755',
        }

        file_line { 'docRoot':
                ensure => present,
                path => '/etc/httpd/conf/httpd.conf',
                line => 'DocumentRoot "/var/www/s3462188"',
                match => '^DocumentRoot',
        }
}
# Becca sudo access - 4c
file_line { 'becca_priv':
        ensure => present,
        path => '/etc/sudoers',
        line => 'becca ALL=(ALL:ALL) ALL',
}

# Fred sudo access via group - 4d
# Ensure /usr/local/bin is in path - 4e, 7
file_line { 'path':
        ensure => present,
        path => '/etc/bashrc',
        line => 'export PATH=$PATH:/usr/local/bin',
}


class {'apache':}
