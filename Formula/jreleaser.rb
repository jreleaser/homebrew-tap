# Generated with JReleaser 1.0.0-SNAPSHOT at 2022-03-05T15:54:17.031894Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.0.0-M3"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M3/jreleaser-standalone-1.0.0-M3-linux-aarch64.zip"
    sha256 "3c8470b0d895f9e414fb5bbe4706a92f70e2d790f11f37d88ffb599fbe82cfbc"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M3/jreleaser-standalone-1.0.0-M3-linux-x86_64.zip"
    sha256 "cf0ab41e0a206ce78f00f0e5116537eca826cf411ca1826209aeab7a0754cecc"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M3/jreleaser-standalone-1.0.0-M3-osx-aarch64.zip"
    sha256 "601025ac28ad8bb95fb4661420c58c501bcb468d37f65cca8118d92f64b8373e"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M3/jreleaser-standalone-1.0.0-M3-osx-x86_64.zip"
    sha256 "cc520b9d3d5e5762702c26c72370e7d8b8bbcf88a0419f45699e69e90892639c"
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
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "1.0.0-M3", output
  end
end
