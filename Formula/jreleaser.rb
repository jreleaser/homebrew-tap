class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.1.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.1.0/jreleaser-0.1.0.zip"
  sha256 "00d0f8897f18a1d2670701af1451fd5c55f89ec59d880805d7f5dd6cc5fc8fa4"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.1.0", output
  end
end