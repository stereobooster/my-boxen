# Public: Install OpenOffice to /Applications.
#
# Examples
#
#   include openoffice
class openoffice($version='4.0.1') {

  package { "OpenOffice-${version}":
    provider => 'appdmg',
    source   => "http://garr.dl.sourceforge.net/project/openofficeorg.mirror/${version}/binaries/en-US/Apache_OpenOffice_${version}_MacOS_x86_install_en-US.dmg",
  }

}
