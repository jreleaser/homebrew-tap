# Generated with JReleaser 1.13.0-SNAPSHOT at 2024-06-30T10:12:21.291523965Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.13.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.0/jreleaser-standalone-1.13.0-linux-aarch64.zip"
    sha256 "968b5c48ab8b608e1c724d687970483b40662b7e4c318b20cf26a6cfb7564187"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.0/jreleaser-standalone-1.13.0-linux-x86_64.zip"
    sha256 "d4033b4290172c73828832343df38083178212e13de7525386abc31c5fcbcdc2"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.0/jreleaser-standalone-1.13.0-osx-aarch64.zip"
    sha256 "91fed89d5a9241175e958eb3606b5535a50027cc740ac5ed0740c369dbf1cbf7"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.13.0/jreleaser-standalone-1.13.0-osx-x86_64.zip"
    sha256 "f0202456fadeb3cd3c20d7355fb551fb391c81b20126f7ecf97de992ebfcc777"
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
    assert_match "1.13.0", output
  end
end
