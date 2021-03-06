require "formula"

class Fuzzdb < Formula
  homepage "https://github.com/fuzzdb-project/fuzzdb"
  head "https://github.com/fuzzdb-project/fuzzdb", :using => :git, :branch => "master"
  url "https://github.com/fuzzdb-project/fuzzdb", :using => :git, :revision => "ecb0850"
  version "0.20170116"
  revision 1

  def install
    pkgshare.install Dir["*"]
  end

  def caveats; <<~EOS
    The Fuzzdb wordlists can be found in #{HOMEBREW_PREFIX}/share/fuzzdb
    EOS
  end
end
