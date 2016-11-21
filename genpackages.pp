# Installs generic packages with no complex requirements

class packages::genpackages {

        # 3e tmux
        package { 'tmux':
                ensure => installed,
                name   => 'tmux',
        }

        # 3f Depedancy, CentOS\RHEL 7 only has 64bit libraries
        package { 'glibc.i686':
                ensure => installed,
                name   => 'glibc.i686',
        }

        package { 'libxml2.i686':
                ensure => installed,
                name   => 'libxml2.i686',
        }

        package { 'zlib.i686':
                ensure => installed,
                name   => 'zlib.i686',
        }

        # 3f dia2code - install via RPM
        package { 'dia2code':
                ensure   => installed,
                require  => Package['glibc.i686', 'libxml2.i686' , 'zlib.i686'],
                provider => 'rpm',
                source   => 'http://prdownloads.sourceforge.net/dia2code/dia2code-0.8.1-1.i686.rpm',
        }



        # 3h gcc
        package { 'gcc':
                ensure => installed,
                name   => 'gcc',
        }

        # 3i gdb
        package { 'gdb':
                ensure => installed,
                name   => 'gdb',
        }

        # 3j cgdb
        package { 'cgdb':
                ensure => installed,
                name   => 'cgdb',
        }
        # 3k vim
        package { 'vim':
                ensure => installed,
                name   => 'vim',
        }

        # 3l emacs
        package { 'emacs':
                ensure => installed,
                name   => 'emacs',
        }

        package { 'epel-release':
                ensure   => installed,
                provider => 'rpm',
                source   => 'http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm',
        }

        package {'sshfs':
                ensure  => installed,
                name    => 'sshfs',
                require => Package['epel-release'],
        }




}
