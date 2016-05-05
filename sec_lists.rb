require "formula"

class SecLists < Formula
  homepage "https://github.com/danielmiessler/SecLists"
  url "https://github.com/danielmiessler/SecLists", :using => :git, :revision => "d698104"
  head "https://github.com/danielmiessler/SecLists", :using => :git, :branch => "master"
  version "0.20160330"

  def install
    pkgshare.install Dir["*"]
  end

  def caveats; <<-EOS.undent
    The SecLists lists can be found in #{HOMEBREW_PREFIX}/share/sec_lists
    EOS
  end
end
