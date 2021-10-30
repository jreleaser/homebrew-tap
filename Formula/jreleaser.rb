class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.8.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.8.0/jreleaser-0.8.0.zip"
  sha256 "be7d14d22d38e7a3fbd1a105f9d55d46afd773c9d8b0f983e6539692a042fca6"
  license "Apache-2.0"

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.8.0", output
  end
end