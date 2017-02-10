require "formula"

class Commix < Formula
  homepage "https://github.com/commixproject/commix"
  url "https://github.com/commixproject/commix", :using => :git, :revision => "341c039"
  version "1.7-20170203"
  revision 1

  def install
    (bin/"commix.py").write <<-EOS.undent
      #!/usr/bin/env bash
      cd #{libexec} && PYTHONPATH=#{ENV["PYTHONPATH"]} python commix.py "$@"
    EOS
    libexec.install Dir['*']
  end
end
