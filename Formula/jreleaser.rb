class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.2.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.2.0/jreleaser-0.2.0.zip"
  sha256 "a70268d8047bd8cb05226a8d5ca840aa5ca2b1f19741908e0c76fee2b46f45f0"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.2.0", output
  end
end