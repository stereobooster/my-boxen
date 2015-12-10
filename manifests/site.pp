require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  # include nginx
  # include pow
  include postgresql

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions

  nodejs::version { '0.10': }
  nodejs::version { '0.12': }
  # TODO: update to 5.1.0
  nodejs::version { '4.0.0': }

  $default_version = '4.0.0'

  class { 'nodejs::global':
    version => $default_version
  }

  npm_module { "npm for $default_version":
    module       => 'npm',
    version      => '>= 2.14.3',
    node_version => $default_version,
  }

  npm_module { "node-gyp for $default_version":
    module       => 'node-gyp',
    version      => '>= 3.0.2',
    node_version => $default_version,
  }

  npm_module { "bower for $default_version":
    module       => 'bower',
    version      => '>= 1.5.2',
    node_version => $default_version,
  }

  npm_module { "gulp for $default_version":
    module       => 'gulp',
    version      => '>= 3.9.0',
    node_version => $default_version,
  }

  # default ruby versions
  ruby::version { '2.1.1': }
  ruby::version { '2.2.0': }
  ruby::version { '2.2.2': }

  class { 'ruby::global':
    version => '2.2.2'
  }

  ruby_gem { 'bundler for all rubies':
    gem  => 'bundler',
    ruby_version => '*',
  }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
