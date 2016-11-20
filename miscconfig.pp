# Setup config
#
class packages:miscconfig {
        # Configure Agent check-in - 20 minutes - 2
        file_line { 'agent_runinterval':
                path => '/etc/puppetlabs/puppet/puppet.conf',
                ensure => present,
                after => '\[agent\]',
                line => 'runinterval=20m',
        }

        # Becca sudo access - 4c
        file_line { 'becca_priv':
                ensure => present,
                path => '/etc/sudoers',
                line => 'becca ALL=(ALL:ALL) ALL',
        }

        # Ensure /usr/local/bin is in path - 4e, 7
        file { '/etc/profile.d/usr_local_bin.sh':
                ensure => present,
                # Refenced from /etc/profile.d/puppet-agent.conf
                content => 'if ! echo $PATH | grep -q /usr/local/bin ; then   export PATH=$PATH:/usr/local/bin ;fi',
        }
}
