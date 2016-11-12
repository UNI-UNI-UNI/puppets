# REF: https://docs.puppet.com/puppet/4.8/reference/types/package.html
# EPEL needed for sshfs.
# Need extras for epels though, should be enabled
package { 'epel':
        ensure => installed,
        name => 'epel-release',
}

package {'sshfs':
        name => 'sshfs',
        ensure => installed,
        require => Package['epel'],
}
