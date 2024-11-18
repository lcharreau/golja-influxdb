# PRIVATE CLASS: do not use directly
class influxdb::repo::yum(
  $ensure   = 'present',
  $enabled  = 1,
  $gpgcheck = 1,
) {

  $_operatingsystem = $::facts['os']['name'] ? {
    'CentOS' => downcase($::facts['os']['name']),
    default  => 'rhel',
  }

  yumrepo { 'repos.influxdata.com':
    ensure   => $ensure,
    descr    => "InfluxDB Repository - ${::facts['os']['name']} \$releasever",
    baseurl  => "https://repos.influxdata.com/${$_operatingsystem}/\$releasever/\$basearch/stable",
    enabled  => $enabled,
    gpgcheck => $gpgcheck,
    gpgkey   => 'https://repos.influxdata.com/influxdb.key',
  }

}
