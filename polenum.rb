require "formula"

class Polenum < Formula
  homepage "https://labs.portcullis.co.uk/tools/polenum/"
  url "https://labs.portcullis.co.uk/download/polenum-0.2.tar.bz2"
  sha256 '4362c6471f192f841f1a6349d522ddcadc51ee845e7dc7fc4655323aa90468eb'

  resource "pycrypto" do
    url "https://pypi.python.org/packages/source/p/pycrypto/pycrypto-2.6.1.tar.gz"
    sha256 'f2ce1e989b272cfcb677616763e0a2e7ec659effa67a88aa92b3a65528f60a3c'
  end

  resource "impacket" do
    url "https://pypi.python.org/packages/source/i/impacket/impacket-0.9.12.tar.gz"
    sha256 '59cd71e69ac66e6b2905d663e475772f1f94b93b039f929ba3d655a730fbd935'
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib64/python2.7/site-packages"
    %w[pycrypto impacket].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    bin.install "polenum.py"
    libexec.install Dir["*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "(#{bin}/polenum.py; true)"
  end
end
