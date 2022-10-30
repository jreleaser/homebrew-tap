# Generated with JReleaser 1.3.0-SNAPSHOT at 2022-10-30T12:12:20.961917986Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.3.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.0/jreleaser-standalone-1.3.0-linux-aarch64.zip"
    sha256 "f69dceb0bad7a9ed422d1492b2acca8ffd22f1b232b3a5bf07349aac4ee001df"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.0/jreleaser-standalone-1.3.0-linux-x86_64.zip"
    sha256 "21120d133f0d872bbcfc8e84c659d74c389565432e2ffde9b50c8da209a20b50"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.0/jreleaser-standalone-1.3.0-osx-aarch64.zip"
    sha256 "1f061dbb51ab75b06bfc112256b888eec28649ec4721bd87e0f2f92e12fcae34"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.0/jreleaser-standalone-1.3.0-osx-x86_64.zip"
    sha256 "7921f0d57546235817d717058b9f1a01fa214909a6f99fa98b740bab18a1e6fc"
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
    assert_match "1.3.0", output
  end
end
