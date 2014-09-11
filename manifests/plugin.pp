# Define: dovecot::plugin
#
# Trivial way to install plugin sub-packages.
# Should only be used as the 'plugins' parameter of the main dovecot class.
#
# Example Usage:
#     class { 'dovecot': plugins => [ 'mysql', 'pigeonhole' ] }
#
<<<<<<< HEAD
define dovecot::plugin( $prefix = 'dovecot' ) {
  if $title != "mysql" {
    package { "${prefix}-${title}":
      ensure => installed,
    }
  }
}

