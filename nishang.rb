require "formula"

class Nishang < Formula
  homepage "://github.com/samratashok/nishang"
  head "https://github.com/samratashok/nishang", :using => :git, :branch => "master"
  url "https://github.com/samratashok/nishang", :using => :git, :revision => "fbf1716"
  version "0.5"

  def install
    pkgshare.install Dir["*"]
  end

  def caveats; <<-EOS.undent
    The Nishang scripts can be found in #{HOMEBREW_PREFIX}/share/nishang
    EOS
  end
end
