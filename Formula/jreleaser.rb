class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.7.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.7.0/jreleaser-0.7.0.zip"
  sha256 "6889fc7887eb1c829cdf06f531d71d64872391622e36b009cfacf290802f141b"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.7.0", output
  end
end