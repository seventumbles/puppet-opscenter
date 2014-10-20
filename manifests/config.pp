class opscenter::config {
    $config_path            = $opscenter::config_path
    $webserver_port         = $opscenter::webserver_port
    $webserver_interface    = $opscenter::webserver_interface
    $ssl_keyfile            = $opscenter::ssl_keyfile
    $ssl_certfile           = $opscenter::ssl_certfile
    $ssl_port               = $opscenter::ssl_port
    $log_level              = $opscenter::log_level
    $auth_enabled           = $opscenter::auth_enabled

    file { "${config_path}/opscenterd.conf":
        ensure  => file,
        content => template("${module_name}/opscenterd.conf.erb"),
    }
}
