# Generated with JReleaser 1.14.0-SNAPSHOT at 2024-06-30T13:00:04.112802098Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.13.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.1/jreleaser-standalone-1.13.1-linux-aarch64.zip"
    sha256 "58705fa3019f909d9035300a3ea103e49645080ec03d28be897f98ff9b38ce2e"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.1/jreleaser-standalone-1.13.1-linux-x86_64.zip"
    sha256 "ccb34209c93f3ce2ad7c43d806271a6b9d558876e0ba82f333a74fa2d6e4f237"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.1/jreleaser-standalone-1.13.1-osx-aarch64.zip"
    sha256 "aa5930a7631592e00b7600b4656b8840ba37ed830e571ae5fc47d26ae7d59bc0"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.1/jreleaser-standalone-1.13.1-osx-x86_64.zip"
    sha256 "b10707c6a56c499a0cc99d66582380834de7e290318a036971b5e1b92e3f2dad"
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
    assert_match "1.13.1", output
  end
end
