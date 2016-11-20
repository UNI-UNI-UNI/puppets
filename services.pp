
# Can't seem to manage runlevels directly - https://tickets.puppetlabs.com/browse/PUP-2664
# General enable	=> true will cover runlevel 3
# REF: https://docs.puppet.com/puppet/4.8/reference/types/service.html
class httpd {
        service { 'httpd':
                name	=> 'httpd',
                ensure	=> running,
                enable	=> true,
        }

        file { '/etc/httpd/httpd.conf':
                notify	=> Service['httpd'],  # this sets up the relationship
                mode	=> '0600',
                owner	=> 'root',
                group	=> 'root',
                require	=> Package['httpd'],
        }


}

class openssh {
        package { 'openssh':
                ensure => installed,
                name => 'openssh',
        }

        file { '/etc/ssh/sshd_config':
                notify	=> Service['sshd'],
                mode	=> '0600',
                owner	=> 'root',
                group	=> 'root',
                require	=> Package['openssh'],
        }

        service { 'sshd':
                require => Package['openssh'],
                ensure	=> running,
                enable	=> true,
        }

}

class vncserver {
        package { 'vncserver':
                ensure => installed,
                name => 'tigervnc-server',
        }


        # Setup notify, copy file
        file { '/etc/systemd/system/vncserver@.service':
                notify	=> Service['vncserver'],
                mode	=> '0644',
                source	=> '/usr/lib/systemd/system/vncserver@.service',
                ensure	=> present, 
        }

        # No config file, watch file is vnc service file, user is specified here.
        # Set user to wilma for test
        file_line { 'vnc_exec_start':
                ensure => present,
                path => '/etc/systemd/system/vncserver@.service',
                line => 'ExecStart=/usr/sbin/runuser -l wilma -c "/usr/bin/vncserver %i -geometry 1280x1024"',
                match => '^ExecStart=',
        }

        file_line { 'vnc_pid_file':
                ensure => present,
                path => '/etc/systemd/system/vncserver@.service',
                line => 'PIDFile=/home/wilma/.vnc/%H%i.pid',
                match => '^PIDFile=',
        }

        # Doesn't start well, looks like it need some user setup
        service { 'vncserver':
                require => Package['vncserver'],
                name	=> 'vncserver',
                ensure	=> running,
                enable	=> true,
        }
        

}        

class{'openssh':}
class{'vncserver':}
