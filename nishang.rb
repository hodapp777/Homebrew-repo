require "formula"

class Nishang < Formula
  homepage "http://github.com/samratashok/nishang"
  head "https://github.com/samratashok/nishang", :using => :git, :branch => "master"
  url "https://github.com/samratashok/nishang", :using => :git, :revision => "cfe2a5f"
  version "0.7.6"

  def install
    pkgshare.install Dir["*"]
  end

  def caveats; <<~EOS
    The Nishang scripts can be found in #{HOMEBREW_PREFIX}/share/nishang
    EOS
  end
end
