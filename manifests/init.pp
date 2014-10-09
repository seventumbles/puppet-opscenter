class opscenter (
    $service_name           = $opscenter::params::service_name,
    $config_path            = $opscenter::params::config_path,
    $webserver_port         = $opscenter::params::webserver_port,
    $webserver_interface    = $opscenter::params::webserver_interface,
    $ssl_keyfile            = $opscenter::params::ssl_keyfile,
    $ssl_certfile           = $opscenter::params::ssl_certfile,
    $ssl_port               = $opscenter::params::ssl_port,
    $log_level              = $opscenter::params::log_level,
    $auth_enabled           = $opscenter::params::auth_enabled,
) inherits opscenter::params {
    #validation

    anchor { 'opscenter::begin': }

    class { 'opscenter::repo':
        repo_name => $repo_name,
        baseurl   => "http://${repo_baseurl}",
        gpgkey    => $repo_gpgkey,
        repos     => $repo_repos,
        release   => $repo_release,
        pin       => $repo_pin,
        gpgcheck  => $repo_gpgcheck,
        enabled   => $repo_enabled,
    }

    Class['opscenter::repo'] -> Class['opscenter::install']

    include opscenter::install
    include opscenter::config

    class { 'opscenter::service':
        service_ensure => 'running'
    }

    anchor { 'opscenter::end': }

    Anchor['opscenter::begin'] -> Class['opscenter::install'] -> Class['opscenter::config'] ~> Class['opscenter::service'] -> Anchor['opscenter::end']
}
