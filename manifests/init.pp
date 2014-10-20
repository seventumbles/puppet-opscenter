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
    validate_string($service_name)
    validate_string($config_path)

    if(!is_integer($webserver_port)) {
        fail('webserver_port must be an integer')
    }

    if(!is_ip_address($webserver_interface)) {
        fail('webserver_interface must be an IP address')
    }

    if(!empty($ssl_keyfile)) {
        validate_string($ssl_keyfile)
    }

    if(!empty($ssl_certfile)) {
        validate_string($ssl_certfile)
    }

    if(!empty($ssl_port) and !is_integer($ssl_port)) {
        fail('ssl_port must be an integer')
    }

    validate_re($log_level, '^(TRACE|DEBUG|INFO|WARN|ERROR)$')
    validate_bool($auth_enabled)

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

    include opscenter::install
    include opscenter::config

    class { 'opscenter::service':
        service_ensure => 'running'
    }

    anchor { 'opscenter::end': }

    Anchor['opscenter::begin']
      -> Class['opscenter::repo']
      -> Class['opscenter::install']
      -> Class['opscenter::config']
      ~> Class['opscenter::service']
    -> Anchor['opscenter::end']
}
