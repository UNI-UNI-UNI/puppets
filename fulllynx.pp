# 3g lynx - requires extras
class packages::lynx {
        # Case statement - https://docs.puppet.com/puppet/latest/reference/lang_conditional.html#if-statements
        $inst_option = $facts['os']['name'] ? {
                'Redhat' =>  '["--enablerepo","hui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional"]' ,
                default => [],
        }


        package { 'lynx':
                ensure => installed,
                name => 'lynx',
                install_options => $inst_option,
       }
}

