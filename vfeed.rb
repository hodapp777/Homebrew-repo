require 'formula'

class Vfeed < Formula
  homepage 'https://github.com/toolswatch/vFeed'
  url "https://github.com/toolswatch/vFeed", :using => :git, :revision => '4b70d92'
  version "0.7.0.1"
  revision 1

  def install
    inreplace "config/constants.py", /^db = .*$/, 'db = "'+pkgshare+'/vfeed.db"'
    inreplace "config/constants.py", /^db_location = .*$/, 'db_location = "'+pkgshare+'/vfeed.db"'
    inreplace "config/constants.py", /^export_dir = .*$/, 'export_dir = "."'
    inreplace "config/constants.py", /^csv_dir = .*$/, 'csv_dir = "./"'

    (bin/"vfeedcli.py").write <<-EOS.undent
       #!/usr/bin/env bash
       cd #{pkgshare} && python vfeedcli.py "$@"
    EOS

    pkgshare.install Dir["*"]
  end
end
