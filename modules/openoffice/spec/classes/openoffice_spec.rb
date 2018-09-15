require 'spec_helper'

describe 'openoffice' do

  version = '4.0.1'

  it { should contain_class('openoffice') }
  it { should contain_package("OpenOffice-#{version}").with_provider('appdmg') }
  it { should contain_package("OpenOffice-#{version}").with_source("http://garr.dl.sourceforge.net/project/openofficeorg.mirror/#{version}/binaries/en-US/Apache_OpenOffice_#{version}_MacOS_x86_install_en-US.dmg") }

end
