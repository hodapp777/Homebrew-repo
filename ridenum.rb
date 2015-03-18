require "formula"

class Ridenum < Formula
  homepage "https://github.com/trustedsec/ridenum"
  head "https://github.com/trustedsec/ridenum.git"

  resource "pexpect" do
    url "https://pypi.python.org/packages/source/p/pexpect/pexpect-3.3.tar.gz"
    sha256 'dfea618d43e83cfff21504f18f98019ba520f330e4142e5185ef7c73527de5ba'
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[pexpect].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    bin.install "rid_enum.py"
    libexec.install Dir["*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "(#{bin}/rid_enum.py; true)"
  end
end
