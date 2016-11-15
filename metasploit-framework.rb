require "formula"

class MetasploitFramework < Formula
  homepage "https://github.com/rapid7/metasploit-framework"
  # Last good version...
  #url "https://github.com/rapid7/metasploit-framework", :using => :git, :revision => '26da2a2'
  #version "4.12.14"
  url "https://github.com/rapid7/metasploit-framework", :using => :git, :revision => '77bacac'
  version "4.12.41"

  option "with-oracle", "Build with oracle support, requires a working installation of instantclient version 10.2"

  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "sqlite"
  depends_on "postgresql"
  depends_on "gmp"        # for ruby-oci8

  def install
    system "bundle", "install", "--deployment", "--no-cache", "--path", "vendor/bundle"

    if build.with? "oracle"
      (buildpath/"Gemfile.local").write <<-EOS.undent
      group :local do
        gem 'ruby-oci8', '~> 2.1.8'
      end
      EOS
      (buildpath/"Gemfile.local.lock").write <<-EOS.undent
      GEM
        remote: https://rubygems.org/
        specs:
          ruby-oci8 (2.1.8)

      PLATFORMS
        ruby

      DEPENDENCIES
        ruby-oci8 (~> 2.1.8)

      BUNDLED WITH
        1.11.2
      EOS
      system "bundle", "install", "--deployment", "--gemfile", "Gemfile.local", "--no-cache", "--path", "vendor/bundle"
    end

    (bin/"msfbinscan").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfbinscan "$@"
    EOS
    (bin/"msfconsole").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfconsole "$@"
    EOS
    (bin/"msfd").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfd "$@"
    EOS
    (bin/"msfelfscan").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfelfscan "$@"
    EOS
    (bin/"msfmachscan").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfmachscan "$@"
    EOS
    (bin/"msfpescan").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfpescan "$@"
    EOS
    (bin/"msfrop").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfrop "$@"
    EOS
    (bin/"msfrpc").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfrpc "$@"
    EOS
    (bin/"msfrpcd").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfrpcd "$@"
    EOS
    #(bin/"msfupdate").write <<-EOS.undent
    #  #!/usr/bin/env bash
    #  BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfupdate "$@"
    #EOS
    (bin/"msfvenom").write <<-EOS.undent
      #!/usr/bin/env bash
      BUNDLE_GEMFILE=#{pkgshare}/Gemfile bundle exec ruby #{pkgshare}/msfvenom "$@"
    EOS

    pkgshare.install Dir['*']
    pkgshare.install ".bundle"
  end
end
