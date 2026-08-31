# Generated with JReleaser 1.26.0-SNAPSHOT at 2026-08-31T07:37:41.529332195Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.26.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.26.0/jreleaser-standalone-1.26.0-linux-aarch64.zip"
    sha256 "356cd1b857873c39f0ce7cdff5473d61355689be602fe5f37646a6465044bf67"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.26.0/jreleaser-standalone-1.26.0-linux-x86_64.zip"
    sha256 "9e8dc7f91f0ea051d64b4d31cb14d6ee39730c8322cf77b63a8bda0317ed0c8c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.26.0/jreleaser-standalone-1.26.0-osx-aarch64.zip"
    sha256 "6afca52867b4f0363f19c02f1fd6b449d0f647bec63fa43556c5d9a66fe5a74c"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.26.0/jreleaser-standalone-1.26.0-osx-x86_64.zip"
    sha256 "d1c2f990a521ad15ec2d991092228342e361d201f68ec48c90fe5984ed1de1d7"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser" => "jreleaser"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "1.26.0", output
  end
end
