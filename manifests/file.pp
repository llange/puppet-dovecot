# Define: dovecot::file
#
# Manage dovecot configuration files under /etc/dovecot/.
#
# Example Usage:
#     dovecot::file { 'dovecot-sql.conf.ext':
#       source => 'puppet:///modules/mymodule/dovecot-sql.conf.ext',
#     }
#
define dovecot::file (
  $content = undef,
  $group   = 'root',
  $mode    = '0644',
  $owner   = 'root',
  $source  = undef
) {
  if ! defined(Class['dovecot']) {
    fail('You must include the dovecot base class before using any dovecot defined resources')
  }

  file { "${directory}/${title}":
    ensure  => file,
    content => $content,
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    replace => true,
    require => Package[$::dovecot::packages],
    source  => $source,
  }
  if $dovecot::manage_service {
    File["${::dovecot::directory}/${title}"] ~> Service['dovecot']
  }
}

