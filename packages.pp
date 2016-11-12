# REF: https://docs.puppet.com/puppet/4.8/reference/types/package.html
#


# 3a
package { 'openssh':
        ensure => installed,
        name => 'openssh',
#        require => openssl
}

# 3b Apache




#
# EPEL needed for sshfs.
# Need extras for epels though, should be enabled
# 3 m
package { 'epel':
        ensure => installed,
        name => 'epel-release',
}

package {'sshfs':
        name => 'sshfs',
        ensure => installed,
        require => Package['epel'],
}
