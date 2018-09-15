# Public: Install VLC.app to /Applications.
#
# Examples
#
#   include vlc
class vlc ($version = '2.1.4') {
  package { 'VLC':
    provider => 'appdmg',
    source   => "http://artfiles.org/videolan.org/vlc/${version}/macosx/vlc-${version}.dmg",
  }
}
