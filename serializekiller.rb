require "formula"

class Serializekiller < Formula
  homepage "https://github.com/johndekroon/serializekiller"
  url "https://github.com/johndekroon/serializekiller", :using => :git, :revision => "2a387b5"
  version "1.0.2"

  depends_on "nmap"
  depends_on "curl"

  resource "requests" do
    url "https://pypi.python.org/packages/49/6f/183063f01aae1e025cf0130772b55848750a2f3a89bfa11b385b35d7329d/requests-2.10.0.tar.gz"
    sha256 "63f1815788157130cee16a933b2ee184038e975f0017306d723ac326b5525b54"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[requests].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec

    system("chmod", "0555", "serializekiller.py")
    bin.install "serializekiller.py"
    libexec.install Dir["*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
