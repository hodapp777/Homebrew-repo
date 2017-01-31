require 'formula'

class Armitage < Formula
  homepage 'http://www.fastandeasyhacking.com/'
  url 'http://www.fastandeasyhacking.com/download/armitage150813.tgz'
  sha256 '288065a8b779b6a4f4acaa0332f2ebbfd022529f600e4bf70cd494d84860f6ac'
  version '150813'
  revsion 1

  depends_on :java => "1.7+"

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
