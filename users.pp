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
        # Using sha1('password') only created a sha-1.
        # mkpasswd not available
        password => generate('/bin/sh','-c',"python -c 'import crypt, sys; sys.stdout.write( crypt.crypt(\"pass\",\"\$6\$salty\"))'"), #1c
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
        #password => pw_hash('pass','SHA-512','saltysalt')
}

user {'wilma':
        ensure => 'present', #1
        groups => ['cars','trucks','ambulances'], #1b
        uid => '10032188', #1d
        shell => '/bin/csh', #1e
        managehome => true, #1a
	home => '/home/fred', #1a
        # Print doesn't work so well, use stdout instead.
        # Makes a sha512 string to use with password
        password => generate('/bin/sh','-c',"python -c 'import crypt, sys; sys.stdout.write( crypt.crypt(\"pass\",\"\$6\$salty\"))'") #1c
        #password => pw_hash('pass','SHA-512','saltysalt')
}
