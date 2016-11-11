## site.pp ##
#mod 'puppetlabs-stdlib'

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

group { 'sysadmin':
	ensure => 'present',
}
# Create cars group
group { 'cars':
	ensure => 'present',
}
# Create trucks group
group { 'trucks':
	ensure => 'present',
}
# Create ambulances group
group { 'ambulances':
	ensure => 'present',
}

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
# Testpush
