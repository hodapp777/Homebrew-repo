require "formula"

class Commix < Formula
  homepage "https://github.com/commixproject/commix"
  url "https://github.com/commixproject/commix", :using => :git, :revision => "5062b10"
  version "1.4-20161017"

  def install
    (bin/"commix").write <<-EOS.undent
      #!/usr/bin/env bash
      cd #{libexec} && PYTHONPATH=#{ENV["PYTHONPATH"]} python commix.py "$@"
    EOS
    libexec.install Dir['*']
  end
end
