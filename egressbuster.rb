require "formula"

class Egressbuster < Formula
  homepage "https://github.com/trustedsec/egressbuster"
  url "https://github.com/trustedsec/egressbuster", :using => :git, :revision => "bf53bac"
  version "0.2.20170127"
  revision 1

  def install
    bin.install "egress_listener.py"
    pkgshare.install Dir["*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  def caveats; <<~EOS
    The egressbuster clients (egressbuster.py and egressbuster.exe) can be found in #{HOMEBREW_PREFIX}/share/egressbuster
    EOS
  end
end
