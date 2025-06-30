# Generated with JReleaser 1.19.0-SNAPSHOT at 2025-06-30T19:01:50.059412808Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.19.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.19.0/jreleaser-standalone-1.19.0-linux-aarch64.zip"
    sha256 "34f24dc28cfc96efc14f32f3f9edc32896ceae8896c8317eb5783b1a3ed72905"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.19.0/jreleaser-standalone-1.19.0-linux-x86_64.zip"
    sha256 "719078f9083e0cd79898ab9aded7aa175ddc13ccadb9017d08d426cfd068cdde"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.19.0/jreleaser-standalone-1.19.0-osx-aarch64.zip"
    sha256 "99b70e45da159cbde093dedbf652ce8ccc8795aa8f7721fbacb41683a44b183f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.19.0/jreleaser-standalone-1.19.0-osx-x86_64.zip"
    sha256 "a4b76e31b0ec19d38f94a110d89aef8fac578a4f9b2b3add3d1c4a4d9a7c71d0"
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
    assert_match "1.19.0", output
  end
end
