# Define: dovecot::plugin
#
# Trivial way to install plugin sub-packages.
# Should only be used as the 'plugins' parameter of the main dovecot class.
#
# Example Usage:
#     class { 'dovecot': plugins => [ 'mysql', 'pigeonhole' ] }
#
define dovecot::plugin( $prefix = 'dovecot' ) {
  if ! defined(Class['dovecot']) {
    fail('You must include the dovecot base class before using any dovecot defined resources')
  }

  package { "${prefix}-${title}":
    ensure => installed,
  }
}

