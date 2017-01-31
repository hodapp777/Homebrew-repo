require "formula"

class Bettercap < Formula
  homepage "https://github.com/evilsocket/bettercap"
  url "https://github.com/evilsocket/bettercap", :using => :git, :revision => '218b44c'
  version "1.6.0"
  revision 1

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "bettercap.gemspec"
    system "gem", "install", "bettercap-#{version}.gem"
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
  end
end
