# Generated with JReleaser 1.10.0-SNAPSHOT at 2023-12-31T16:01:47.022516386Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.10.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.10.0/jreleaser-standalone-1.10.0-linux-aarch64.zip"
    sha256 "2a2cc85e012ae4747880474c8e0d8353f5f4244375bf0ddf1dc70c1348a83847"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.10.0/jreleaser-standalone-1.10.0-linux-x86_64.zip"
    sha256 "2a791337414d53cc2f50f683969d7bc0e0314f1f4b70c85d197174b1b771b148"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.10.0/jreleaser-standalone-1.10.0-osx-aarch64.zip"
    sha256 "8d6351770413049234cbbe5726fdc53c1ab500ba2c0c153cd0b2dd1a7e0736d0"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.10.0/jreleaser-standalone-1.10.0-osx-x86_64.zip"
    sha256 "bddabbed7e423f60901b92919e4ee3214a73bab7ea1c5d3865e2c7c7da26ec38"
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
    assert_match "1.10.0", output
  end
end
