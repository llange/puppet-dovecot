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
  case $::operatingsystem {
    'FreeBSD': { $directory = '/usr/local/etc/dovecot' }
    default:   { $directory = '/etc/dovecot' }
  }

  file { "${directory}/${title}":
    ensure  => file,
    content => $content,
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    replace => true,
    require => Package[$dovecot::packages],
    source  => $source,
  }
  if $dovecot::manage_service {
    File["${directory}/${title}"] ~> Service['dovecot']
  }
}

