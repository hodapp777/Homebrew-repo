require "formula"

class Netdiscover < Formula
  homepage "http://nixgeneration.com/~jaime/netdiscover/"
  url "http://archive.debian.org/debian/pool/main/n/netdiscover/netdiscover_0.3beta6.orig.tar.gz"
  sha256 "19c367f823c49999e2c05c485cac0a5d5685d23c6b33deae1e957406571924db"
  version "0.3-beta6"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libnet"

  def install
    if build.head?
      system "./autogen.sh"
    #else
      #system "autoconf"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "(#{sbin}/netdiscover --help; true)"
  end
end
