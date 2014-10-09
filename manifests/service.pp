class opscenter::service(
    $service_ensure
) {
    validate_re($service_ensure, '^(running|stopped)$')

    service { $opscenter::service_name:
        ensure      => $service_ensure,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        subscribe   => Class['opscenter::config'],
        require     => Class['opscenter::config'],
    }
}
