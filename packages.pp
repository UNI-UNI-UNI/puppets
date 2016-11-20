# REF: https://docs.puppet.com/puppet/4.8/reference/types/package.html

# 3a openssh
package { 'openssh':
        ensure => installed,
        name => 'openssh',
}

# 3b Apache
package { 'httpd':
        ensure => installed,
        name => 'httpd',
}

# 3c MySQL - mariadb
package { 'mariadb':
        ensure => installed,
        name => 'mariadb',
}
# RHEL/CentOS use TigerVNC
# 3d vncserver
package { 'vncserver':
        ensure => installed,
        name => 'tigervnc-server',
}

# 3e tmux
package { 'tmux':
        ensure => installed,
        name => 'tmux',
}

# 3f Depedancy, CentOS\RHEL 7 only has 64bit libraries
package { 'glibc.i686':
        ensure => installed,
        name => 'glibc.i686',
}

package { 'libxml2.i686':
        ensure => installed,
        name => 'libxml2.i686',
}

package { 'zlib.i686':
        ensure => installed,
        name => 'zlib.i686',
}

# 3f dia2code - install via RPM
package { 'dia2code':
        require => Package['glibc.i686', 'libxml2.i686' , 'zlib.i686'],
        provider => 'rpm',
        ensure => installed,
        source => 'http://prdownloads.sourceforge.net/dia2code/dia2code-0.8.1-1.i686.rpm',
}
# 3g lynx - requires extras
class lynx {
        # Case statement - https://docs.puppet.com/puppet/latest/reference/lang_conditional.html#if-statements
        $inst_option = $facts['os']['name'] ? {
                'Redhat' =>  '["--enablerepo","hui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional"]' ,
                default => [],
        }


        package { 'lynx':
                ensure => installed,
                name => 'lynx',
                install_options => $inst_option,
       }
}
# Call created class
class {'lynx':}
# 3h gcc
package { 'gcc':
        ensure => installed,
        name => 'gcc',
}

# 3i gdb
package { 'gdb':
        ensure => installed,
        name => 'gdb',
}

# 3j cgdb
package { 'cgdb':
        ensure => installed,
        name => 'cgdb',
}
# 3k vim
package { 'vim':
        ensure => installed,
        name => 'vim',
}

# 3l emacs
package { 'emacs':
        ensure => installed,
        name => 'emacs',
}

# EPEL needed for sshfs.
# Need extras for epels though, should be enabled
# 3 m
package { 'epel-release':
        provider => 'rpm',
        ensure => installed,
        source => 'http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm',
        #name => 'epel-release',
}

package {'sshfs':
        name => 'sshfs',
        ensure => installed,
        require => Package['epel-release'],
}


