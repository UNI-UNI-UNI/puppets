# Setup RMIT CSIT Host entries
# Information current on 19/11/16
class packages::hosts {
        # Section 5, IPs obtained through nslookup and are accurate to the time performed.
        host { 'titan':
                ensure       => present,
                name         => 'titan.csit.rmit.edu.au',
                host_aliases => 'titan',
                ip           => '131.170.5.131',
        }

        host { 'saturn':
                ensure       => present,
                name         => 'saturn.csit.rmit.edu.au',
                host_aliases => 'saturn',
                ip           => '131.170.5.132',
        }

        host { 'jupiter':
                ensure       => present,
                name         => 'jupiter.csit.rmit.edu.au',
                host_aliases => 'jupiter',
                ip           => '131.170.5.135',
        }
}
