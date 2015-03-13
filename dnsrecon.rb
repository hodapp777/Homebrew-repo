require 'formula'

class Dnsrecon < Formula
  homepage 'https://github.com/darkoperator/dnsrecon'
  url 'https://github.com/darkoperator/dnsrecon/archive/0.8.8.tar.gz'
  sha1 'fe6e5f8cd23dfd8e0f850aa477c566f206d55756'
  version '0.8.8'

  resource "dnspython" do
    url "https://pypi.python.org/packages/source/d/dnspython/dnspython-1.12.0.zip"
    sha1 "e1d81af983d37c5478fe04694b78014b46210c5e"
  end

  resource "netaddr" do
    url "https://pypi.python.org/packages/source/n/netaddr/netaddr-0.7.13.tar.gz"
    sha1 "17570745e33dec8ddf4fdc7a4317f8dcfaa148fd"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[dnspython netaddr].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec
    bin.install "dnsrecon.py"
    libexec.install Dir["*"]

    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/dnsrecon.py", "-h"
  end
end
