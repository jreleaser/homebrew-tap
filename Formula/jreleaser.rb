# Generated with JReleaser 1.6.0-SNAPSHOT at 2023-03-12T10:15:10.135700883Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.5.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.1/jreleaser-standalone-1.5.1-linux-aarch64.zip"
    sha256 "5a2ca766be216a66b9a182f576061a28ced0f9c4feff9e9ed23daa6a68a420b8"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.1/jreleaser-standalone-1.5.1-linux-x86_64.zip"
    sha256 "e8886e4a036e47e5b77a1cee4e2612faafc58c7121baf88bab16fbfe50839e06"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.1/jreleaser-standalone-1.5.1-osx-aarch64.zip"
    sha256 "abe87231d04193f0eecbd1ec9b7ac69c4a7d0af0a0eab52e05ae93ad37d885f7"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.1/jreleaser-standalone-1.5.1-osx-x86_64.zip"
    sha256 "307b358b648e0e5d6130902c032cbe7509a934bdd4c869a2ccb2dafc0e4ade30"
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
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "1.5.1", output
  end
end
