require 'formula'

class Dnsrecon < Formula
  homepage 'https://github.com/darkoperator/dnsrecon'
  url 'https://github.com/darkoperator/dnsrecon/archive/0.8.9.tar.gz'
  sha256 'c3b99b423919ed877dd75893212c0365c1491f2abca3de411cee04c467d8500a'
  version '0.8.9'

  resource "dnspython" do
    url "https://pypi.python.org/packages/source/d/dnspython/dnspython-1.12.0.zip"
    sha1 "e1d81af983d37c5478fe04694b78014b46210c5e"
  end

  resource "netaddr" do
    url "https://pypi.python.org/packages/source/n/netaddr/netaddr-0.7.14.tar.gz"
    sha256 "02abbb54c9edd6a3046385d2634f51c1dbddbbc9b5816599ecd052b1d9ff445f"
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
