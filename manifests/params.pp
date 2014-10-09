class opscenter::params {

    $repo_name = $::opscenter_repo_name ? {
        undef   => 'datastax',
        default => $::opscenter_repo_name
    }

    $repo_baseurl = $::opscenter_repo_baseurl ? {
        undef   => $::osfamily ? {
            'Debian' => 'debian.datastax.com/community',
            'RedHat' => 'rpm.datastax.com/community',
            default  => undef,
        },
        default => $::opscenter_repo_baseurl
    }

    $repo_gpgkey = $::opscenter_repo_gpgkey ? {
        undef   => $::osfamily ? {
            'Debian' => 'http://debian.datastax.com/debian/repo_key',
            'RedHat' => 'http://rpm.datastax.com/rpm/repo_key',
            default  => undef,
        },
        default => $::opscenter_repo_gpgkey
    }

    $repo_repos = $::opscenter_repo_repos ? {
        undef   => 'main',
        default => $::opscenter_repo_release
    }

    $repo_release = $::opscenter_repo_release ? {
        undef   => 'stable',
        default => $::opscenter_repo_release
    }

    $repo_pin = $::opscenter_repo_pin ? {
        undef   => 200,
        default => $::opscenter_repo_release
    }

    $repo_gpgcheck = $::opscenter_repo_gpgcheck ? {
        undef   => 0,
        default => $::opscenter_repo_gpgcheck
    }

    $repo_enabled = $::opscenter_repo_enabled ? {
        undef   => 1,
        default => $::opscenter_repo_enabled
    }

    case $::osfamily {
        'Debian': {
            $package_name = $::opscenter_package_name ? {
                undef   => 'opscenter',
                default => $::opscenter_package_name,
            }

            $service_name = $::opscenter_service_name ? {
                undef   => 'opscenterd',
                default => $::opscenter_service_name,
            }

            $config_path = $::opscenter_config_path ? {
                undef   => '/etc/opscenter',
                default => $::opscenter_config_path,
            }
        }
        'RedHat': {
            $package_name = $::opscenter_package_name ? {
                undef   => 'opscenter',
                default => $::opscenter_package_name,
            }

            $service_name = $::opscenter_service_name ? {
                undef   => 'opscenterd',
                default => $::opscenter_service_name,
            }

            $config_path = $::opscenter_config_path ? {
                undef   => '/etc/opscenter',
                default => $::opscenter_config_path,
            }
        }
        default: {
            fail("Unsupported osfamily: ${::osfamily}, operatingsystem: ${::operatingsystem}, module ${module_name} only supports osfamily Debian")
        }
    }

    ########

    $version = $::opscenter ? {
        undef   => 'installed',
        default => $::opscenter,
    }

    $webserver_port = $::opscenter_webserver_port ? {
        undef       => 8888,
        default     => $::opscenter_webserver_port,
    }

    $webserver_interface = $::opscenter_webserver_interface ? {
        undef       => '0.0.0.0',
        default     => $::opscenter_webserver_interface,
    }

    $ssl_keyfile = $::opscenter_ssl_keyfile ? {
        undef       => undef,
        default     => $::opscenter_ssl_keyfile,
    }

    $ssl_certfile = $::opscenter_ssl_certfile ? {
        undef       => undef,
        default     => $::opscenter_ssl_certfile,
    }

    $ssl_port = $::opscenter_ssl_port ? {
        undef       => undef,
        default     => $::opscenter_ssl_port,
    }

    $log_level = $::opscenter_log_level ? {
        undef       => 'INFO',
        default     => $::opscenter_log_level,
    }

    $auth_enabled = $::opscenter_auth_enabled ? {
        undef       => false,
        default     => $::opscenter_auth_enabled,
    }
}
