# Users
# Ref: https://docs.puppet.com/puppet/4.6/reference/quick_start_user_group.html
# Syntax: https://docs.puppet.com/puppet/latest/reference/types/user.html
# Need to define multiple groups in array
# Groups need to be defined prior, otherwise user creation will error


# Reference for setting up user type as well as group dependancy
# http://blog.scottlowe.org/2013/10/21/managing-ssh-authorized-keys-with-puppet/


user {'becca':
        ensure => 'present', #1
        groups => ['cars','sysadmin'], #1b
        uid => '10012188', #1d
        shell => '/bin/bash', #1e
        managehome => true, #1a
	home => '/home/becca', # 1a
        # Print doesn't work so well, use stdout instead.
        # Makes a sha512 string to use with password
        # Using sha1('password') only created a sha-1 not really designed for creating passwords.
        # mkpasswd not available
        password => generate('/bin/sh','-c',"python -c 'import crypt, sys; sys.stdout.write( crypt.crypt(\"pass\",\"\$6\$salty\"))'"), #1c
        # Use below if able to use standard libs
        #password => pw_hash('pass','SHA-512','saltysalt')
}

user {'fred':
        ensure => 'present', #1
        groups => ['cars','trucks'], #1b
        uid => '10022188', #1d
        shell => '/bin/csh', #1e
        managehome => true, #1a
	home => '/home/fred', #1a
        # Print doesn't work so well, use stdout instead.
        # Makes a sha512 string to use with password
        password => generate('/bin/sh','-c',"python -c 'import crypt, sys; sys.stdout.write( crypt.crypt(\"pass\",\"\$6\$salty\"))'") #1c
        # Use below if able to use standard libs
        #password => pw_hash('pass','SHA-512','saltysalt')
}

user {'wilma':
        ensure => 'present', #1
        groups => ['cars','trucks','ambulances'], #1b
        uid => '10032188', #1d
        shell => '/bin/csh', #1e
        managehome => true, #1a
	home => '/home/wilma', #1a
        # Print doesn't work so well, use stdout instead.
        # Makes a sha512 string to use with password
        password => generate('/bin/sh','-c',"python -c 'import crypt, sys; sys.stdout.write( crypt.crypt(\"pass\",\"\$6\$salty\"))'"), #1c
        # Use below if able to use standard libs
        # password => pw_hash('pass','SHA-512','saltysalt')
        # Manage key via puppet
        # https://docs.puppet.com/puppet/latest/reference/types/ssh_authorized_key.html
        purge_ssh_keys => true,
}

ssh_authorized_key { 'wilma':
        ensure => present,
        type => 'ssh-dss',
        user => 'wilma',
        key => 'AAAAB3NzaC1kc3MAAACBAMO8rRLLAqGUUIX8gJddWo2sl1wyHuH1gU0NCtiiK9s2gFu7d5azzT5HW6L3Hj7QBmRwaz9mlEJVpdkey0OBsxAHXcIuqIyhLP2NfQd9ZBCB6c7IxL64TwW9TwMJeSs953i0uWWMLoDt6qy+SmCde88eT3i0a6y5Yu+y14NOgfPHAAAAFQDllsOJQZkt38zhB544rFLmIITCvQAAAIA+krSYYlq6JC/B0W9Eh27sQ8yr18GmcHydt8aEPbEf/0ezgq9lxTfoGRlEa54ChAxHGjiwyx1wvSqEMOY0ykb+iy9rXD6fTmDvXgZdcAp6ke6ZLDhaOUxnVyTc4z9BwukNhAEV+/bIfXQ0cfwcCwQvJ8dWESmF2bPj7VSwj8N85wAAAIEAk0J2YyC/5DqiRfyv+AwSTnoiP4lGMvvvVV6Axa4zmGBUQpMFlQiCtR3YMOC0zyNVy13sXN0ZeIbhwdzA7AKFPrLwXxwtSu/epmx46acXX6JMZdPbptzak+0ckPTPo0O1kMnFToBcmoKiKkRbG9T0h0yLrPnVkvTNf7gHt3QoIl0=',
}
