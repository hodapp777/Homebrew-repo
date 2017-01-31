require "formula"

class Wpscan < Formula
  homepage "https://github.com/wpscanteam/wpscan"
  url "https://github.com/wpscanteam/wpscan", :using => :git, :revision => '2bff063'
  version "2.9.2"

  depends_on "ruby"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "curl"

  def install
    system "#{HOMEBREW_PREFIX}/bin/bundle", "install", "--no-cache", "--path", "vendor/bundle"

    (bin/"wpscan.rb").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{libexec}/Gemfile bundle exec ruby #{libexec}/wpscan.rb "$@"
    EOS
    libexec.install Dir['*']
    libexec.install ".bundle"
  end
end
