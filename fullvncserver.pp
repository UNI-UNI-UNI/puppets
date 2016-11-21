# Installs and configured VNCServer
# Startup not working well, possibly because user information isn't defined.
class packages::fullvncserver {
        package { 'vncserver':
                ensure => installed,
                name   => 'tigervnc-server',
        }


        # Setup notify, copy file
        file { '/etc/systemd/system/vncserver@.service':
                ensure => present,
                notify => Service['vncserver'],
                mode   => '0644',
                source => '/usr/lib/systemd/system/vncserver@.service',
        }

        # No config file, watch file is vnc service file, user is specified here.
        # Set user to wilma for test
        file_line { 'vnc_exec_start':
                ensure => present,
                path   => '/etc/systemd/system/vncserver@.service',
                line   => 'ExecStart=/usr/sbin/runuser -l wilma -c "/usr/bin/vncserver %i"',
                match  => '^ExecStart=',
        }

        file_line { 'vnc_pid_file':
                ensure => present,
                path   => '/etc/systemd/system/vncserver@.service',
                line   => 'PIDFile=/home/wilma/.vnc/%H%i.pid',
                match  => '^PIDFile=',
        }

        # Doesn't start well, looks like it need some user setup
        service { 'vncserver':
                ensure  => running,
                require => Package['vncserver'],
                name    => 'vncserver',
                enable  => true,
        }


}

