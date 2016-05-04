require 'formula'

class Ysoserial < Formula
  homepage 'https://github.com/frohoff/ysoserial'
  url 'https://github.com/frohoff/ysoserial', :using => :git, :revision => '87c91b2'
  version '0.0.4'

  depends_on "maven" => :build
  depends_on :java => "1.7"

  def install
    ENV.java_cache

    system "mvn", "-DskipTests", "clean", "package"
    libexec.install Dir["target/ysoserial-*.jar"]
    bin.write_jar_script "#{libexec}/ysoserial-#{version}-all.jar", "ysoserial"
  end
end
