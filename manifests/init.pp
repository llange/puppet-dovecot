# Class: dovecot
#
# Install, enable and configure the Dovecot IMAP server.
# Options:
#  $plugins:
#  Array of plugin sub-packages to install. Default: empty
#
class dovecot (
  $plugins                      = [],
  # dovecot.conf
  $listen                       = undef,
  $login_greeting               = undef,
  $login_trusted_networks       = undef,
  $protocols                    = undef,
  $shutdown_clients             = undef,
  $verbose_proctitle            = undef,
  $recipient_delimiter          = undef,
  $quota_full_tempfail          = undef,
  # 10-auth.conf
  $auth_include                 = [ 'system' ],
  $auth_mechanisms              = [ 'login', 'plain' ],
  $auth_username_chars          = undef,
  $auth_username_format         = undef,
  $auth_master_separator        = '*',
  $disable_plaintext_auth       = undef,
  $auth_cache_size              = undef,
  $auth_cache_ttl               = undef,
  $auth_cache_negative_ttl      = undef,
  $auth_password_scheme         = undef,
  # 10-logging.conf
  $auth_debug                   = undef,
  $auth_verbose                 = undef,
  $log_path                     = undef,
  $log_timestamp                = undef,
  $mail_debug                   = undef,
  # 10-mail.conf
  $dotlock_use_excl             = undef,
  $mail_fsync                   = undef,
  $mail_location                = undef,
  $mail_nfs_index               = undef,
  $mail_nfs_storage             = undef,
  $mail_plugins                 = undef,
  $mail_privileged_group        = undef,
  $inbox_separator              = undef,
  $inbox_prefix                 = undef,
  $mmap_disable                 = undef,
  $first_valid_uid              = false,
  $last_valid_uid               = false,
  $mailbox_list_index           = undef,
  # 10-master.conf
  $auth_listener_default_user   = undef,
  $auth_listener_postfix        = false,
  $auth_listener_postfix_group  = undef,
  $auth_listener_postfix_mode   = '0666',
  $auth_listener_postfix_user   = undef,
  $auth_listener_userdb_group   = undef,
  $auth_listener_userdb_mode    = undef,
  $auth_listener_userdb_user    = undef,
  $default_client_limit         = undef,
  $default_process_limit        = undef,
  $imap_listen_port             = '143',
  $imap_login_client_limit      = undef,
  $imap_login_process_limit     = undef,
  $imap_login_process_min_avail = undef,
  $imap_login_service_count     = undef,
  $imap_login_vsz_limit         = undef,
  $imaps_listen_port            = '993',
  $lmtp_inet_listener           = false,
  $lmtp_address                 = '127.0.0.1',
  $lmtp_port                    = '24',
  $lmtp_socket_group            = undef,
  $lmtp_socket_mode             = undef,
  $lmtp_socket_path             = undef,
  $lmtp_socket_user             = undef,
  $pop3_listen_port             = '110',
  $pop3_login_process_min_avail = undef,
  $pop3_login_service_count     = undef,
  $pop3s_listen_port            = '995',
  $default_vsz_limit            = undef,
  # 10-ssl.conf
  $ssl                          = undef,
  $ssl_cert                     = '/etc/pki/dovecot/certs/dovecot.pem',
  $ssl_cipher_list              = undef,
  $ssl_key                      = '/etc/pki/dovecot/private/dovecot.pem',
  # 15-lda.conf
  $hostname                     = undef,
  $lda_mail_location            = undef,
  $lda_mail_plugins             = undef,
  $lda_mailbox_autocreate       = undef,
  $lda_mailbox_autosubscribe    = undef,
  $postmaster_address           = undef,
  $submission_host              = undef,
  # 20-imap.conf
  $imap_client_workarounds      = undef,
  $imap_mail_plugins            = undef,
  $mail_max_userip_connections  = 512,
  # 20-lmtp.conf
  $lmtp_mail_plugins            = undef,
  $lmtp_save_to_detail_mailbox  = undef,
  # 20-managesieve.conf 
  $managesieve_notify_capability = undef,
  $managesieve_sieve_capability  = undef,
  # 20-pop3.conf
  $pop3_client_workarounds      = undef,
  $pop3_mail_plugins            = undef,
  $pop3_uidl_format             = undef,
  # 90-sieve.conf
  $sieve                        = '~/.dovecot.sieve',
  $sieve_default                = undef,
  $sieve_after                  = undef,
  $sieve_before                 = undef,
  $sieve_dir                    = '~/sieve',
  $sieve_global_dir             = undef,
  $sieve_extensions             = undef,
  $sieve_max_actions            = undef,
  $sieve_max_redirects          = undef,
  $sieve_max_script_size        = undef,
  $sieve_quota_max_scripts      = undef,
  $sieve_quota_max_storage      = undef,
  # 90-quota.conf
  $quota                        = undef,
  $quota_warnings               = [],
  # auth-passwdfile.conf.ext
  $auth_passwdfile_passdb       = undef,
  $auth_passwdfile_userdb       = undef,
  # auth-sql.conf.ext
  $auth_sql_path                = '/etc/dovecot/dovecot-sql.conf.ext',
  $auth_sql_userdb_static       = undef,
  # auth-system.conf.ext
  $userdb_passwd_override_fields = undef,
  # auth-master.conf.ext / master-users
  $auth_master_pass             = false,
  $master_users                 = '',
  # auth-ldap.conf.ext
  $ldap_prefetch                = undef,
  # dovecot-ldap.conf.ext
  $ldap_uris                    = undef,
  $ldap_dn                      = undef,
  $ldap_dnpass                  = undef,
  $ldap_auth_bind               = undef,
  $ldap_base                    = undef,
  $ldap_user_attrs              = undef,
  $ldap_user_filter             = undef,
  $ldap_pass_attrs              = undef,
  $ldap_pass_filter             = undef,
  $ldap_iterate_attrs           = undef,
  $ldap_iterate_filter          = undef,
  $manage_service              = true,
) {
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $directory = '/etc/dovecot'
      $packages  = 'dovecot'
      $prefix    = 'dovecot'
    }

    'Debian', 'Ubuntu':{
      $directory = '/etc/dovecot'
      $packages  = [
        'dovecot-common',
        'dovecot-core',
        'dovecot-imapd',
        'dovecot-lmtpd',
        'dovecot-pop3d',
      ]
      $prefix    = 'dovecot'
    }

    'FreeBSD': {
      $directory = '/usr/local/etc/dovecot'
      $packages  = 'mail/dovecot2'
      $prefix    = 'mail/dovecot2'
    }

    default: {
      fail("OS ${::operatingsystem} ${::operatingsystemrelease} not supported")
    }
  }

  # All files in this scope are dovecot configuration files
  if $manage_service {
    File {
      notify  => Service['dovecot'],
      require => Package[$packages],
    }
  }
  else {
    File {
      require => Package[$packages],
    }
  }

  # Install plugins (sub-packages)
  dovecot::plugin { $plugins:
    before => Package[$packages],
    prefix => $prefix,
  }

  # Main package and service it provides
  package { $packages: ensure => installed }
  if $manage_service {
    service { 'dovecot':
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => File["${directory}/dovecot.conf"],
    }
  }

  # Main configuration
  file {
    $directory:
      ensure => 'directory';

    "${directory}/conf.d":
      ensure => 'directory';

    "${directory}/dovecot.conf":
      content => template('dovecot/dovecot.conf.erb');
  }

  # Configuration file snippets which we modify
  file {
    "${directory}/conf.d/10-auth.conf":
      content => template('dovecot/conf.d/10-auth.conf.erb');

    "${directory}/conf.d/10-logging.conf":
      content => template('dovecot/conf.d/10-logging.conf.erb');

    "${directory}/conf.d/10-mail.conf":
      content => template('dovecot/conf.d/10-mail.conf.erb');

    "${directory}/conf.d/10-master.conf":
      content => template('dovecot/conf.d/10-master.conf.erb');

    "${directory}/conf.d/10-director.conf":
      content => template('dovecot/conf.d/10-director.conf.erb');

    "${directory}/conf.d/10-ssl.conf":
      content => template('dovecot/conf.d/10-ssl.conf.erb');

    "${directory}/conf.d/15-lda.conf":
      content => template('dovecot/conf.d/15-lda.conf.erb');

    "${directory}/conf.d/15-mailboxes.conf":
      content => template('dovecot/conf.d/15-mailboxes.conf.erb');

    "${directory}/conf.d/20-imap.conf":
      content => template('dovecot/conf.d/20-imap.conf.erb');

    "${directory}/conf.d/20-lmtp.conf":
      content => template('dovecot/conf.d/20-lmtp.conf.erb');

    "${directory}/conf.d/20-managesieve.conf":
      content => template('dovecot/conf.d/20-managesieve.conf.erb');

    "${directory}/conf.d/20-pop3.conf":
      content => template('dovecot/conf.d/20-pop3.conf.erb');

    "${directory}/conf.d/90-plugin.conf":
      content => template('dovecot/conf.d/90-plugin.conf.erb');

    "${directory}/conf.d/90-quota.conf":
      content => template('dovecot/conf.d/90-quota.conf.erb');

    "${directory}/conf.d/90-sieve.conf":
      content => template('dovecot/conf.d/90-sieve.conf.erb');

    "${directory}/conf.d/dovecot-sql.conf.ext":
      content => template('dovecot/dovecot-sql.conf.ext.erb');

    "${directory}/conf.d/auth-passwdfile.conf.ext":
      content => template('dovecot/conf.d/auth-passwdfile.conf.ext.erb');

    "${directory}/conf.d/auth-sql.conf.ext":
      content => template('dovecot/conf.d/auth-sql.conf.ext.erb');

    "${directory}/conf.d/auth-system.conf.ext":
      content => template('dovecot/conf.d/auth-system.conf.ext.erb');

    "${directory}/conf.d/auth-master.conf.ext":
      content => template('dovecot/conf.d/auth-master.conf.ext.erb');

    "${directory}/conf.d/auth-ldap.conf.ext":
      content => template('dovecot/conf.d/auth-ldap.conf.ext.erb');
  }

  if $with_quota == "yes" {
    file { '/usr/local/bin/quota-warning.sh':
      content => template('dovecot/quota-warning.sh.erb'),
      mode    => '0555',
      owner   => 0,
      group   => 0,
    }
  } else {
    file { '/usr/local/bin/quota-warning.sh':
      ensure => absent,
    }
  }

  dovecot::file {'dovecot-ldap.conf.ext':
    group   => dovecot,
    mode    => '0640',
    content => template('dovecot/dovecot-ldap.conf.ext.erb')
  }

  # file with master users
  dovecot::file {'master-users':
    group   => dovecot,
    mode    => '0640',
    content => $master_users,
  }
}

