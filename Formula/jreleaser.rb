class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.6.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.6.0/jreleaser-0.6.0.zip"
  sha256 "3948a7457e4e6869138a34666f1eeb48216c8d5681dcd29318acc6418f92ed54"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.6.0", output
  end
end