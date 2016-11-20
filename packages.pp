# REF: https://docs.puppet.com/puppet/4.8/reference/types/package.html

# 3c MySQL - mariadb
package { 'mariadb':
        ensure => installed,
        name => 'mariadb',
}
