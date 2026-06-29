# Generated with JReleaser 1.25.0-SNAPSHOT at 2026-06-29T07:57:31.988946286Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.25.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.25.0/jreleaser-standalone-1.25.0-linux-aarch64.zip"
    sha256 "05a64412eb03353d785267caad42049d279029cb7ed558ee3946ab67abf47c1c"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.25.0/jreleaser-standalone-1.25.0-linux-x86_64.zip"
    sha256 "8d977f02c4ca1151e6335390aaac32bbe7c213664211341944ac94737c325733"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.25.0/jreleaser-standalone-1.25.0-osx-aarch64.zip"
    sha256 "9e2f48d88e825dc0f09bb9dafeda86773c4c0edfa48ca9f982b12f94da932622"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.25.0/jreleaser-standalone-1.25.0-osx-x86_64.zip"
    sha256 "97b281380aec5095bdd0179c27e5bf16e3c5abef1ca8dd0173947b64b170e368"
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
    assert_match "1.25.0", output
  end
end
