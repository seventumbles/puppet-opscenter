class opscenter::repo::redhat(
    $repo_name,
    $baseurl,
    $gpgkey,
    $gpgcheck,
    $enabled
) {
    yumrepo { $repo_name:
        descr    => 'Datastax Repo for DataStax OpsCenter',
        baseurl  => $baseurl,
        gpgkey   => $gpgkey,
        gpgcheck => $gpgcheck,
        enabled  => $enabled,
    }
}
