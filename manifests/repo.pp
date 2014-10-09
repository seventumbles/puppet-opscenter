class opscenter::repo (
    $repo_name,
    $baseurl,
    $gpgkey,
    $repos,
    $release,
    $pin,
    $gpgcheck,
    $enabled
){
    case $::osfamily {
        'Debian': {
            class { 'opscenter::repo::debian':
                repo_name  => $repo_name,
                location   => $baseurl,
                repos      => $repos,
                release    => $release,
                key_source => $gpgkey,
                pin        => $pin,
            }
        }
        'RedHat': {
            class { 'opscenter::repo::redhat':
                repo_name => $repo_name,
                baseurl   => $baseurl,
                gpgkey    => $gpgkey,
                gpgcheck  => $gpgcheck,
                enabled   => $enabled,
            }
        }
        default: {
            fail("OS family ${::osfamily} not supported")
        }
    }
}
