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
}