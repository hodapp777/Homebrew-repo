require "formula"

class TestsslStatic < Formula
  homepage "https://github.com/drwetter/testssl.sh"
  url "https://github.com/drwetter/testssl.sh", :using => :git, :revision => '0eb88ff'
  version "2.8"

  def install
    (bin/"testssl.sh").write <<-EOS.undent
      #!/usr/bin/env bash
      cd #{libexec} && ./testssl.sh "$@"
    EOS

    libexec.install Dir["*"]
  end
end
