require "formula"

class MagicUnicorn < Formula
  homepage "https://github.com/trustedsec/unicorn"
  url "https://github.com/trustedsec/unicorn", :using => :git, :revision => "56cec2f"
  version "2.7.3"

  def install
    bin.install "unicorn.py"
    libexec.install Dir["*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
