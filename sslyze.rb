require 'formula'

class Sslyze < Formula
  homepage 'https://github.com/nabla-c0d3/sslyze'
  if OS.linux?
    if Hardware.is_64_bit?
      url 'https://github.com/nabla-c0d3/sslyze/releases/download/release-0.10/sslyze-0_10-linux64.zip'
      sha1 '5b17aee4802f3c4bbc74b8e10f131522a4dbb320'
    else
      url 'https://github.com/nabla-c0d3/sslyze/releases/download/release-0.10/sslyze-0_10-linux32.zip'
      sha1 'd9ed490681d44c4c9d69a03ecb0bf4283c0de7c1'
    end
  else
      url 'https://github.com/nabla-c0d3/sslyze/releases/download/release-0.10/sslyze-0_10-osx64.zip'
      sha1 '57ddf9083aa0e32fd31662af4735aa9f94ef499e'
  end
  version '0.10'

  resource "sslyze_sh" do
    url 'https://raw.githubusercontent.com/sidaf/homebrew-linux/master/sslyze'
    sha1 '219d840b4e4bab3b1a0ab6d92d20a4c03e991670'
  end

  def install
    #ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    #system "python", *Language::Python.setup_install_args(libexec)

    #bin.install Dir["#{libexec}/bin/*"]
    #bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])

    # FIX: For some reason when doing it the recommended way, the 
    # PluginChromeSha1Deprecation and PluginCertInfo plugins complain.
    # So for now just hack it
    bin.install resource("sslyze_sh")
    inreplace "#{bin}/sslyze" do |s|
      s.gsub! /@replace@/, "#{libexec}/bin"
    end
    libexec.install Dir['*']
  end

  test do
    system "#{bin}/sslyze"
  end
end
