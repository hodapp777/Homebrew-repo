require "formula"

class Panoptic < Formula
  homepage "https://github.com/lightos/Panoptic"
  url "https://github.com/lightos/Panoptic", :using => :git, :revision => "bc7236c"
  version "0.20190129"
  revision 1

  def install
    libexec.install Dir["*"]
    (bin/"panoptic").write <<~EOS
      #!/bin/sh
      cd #{libexec} && PYTHONPATH=#{ENV["PYTHONPATH"]} python panoptic.py "$@"
    EOS
  end
end
