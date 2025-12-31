# Generated with JReleaser 1.22.0-SNAPSHOT at 2025-12-31T15:00:51.881964587Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.22.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.22.0/jreleaser-standalone-1.22.0-linux-aarch64.zip"
    sha256 "642a8ee4686456b4c3058ee291c09bcae8215c6bf305dc0216c301460206ed81"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.22.0/jreleaser-standalone-1.22.0-linux-x86_64.zip"
    sha256 "a3569fa453d14be806d47840ca503490a146e2dd4cde7c414985169b82d8bdc3"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.22.0/jreleaser-standalone-1.22.0-osx-aarch64.zip"
    sha256 "b250180a1a32bc83565c0bdb195583f63c1b63e3c26fd38ac070fe8968712d09"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.22.0/jreleaser-standalone-1.22.0-osx-x86_64.zip"
    sha256 "6bfda09f981eb5dd2e2f497ea9c8193b19d0d3d29ac4d45a3babe8aa35f9b307"
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
    assert_match "1.22.0", output
  end
end
