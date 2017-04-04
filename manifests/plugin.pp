define mp::plugin (
  $type,
  $libdir = $::mp::libdir,
){

  include stdlib
  #  if $::osfamily == 'windows' {
  #    $rootusr = "BUILTIN\\Administrators"
  #    $rootgrp = "NT AUTHORITY\\SYSTEM"
  #  } else {
  #    $rootusr = "root"
  #    $rootgrp = "root"
  #  }

  if ! defined(Class['mp']) {
    fail('You must include the mp base class before using the mp::plugin defined resource')
  }

  validate_re($type, ['agent','validator','application', 'data', 'discovery', 'util'])

  if $type in ['data','validator'] {
    $suffix = "_${type}"
  } else {
    $suffix = ''
  }

  file { "${name}_plugin":
    ensure => file,
    path   => "${libdir}/${type}/${name}${suffix}.rb",
    #           owner  => 'root',
    #group  => 'root',
    #           owner => $rootusr,
    #           group => $rootgrp,
    mode   => '0644',
    source => "puppet:///modules/${caller_module_name}/${type}/${name}${suffix}.rb",
    notify => Service["$::mp::service"],
  }

  if $type in ['validator','agent','data','discovery'] {
    file { "${name}_plugin_ddl":
      ensure => file,
      path   => "${libdir}/${type}/${name}${suffix}.ddl",
      #owner  => 'root',
      #group  => 'root',
      #             owner => $rootusr,
      #             group => $rootgrp,
      mode   => '0644',
      source => "puppet:///modules/${caller_module_name}/${type}/${name}${suffix}.ddl",
    }
  }
}
