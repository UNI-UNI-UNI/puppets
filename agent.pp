


file_line { 'agent_runinterval':
        path => '/etc/puppetlabs/puppet/puppet.conf',
        ensure => present,
        after => '\[agent\]',
        line => 'runinterval=20m',
}
