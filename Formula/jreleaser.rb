class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  url "https://github.com/jreleaser/jreleaser/releases/download/v0.9.0/jreleaser-0.9.0.zip"
  version "0.9.0"
  sha256 "2a0e82f59400bfa0e87ed42ca10a824ce830d856df28a944e1ae1467cdad18fa"
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
