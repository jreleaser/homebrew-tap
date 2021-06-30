class Jreleaser < Formula
  desc "Release Java projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.5.0"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.5.0/jreleaser-0.5.0.zip"
  sha256 "d770b9e9862e7aae3da2c2217d6b38cb04eeab9d8a98fb330e1eba2693a9ee4e"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk@8"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.5.0", output
  end
end