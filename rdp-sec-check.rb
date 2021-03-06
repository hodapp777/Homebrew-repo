require 'formula'

class RdpSecCheck < Formula
  homepage "https://labs.portcullis.co.uk/tools/rdp-sec-check/"
  url "https://labs.portcullis.co.uk/download/rdp-sec-check-0.9.tgz"
  sha256 "2841bc0f0cb89512c85892a01f39bda6b34b8eec8a5a0de60c83fa31de558e5a"
  version "0.9"
  revision 3

  depends_on "perl"

  resource "Encoding::BER" do
    url "http://search.cpan.org/CPAN/authors/id/J/JA/JAW/Encoding-BER-1.02.tar.gz"
    sha256 "d1434f5fe9c4bade591044cdff48aa12241578684df3703163bf60a25c9b68c3"
  end

  resource "IO::Socket::INET" do
    url "http://search.cpan.org/CPAN/authors/id/G/GB/GBARR/IO-1.25.tar.gz"
    sha256 "89790db8b9281235dc995c1a85d532042ff68a90e1504abd39d463f05623e7b5"
  end

  resource "Getopt-Long" do
    url "http://search.cpan.org/CPAN/authors/id/J/JV/JV/Getopt-Long-2.48.tar.gz"
    sha256 "d5852a2f526535d14af7c5428098d74bae26c71f7b0aa72e5736db174b9d755b"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec+"lib/perl5"

    resources.each do |r|
      r.stage do
        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make"
        system "make", "install"
      end
    end

    libexec.install "rdp-sec-check.pl"
    (bin/"rdp-sec-check.pl").write <<~EOS
      #!/bin/sh
      /usr/bin/env perl -I "#{ENV["PERL5LIB"]}" #{libexec}/rdp-sec-check.pl "$@"
    EOS
  end
end
