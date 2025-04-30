# Generated with JReleaser 1.18.0-SNAPSHOT at 2025-04-30T09:23:20.225786408Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.18.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.18.0/jreleaser-standalone-1.18.0-linux-aarch64.zip"
    sha256 "8f0104ef5d8211201993271d9035d6c8dc35e6120cf7d780912ac8756dd7b55b"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.18.0/jreleaser-standalone-1.18.0-linux-x86_64.zip"
    sha256 "65a150701411d56c4ffea27381da4318a7e15224c170f863673b7e098d2f6d4b"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.18.0/jreleaser-standalone-1.18.0-osx-aarch64.zip"
    sha256 "266347fe765f0a2052df49c6e1e5a463e0008f1b0543584c235326449a43f3df"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.18.0/jreleaser-standalone-1.18.0-osx-x86_64.zip"
    sha256 "70c96b110182f4bb95a3e7e8cffd157d22b0a772ecdb90e89a35d43b111a2578"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/jreleaser" => "jreleaser"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "1.18.0", output
  end
end
