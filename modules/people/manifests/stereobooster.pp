class people::stereobooster {
  include dropbox
  include skype
  include iterm2::stable
  include sublime_text_2
  include zsh
  include utorrent
  include java
  include chrome
  include vlc
  include openoffice
  include caffeine
  include alfred
  include skitch
  include imagemagick

  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'stereobooster/dotfiles',
    require => File[$my]
  }

  exec { "install oh-my-zsh":
    command => "curl -L http://install.ohmyz.sh | sh",
    path    => "/usr/bin/:/bin/"
  }

  exec { "install dotfiles":
    command => "${my}/dotfiles/install.sh",
    path    => "/usr/bin/"
  }

  $source = 'http://macapps.mooregreatsoftware.com.s3.amazonaws.com/TrueCrypt-7.1a-OSX.dmg'

  package { 'TrueCrypt':
    source   => $source,
    provider => 'pkgdmg',
    require  => Package['osxfuse']
  }

  if ! defined(Package['osxfuse']) {
    package { 'osxfuse':
      provider => 'homebrew'
    }
  }

  # TODO move to project

  package { 'taglib':
    provider => 'homebrew'
  }

  package { 'sphinx':
    provider => 'homebrew'
  }

}
