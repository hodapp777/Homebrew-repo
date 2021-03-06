require "formula"

class Laudanum < Formula
  homepage "https://sourceforge.net/projects/laudanum/"
  url "https://downloads.sourceforge.net/project/laudanum/laudanum-1.0/laudanum-1.0.tgz"
  sha256 "d6a676e7bf9f8552c81bdf3b7915c3f19a440b764d652b3f21fe0cc050ca4920"
  version "1.0"
  revision 1

  def install
    pkgshare.install Dir["*"]
  end

  def caveats; <<~EOS
    The Laudanum scripts can be found in #{HOMEBREW_PREFIX}/share/laudanum
    EOS
  end
end
