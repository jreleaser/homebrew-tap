# Generated with JReleaser 0.10.0-SNAPSHOT at 2021-12-28T14:52:05.57129Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "0.10.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v0.10.0/jreleaser-standalone-0.10.0-linux-aarch64.zip"
    sha256 "3518365f5f093bb6947b170fcc96da87589d5d589550d7d0fd64d3deeaa17bbd"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v0.10.0/jreleaser-standalone-0.10.0-linux-x86_64.zip"
    sha256 "51efafbc49dc035d2c89ae2ada9745c975f7a3e8fb54f1c608325d230ba908dc"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v0.10.0/jreleaser-standalone-0.10.0-osx-aarch64.zip"
    sha256 "1881fc7a88fd0ea687c9ff96aaca17821744ab5fb0813a85462578f990419c37"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v0.10.0/jreleaser-standalone-0.10.0-osx-x86_64.zip"
    sha256 "184540ecf756d688babbed32ef520042290fad21b5a38266d15143cc5d101439"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser"
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "0.10.0", output
  end
end
