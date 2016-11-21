class packages::hosts {
        # Section 5, IPs obtained through nslookup and are accurate to the time performed.
        host { 'titan':
                name         => 'titan.csit.rmit.edu.au',
                ensure       => present,
                host_aliases => 'titan',
                ip           => '131.170.5.131',
        }

        host { 'saturn':
                name         => 'saturn.csit.rmit.edu.au',
                ensure       => present,
                host_aliases => 'saturn',
                ip           => '131.170.5.132',
        }

        host { 'jupiter':
                name         => 'jupiter.csit.rmit.edu.au',
                ensure       => present,
                host_aliases => 'jupiter',
                ip           => '131.170.5.135',
        }
}
