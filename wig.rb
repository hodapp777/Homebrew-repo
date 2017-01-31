require "formula"

class Wig < Formula
  homepage "https://github.com/jekyc/wig"
  url "https://github.com/jekyc/wig", :using => :git, :revision => 'd1ce471'
  version "0.6"
  revision 1

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec

    (bin/"wig.py").write <<-EOS.undent
      #!/usr/bin/env bash
      cd #{libexec} && PYTHONPATH=#{ENV["PYTHONPATH"]} python3 wig.py "$@"
    EOS

    libexec.install Dir["*"]
  end
end
