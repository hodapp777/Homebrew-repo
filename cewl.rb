require "formula"

class Cewl < Formula
  homepage "https://github.com/digininja/CeWL/"
  url "https://github.com/digininja/CeWL/", :using => :git, :revision => 'e102a5c'
  version "5.3"
  revision 1

  depends_on "ruby"
  depends_on "libxml2"
  depends_on "libxslt"

  def install
    system "#{HOMEBREW_PREFIX}/bin/bundle", "install", "--no-cache", "--path", "vendor/bundle"

    inreplace "cewl.rb", "require './cewl_lib'", "require '#{libexec}/cewl_lib'"
    inreplace "fab.rb", "require \"./cewl_lib.rb\"", "require '#{libexec}/cewl_lib.rb'"

    (bin/"cewl.rb").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{libexec}/Gemfile bundle exec ruby #{libexec}/cewl.rb "$@"
    EOS
    (bin/"fab.rb").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{libexec}/Gemfile bundle exec ruby #{libexec}/fab.rb "$@"
    EOS
    libexec.install Dir['*']
    libexec.install ".bundle"
  end
end
