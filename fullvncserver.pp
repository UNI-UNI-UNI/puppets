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

        # No config file to watch
        # Use the vnc service file, 
        # user is specified here.
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
