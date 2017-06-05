require 'formula'

class HashcatBin < Formula
  homepage 'http://hashcat.net/hashcat/'
  url "https://hashcat.net/files/hashcat-3.5.0.7z"
  sha256 "0f3f1338325e1f46c1a622b30e9b90c4b54216d89e00b74816562e2659b2fc2a"

  depends_on 'p7zip' => :build

  def install
    cd "hashcat-#{version}" do
      pkgshare.install Dir['*']
      if Hardware::CPU.is_64_bit?
	      bin.install_symlink "#{pkgshare}/hashcat64.bin" => 'hashcat.bin'
	    else
	      bin.install_symlink "#{pkgshare}/hashcat32.bin" => 'hashcat.bin'
	    end
    end
  end
end
