class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.3.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.3.0/jreleaser-0.3.0.zip"
  sha256 "c1af5faa28e6a454031f739664833d89cf6743760e419a4d1f0e42789b954e73"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.3.0", output
  end
end