


# Agent configuration
# Disable Root SSH - 4a
file_line { 'disable_root_ssh':
        ensure => present,
        path => '/etc/ssh/sshd_config',
        line => 'PermitRootLogin no',
        match => 'PermitRootLogin',
}

# Becca sudo access - 4c
file_line { 'becca_priv':
        ensure => present,
        path => '/etc/sudoers',
        line => 'becca ALL=(ALL:ALL) ALL',
}

# Fred sudo access via group - 4d
file_line { 'disable_root_ssh':
        ensure => present,
        path => '/etc/ssh/sshd_config',
        line => 'PermitRootLogin no',
        match => 'PermitRootLogin',
}
# Ensure /usr/local/bin is in path - 4e, 7
file_line { 'path':
        ensure => present,
        path => '/etc/bashrc',
        line => 'export PATH=$PATH:/usr/local/bin',
}

