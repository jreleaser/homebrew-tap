class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.9.0/jreleaser-0.9.0.zip"
  version "0.9.0"
  sha256 "91d4f7df46122d83dd77029f290f69191d6305a9142c059be458f8cd1f4f7838"
  license "Apache-2.0"

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.9.0", output
  end
end
