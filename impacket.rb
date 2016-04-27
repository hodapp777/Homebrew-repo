require "formula"

class Impacket < Formula
  homepage "https://github.com/coresecurity/impacket"
  url "https://github.com/CoreSecurity/impacket/releases/download/impacket_0_9_13/impacket-0.9.13.tar.gz"
  sha256 "56bb18010f13a33947c24d31f51e16d8c688cf9c753c1d52f79a9ba64e5c0dca"

  depends_on "openssl" # pyopenssl
  depends_on "libffi"  # cffi -> pyopenssl

  resource "pyasn1" do
    url "https://pypi.python.org/packages/source/p/pyasn1/pyasn1-0.1.7.tar.gz"
    sha256 "e4f81d53c533f6bd9526b047f047f7b101c24ab17339c1a7ad8f98b25c101eab"
  end

  resource "pycrypto" do
    url "https://pypi.python.org/packages/source/p/pycrypto/pycrypto-2.6.1.tar.gz"
    sha256 'f2ce1e989b272cfcb677616763e0a2e7ec659effa67a88aa92b3a65528f60a3c'
  end

  resource "pyopenssl" do
    url "https://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.15.1.tar.gz"
    sha256 "f0a26070d6db0881de8bcc7846934b7c3c930d8f9c79d45883ee48984bc0d672"
  end

  # required by pyopenssl
  resource "cryptography" do
    url "https://pypi.python.org/packages/source/c/cryptography/cryptography-0.9.1.tar.gz"
    sha256 "c3bab8f43ac20ca6f5ee4d40ab40fca97e8909c5a9869643cb775a5ed2929595"
  end

  # required by cryptography -> pyopenssl
  resource "idna" do
    url "https://pypi.python.org/packages/source/i/idna/idna-2.0.tar.gz"
    sha256 "16199aad938b290f5be1057c0e1efc6546229391c23cea61ca940c115f7d3d3b"
  end

  # required by cryptography -> pyopenssl
  resource "enum34" do
    url "https://pypi.python.org/packages/source/e/enum34/enum34-1.0.4.tar.gz"
    sha256 "d3c19f26a6a34629c18c775f59dfc5dd595764c722b57a2da56ebfb69b94e447"
  end

  # required by cryptography -> pyopenssl
  resource "ipaddress" do
    url "https://pypi.python.org/packages/source/i/ipaddress/ipaddress-1.0.7.tar.gz"
    sha256 "2c99e9eaea2dacbe4038b3be772ec650f5b4f4c8cc479c3704b81673d96849d7"
  end

  # required by cryptography -> pyopenssl
  resource "cffi" do
    url "https://pypi.python.org/packages/source/c/cffi/cffi-1.1.1.tar.gz"
    sha256 "81fbaf121a67a0c4d390cc0ce7a69661f987f5cf34997575131e8a1bbe1ee1c6"
  end

  # required by cffi -> cryptography -> pyopenssl
  resource "pycparser" do
    url "https://pypi.python.org/packages/source/p/pycparser/pycparser-2.13.tar.gz"
    sha256 "b399599a8a0e386bfcbc5e01a38d79dd6e926781f9e358cd5512f41ab7d20eb7"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib64/python2.7/site-packages"

    res =  %w[pycrypto pyopenssl cryptography pyasn1 idna enum34 ipaddress cffi pycparser]
    res.each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"bin"

    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end