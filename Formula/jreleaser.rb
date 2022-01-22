# Generated with JReleaser 1.0.0-SNAPSHOT at 2022-01-22T09:46:39.196814Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.0.0-M1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M1/jreleaser-standalone-1.0.0-M1-linux-aarch64.zip"
    sha256 "09438d0851e3a4ca727bed374e065bccd43c6e45ecbc5bcf82e6fd016f08702b"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M1/jreleaser-standalone-1.0.0-M1-linux-x86_64.zip"
    sha256 "8659cf636ced5bc37ae36bc0253116254da2eda320e4b613f7a93b9408ef5e25"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M1/jreleaser-standalone-1.0.0-M1-osx-aarch64.zip"
    sha256 "b7eef33fe33daab8c5ce0ba06da919f7cc43addad93a578e4f7db785ce4415cf"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M1/jreleaser-standalone-1.0.0-M1-osx-x86_64.zip"
    sha256 "da34a03795e4688673f3a419d51abc5f8f68796c6715672f45559b4cc21b4115"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "1.0.0-M1", output
  end
end
