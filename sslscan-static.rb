require 'formula'

class SslscanStatic < Formula
  homepage 'https://github.com/rbsec/sslscan'
  url 'https://github.com/rbsec/sslscan', :using => :git, :revision => '1f798b8'
  version '1.11.11'

  depends_on "makedepend" => :build
  depends_on "zlib"
  depends_on "perl" => :build

  # Fix compilation
  patch :DATA

  def install
    ENV.deparallelize
    system "make static"
    bin.install "sslscan"
    man1.install "sslscan.1"
  end

  test do
    system "#{bin}/sslscan"
  end
end

__END__
diff --git a/Makefile b/Makefile
index 91f183f..dba91dd 100644
--- a/Makefile
+++ b/Makefile
@@ -31,8 +31,8 @@ endif
 # for static linking
 ifeq ($(STATIC_BUILD), TRUE)
 PWD          = $(shell pwd)/openssl
-LDFLAGS      += -L${PWD}/
-CFLAGS       += -I${PWD}/include/ -I${PWD}/
+LDFLAGS      = -L${PWD}/
+CFLAGS       = -I${PWD}/include/ -I${PWD}/
 LIBS         = -lssl -lcrypto -lz
 ifneq ($(OS), FreeBSD)
 	LIBS += -ldl
