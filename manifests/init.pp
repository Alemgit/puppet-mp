class mp {
  #if $service {
  #  Mcollective_plugin::Plugin<||> {
  #    notify +> Service[$service],
  #  }
  #}

  # New code
  include puppet_enterprise

  if $puppetversion =~ /3.7/ {
    #notify{"loading pe_mcollective": }
    #$plugin_basedir = "${puppet_enterprise::params::mco_plugin_basedir}"
    #$mco_etc        = $puppet_enterprise::params::mco_etc
    $libdir         = "${puppet_enterprise::params::mco_plugin_basedir}"
    $service = 'pe-mcollective'
    if $osfamily == 'windows' {
      $gemprovider = 'gem'
    } else {
      $gemprovider = 'pe_gem'
    }
  } else {
    #notify{"loading puppet_enterprise": }
    #$plugin_basedir = "${puppet_enterprise::params::mco_plugin_userdir}/mcollective"
    #$mco_etc        = $puppet_enterprise::params::mco_etc
    $libdir         = "${puppet_enterprise::params::mco_plugin_userdir}/mcollective"
    $service = 'mcollective'
    $gemprovider = 'puppet_gem'
  }

  #notify{"plugin_basedir is $plugin_basedir": }
  #notify{"mco_etc is $mco_etc": }
  #notify{"libdir is $libdir": }
  #notify{"service is $service": }
  #notify{"puppetversion is $puppetversion": }

}
