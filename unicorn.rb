require "formula"

class Unicorn < Formula
  homepage "https://github.com/trustedsec/unicorn"
  url "https://github.com/trustedsec/unicorn", :using => :git, :revision => "da890f0"
  version "2.4.2"

  def install
    bin.install "unicorn.py"
    libexec.install Dir["*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
