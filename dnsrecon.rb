require 'formula'

class Dnsrecon < Formula
  homepage 'https://github.com/darkoperator/dnsrecon'
  url 'https://github.com/darkoperator/dnsrecon.git', :using => :git, :revision => '1cd3dd8'
  version '0.8.12'

  resource "dnspython" do
    url "https://pypi.python.org/packages/b3/e3/091c6489f0b573b8a4069ce956d037061ae9321401c89323386fe748dc9f/dnspython-1.12.0.zip"
    sha256 "63bd1fae61809eedb91f84b2185816fac1270ae51494fbdd36ea25f904a8502f"
  end

  resource "netaddr" do
    url "https://pypi.python.org/packages/7c/ec/104f193e985e0aa813ffb4ba5da78d6ae3200165bf583d522ac2dc40aab2/netaddr-0.7.18.tar.gz"
    sha256 "a1f5c9fcf75ac2579b9995c843dade33009543c04f218ff7c007b3c81695bd19"
  end

  def install
    # Add formula site-packages directory to PYTHONPATH
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    # Setup dependencies and install into vendor subfolder within libexec
    %w[dnspython netaddr].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    # Add formula libexec directory to PYTHONPATH
    ENV.prepend_create_path "PYTHONPATH", libexec

    # Move executable to formula bin diretcory
    bin.install "dnsrecon.py"
    # Move everything else to formula libexec directory
    libexec.install Dir["*"]
    # Move everything in bin to libexec/bin and write stubs to bin
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
