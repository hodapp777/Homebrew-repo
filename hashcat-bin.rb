require 'formula'

class HashcatBin < Formula
  homepage 'http://hashcat.net/hashcat/'
  url "https://hashcat.net/files/hashcat-4.0.1.7z"
  sha256 "48246eeaf682060c34a42e7e8fbfbd2e9315d0442eda35bf0aa8f81796184fac"

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
