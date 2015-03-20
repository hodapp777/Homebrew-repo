require 'formula'

class Armitage < Formula
  homepage 'http://www.fastandeasyhacking.com/'
  url 'http://www.fastandeasyhacking.com/download/armitage141120.tgz'
  sha256 'cb13b25262462b1079a6fafe26772632386f9fe7847d9d597355b56ff04663dd'

  depends_on :java => "1.7"

  def install
    libexec.install Dir['*']
    (bin/"armitage").write <<-EOS.undent
      #!/bin/sh
      cd #{libexec} && ./armitage "$@"
    EOS
    (bin/"teamserver").write <<-EOS.undent
      #!/bin/sh
      cd #{libexec} && ./teamserver "$@"
    EOS
  end

  test do
    #system "#{bin}/blah"
  end
end
