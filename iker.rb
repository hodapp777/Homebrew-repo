require "formula"

class Iker < Formula
  homepage "https://labs.portcullis.co.uk/tools/iker/"
  url "https://labs.portcullis.co.uk/download/iker_v1.1.tar"
  sha256 "8780805a0743f60e42ec75dd56dcdb8beb1fdafc75aab6dcdac7ba13e126e7b6"
  version "1.1"
  revision 2

  depends_on "ike-scan"

  def install
    libexec.install "iker.py"
    (bin/"iker.py").write <<~EOS
      #!/bin/sh
      /usr/bin/env python #{libexec}/iker.py "$@"
    EOS
  end
end
