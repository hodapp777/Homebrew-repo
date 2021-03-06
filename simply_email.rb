require 'formula'

class SimplyEmail < Formula
  homepage 'https://github.com/killswitch-GUI/SimplyEmail'
  url 'https://github.com/killswitch-GUI/SimplyEmail', :using => :git, :revision => 'bd98b02'
  head 'https://github.com/killswitch-GUI/SimplyEmail', :using => :git
  version '1.4.1'
  revision 2

  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "antiword"
  depends_on "odt2txt"

  resource "lxml" do
    url "https://pypi.python.org/packages/63/c7/4f2a2a4ad6c6fa99b14be6b3c1cece9142e2d915aa7c43c908677afc8fa4/lxml-3.4.4.tar.gz"
    sha256 "b3d362bac471172747cda3513238f115cbd6c5f8b8e6319bf6a97a7892724099"
  end

  resource "xlsxwriter" do
    url "https://pypi.python.org/packages/01/25/bcb25ccf1361c660606e887a1154a2c9ef69a0b02dc99c7b7279c32b33b4/XlsxWriter-0.8.5.tar.gz"
    sha256 "f8402e8dc3bd4020f8189493333a675d5b82a90572bf99c159aefeafac02351f"
  end

  resource "beautifulsoup4" do
    url "https://pypi.python.org/packages/26/79/ef9a8bcbec5abc4c618a80737b44b56f1cb393b40238574078c5002b97ce/beautifulsoup4-4.4.1.tar.gz"
    sha256 "87d4013d0625d4789a4f56b8d79a04d5ce6db1152bb65f1d39744f7709a366b4"
  end

  resource "python-magic" do
    url "https://pypi.python.org/packages/bb/03/1246519939004c60fc34c7bed9c0ab0e7d1b972b9278e5394bed942446a3/python-magic-0.4.11.tar.gz"
    sha256 "89021e288d6efd22cde2842349d79939b9664efdbf99f5790c9862a67759ea94"
  end

  resource "fake-useragent" do
    url "https://pypi.python.org/packages/c7/9d/698cb8ceb2cd922e135f4e5463475cde76fe6f2d2e2fc852de61ac2b61b0/fake-useragent-0.0.8.tar.gz"
    sha256 "59c2d7d45674f5d4b915ba9c4f7fabdf5d10df8821c924c0d3204e9e8387d1a5"
  end

  resource "mechanize" do
    url "https://pypi.python.org/packages/32/bc/d5b44fe4a3b5079f035240a7c76bd0c71a60c6082f4bfcb1c7585604aa35/mechanize-0.2.5.tar.gz"
    sha256 "2e67b20d107b30c00ad814891a095048c35d9d8cb9541801cebe85684cc84766"
  end

  resource "docx2txt" do
    url "https://pypi.python.org/packages/aa/72/f02730ec3b0219d8f783a255416339b02ff8b6a300c817abf0505833212a/docx2txt-0.6.tar.gz"
    sha256 "24740c6574c5e483afc589206df4ab493b2495d4ae07f1ccb6125e5b8bfe1338"
  end

  resource "requests" do
    url "https://pypi.python.org/packages/f9/6d/07c44fb1ebe04d069459a189e7dab9e4abfe9432adcd4477367c25332748/requests-2.9.1.tar.gz"
    sha256 "c577815dd00f1394203fc44eb979724b098f88264a9ef898ee45b8e5e9cf587f"
  end

  resource "xlsx2csv" do
    url "https://pypi.python.org/packages/9f/69/24d590eeea095e8cadb8301aaffdc665f00e08a154e36f2a7ef3c0d179f8/xlsx2csv-0.7.2.tar.gz"
    sha256 "7c6c8fa6c2774224d03a6a96049e116822484dccfa3634893397212ebcd23866"
  end

  resource "configparser" do
    url "https://pypi.python.org/packages/cf/59/d42a1e75fd73800f615ef7f63de2975c92b3f7267036f9f99711704525f3/configparser-3.3.0r2.tar.gz"
    sha256 "6a2318590dfc4013fc5bf53c2bec14a8cb455a232295eb282a13f94786c4b0b2"
  end

  resource "BeautifulSoup" do
    url "https://pypi.python.org/packages/1e/ee/295988deca1a5a7accd783d0dfe14524867e31abb05b6c0eeceee49c759d/BeautifulSoup-3.2.1.tar.gz"
    sha256 "6a8cb4401111e011b579c8c52a51cdab970041cc543814bbd9577a4529fe1cdb"
  end

  resource "pdfminer" do
    url "https://pypi.python.org/packages/57/4f/e1df0437858188d2d36466a7bb89aa024d252bd0b7e3ba90cbc567c6c0b8/pdfminer-20140328.tar.gz"
    sha256 "ba187b93056586a14edd5e630cf63ae96b1cc84b611f55dcddbc997316d9f262"
  end

  resource "dnspython" do
    url "https://pypi.python.org/packages/b3/e3/091c6489f0b573b8a4069ce956d037061ae9321401c89323386fe748dc9f/dnspython-1.12.0.zip"
    sha256 "63bd1fae61809eedb91f84b2185816fac1270ae51494fbdd36ea25f904a8502f"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    %w[xlsxwriter beautifulsoup4 python-magic fake-useragent mechanize docx2txt requests xlsx2csv configparser BeautifulSoup pdfminer dnspython].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    #inreplace "SimplyEmail.py", "import configparser", "import ConfigParser"
    #inreplace "Common/TaskController.py", "import configparser", "import ConfigParser"
    #inreplace "Helpers/EmailFormat.py", "import configparser", "import ConfigParser"
    #inreplace "Helpers/LinkedinNames.py", "import configparser", "import ConfigParser"
    #inreplace "Helpers/Download.py", "import configparser", "import ConfigParser"
    #inreplace "Helpers/Connect6.py", "import configparser", "import ConfigParser"
    #inreplace "Helpers/VerifyEmails.py", "import configparser", "import ConfigParser"
    #inreplace "Helpers/VersionCheck.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/PasteBinSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/OnionStagram.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/YahooSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/WhoisAPISearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GoogleDocSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/FlickrSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GoogleDocxSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/HtmlScrape.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/ExaleadDOCSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/CanaryBinSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/ExaleadXLSXSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GitHubUserSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GitHubCodeSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/ExaleadSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/ExaleadPDFSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/SearchPGP.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/EmailHunter.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/CanarioAPI.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/AskSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/ExaleadDOCXSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GoogleXLSXSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GooglePDFSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GoogleSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/Whoisolgy.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/GitHubGistSearch.py", "import configparser", "import ConfigParser"
    #inreplace "Modules/RedditPostSearch.py", "import configparser", "import ConfigParser"

    ENV.prepend_create_path "PYTHONPATH", libexec

    (bin/"SimplyEmail").write <<~EOS
      #!/usr/bin/env bash
      cd #{libexec} && PYTHONPATH=#{ENV["PYTHONPATH"]} python SimplyEmail.py "$@"
    EOS

    #bin.install "SimplyEmail.py"
    libexec.install Dir["*"]
    #bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
