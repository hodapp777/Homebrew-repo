require "formula"

class Panoptic < Formula
  homepage "https://github.com/lightos/Panoptic"
  url "https://github.com/lightos/Panoptic", :using => :git, :revision => "b5eae6b"
  version "0.20150626"

  def install
    libexec.install Dir["*"]
    (bin/"panoptic").write <<-EOS.undent
      #!/bin/sh
      cd #{libexec} && PYTHONPATH=#{ENV["PYTHONPATH"]} python panoptic.py "$@"
    EOS
  end
end
