# Generated with JReleaser 1.16.0-SNAPSHOT at 2024-12-31T11:03:40.173959401Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.16.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.16.0/jreleaser-standalone-1.16.0-linux-aarch64.zip"
    sha256 "51e1738ea03ee82ba4b6367657e090d6c975cf331823ccdc2139c87603fe3d10"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.16.0/jreleaser-standalone-1.16.0-linux-x86_64.zip"
    sha256 "1d46e17765588218d255c2fb7655ae95afb37f10c0653991ad7aad1b8fa08612"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.16.0/jreleaser-standalone-1.16.0-osx-aarch64.zip"
    sha256 "db95c809d5adb68c0a43ac26eb11a57f7118ee07ca57b3bd25099415fcd3c556"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.16.0/jreleaser-standalone-1.16.0-osx-x86_64.zip"
    sha256 "715cd5c8361a9a288639eecc42d8c20921c074ca0f4d8d7c2cd7546689b2f997"
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
    assert_match "1.16.0", output
  end
end
