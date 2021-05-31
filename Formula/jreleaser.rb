class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.4.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.4.0/jreleaser-0.4.0.zip"
  sha256 "10c971a4c7b4930c5104d4af7e5a83259bcf4ca29782a33da62c7827d145899f"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.4.0", output
  end
end