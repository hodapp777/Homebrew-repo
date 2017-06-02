require "formula"

class MetasploitFramework < Formula
  homepage "https://github.com/rapid7/metasploit-framework"
  head "https://github.com/rapid7/metasploit-framework", :using => :git
  url "https://github.com/rapid7/metasploit-framework", :using => :git, :revision => '43ac76e'
  version "4.14.23"

  option "with-oracle", "Build with oracle support, requires a working installation of instantclient version 10.2"

  depends_on "sidaf/pentest/ruby23"
  depends_on "openssl"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "sqlite"
  depends_on "postgresql"
  depends_on "gmp"        # for ruby-oci8

  resource "bundler" do
    url "https://rubygems.org/downloads/bundler-1.14.3.gem"
    sha256 "9d61c7d983b99eb0b16d64658b182e045bcdd74ef3b139e849777f780782dbfe"
  end

  def install
    (buildpath/"vendor/bundle").mkpath
    resources.each do |r|
      r.verify_download_integrity(r.fetch)
      system("gem23", "install", r.cached_download, "--no-document",
             "--install-dir", "vendor/bundle")
    end

    ENV["GEM_HOME"] = "#{buildpath}/vendor/bundle"
    system "ruby23", "#{buildpath}/vendor/bundle/bin/bundle", "install",
           "--no-cache", "--path", "vendor/bundle"

    if build.with? "oracle"
      (buildpath/"Gemfile.local").write <<-EOS.undent
      group :local do
        gem 'ruby-oci8', '~> 2.2.3'
      end
      EOS
      (buildpath/"Gemfile.local.lock").write <<-EOS.undent
      GEM
        remote: https://rubygems.org/
        specs:
          ruby-oci8 (2.2.3)

      PLATFORMS
        ruby

      DEPENDENCIES
        ruby-oci8 (~> 2.2.3)

      BUNDLED WITH
        1.11.2
      EOS
      system "ruby23", "#{buildpath}/vendor/bundle/bin/bundle", "install",
             "--deployment",  "--gemfile", "Gemfile.local", "--no-cache",
             "--path", "vendor/bundle"
    end

    (bin/"msfbinscan").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfbinscan "$@"
    EOS
    (bin/"msfconsole").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfconsole "$@"
    EOS
    (bin/"msfd").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfd "$@"
    EOS
    (bin/"msfelfscan").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfelfscan "$@"
    EOS
    (bin/"msfmachscan").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfmachscan "$@"
    EOS
    (bin/"msfpescan").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfpescan "$@"
    EOS
    (bin/"msfrop").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfrop "$@"
    EOS
    (bin/"msfrpc").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfrpc "$@"
    EOS
    (bin/"msfrpcd").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfrpcd "$@"
    EOS
    #(bin/"msfupdate").write <<-EOS.undent
    #  #!/usr/bin/env bash
    #  export GEM_HOME="#{pkgshare}/vendor/bundle"
    #  export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
    #  {pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfupdate "$@"
    #EOS
    (bin/"msfvenom").write <<-EOS.undent
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby23 #{pkgshare}/msfvenom "$@"
    EOS

    pkgshare.install Dir['*']
    pkgshare.install ".git"
    pkgshare.install ".bundle"
  end
end
