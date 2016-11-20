class packages:mntsshfs {

        file {'/home/becca/titan':
                ensure => directory,
                mode => '0755',
        }

        # Mount SSHFS
        # Reference: https://docs.puppet.com/puppet/latest/reference/type.html#mount
        mount { 'sshfs_becca':
                ensure  => mounted,
                name    => '/home/becca/titan',
                atboot  => true,
                device  => "sshfs#s3462188@titan.csit.rmit.edu.au:/home/s3462188/",
                fstype  => "fuse",
        #       Mount currently fails due to login auth, below line can use keypair to login without requiring password
        #       Haven't added a public key to my rmit login on titan, not putting a private key onto github.
        #        options => "allow_other,default_permissions,IdentityFile=/home/becca/.ssh/id_rsa",
                options => "allow_other,default_permissions",
                require => File['/home/becca/titan'],
        }
}

