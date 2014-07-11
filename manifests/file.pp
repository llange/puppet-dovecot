# Define: dovecot::file
#
# Manage dovecot configuration files under /etc/dovecot/.
#
# Example Usage:
#     dovecot::file { 'dovecot-sql.conf.ext':
#         source => 'puppet:///modules/mymodule/dovecot-sql.conf.ext',
#     }
#
define dovecot::file (
    $owner   = 'root',
    $group   = 'root',
    $mode    = '0644',
    $content = undef,
    $source  = undef
) {
    case $::operatingsystem {
      'FreeBSD': { $directory = '/usr/local/etc/dovecot' }
      default:   { $directory = '/etc/dovecot' }
    }

    file { "${directory}/${title}":
        owner   => $owner,
        group   => $group,
        mode    => $mode,
        content => $content,
        source  => $source,
        require => Package[$dovecot::packages],
        replace => true,
    }
    if $dovecot::manage_service {
      File["/etc/dovecot/${title}"] ~> Service['dovecot']
    }
}

