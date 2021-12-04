class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.9.1/jreleaser-0.9.1.zip"
  version "0.9.1"
  sha256 "c834816967bf948e90837bb0d10f5f22290b20c617a29c3177a8051d5e74d956"
  license "Apache-2.0"

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.9.1", output
  end
end
