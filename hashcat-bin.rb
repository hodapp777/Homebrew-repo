require 'formula'

class HashcatBin < Formula
  homepage 'http://hashcat.net/hashcat/'
  url "https://hashcat.net/files/hashcat-3.10.7z"
  sha256 "4420bebd836b9c5e67524ab111c600b78f59b479e8c38c0b86d26a92694d8f21"
  revision 2

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
