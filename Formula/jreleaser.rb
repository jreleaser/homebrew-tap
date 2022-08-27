# Generated with JReleaser 1.2.0-SNAPSHOT at 2022-08-27T16:58:09.389566453Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.2.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.2.0/jreleaser-standalone-1.2.0-linux-aarch64.zip"
    sha256 "7d953571c3e9e9158780df4d9df769c1aa827ea1579d682293a7970b7eb7bf61"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.2.0/jreleaser-standalone-1.2.0-linux-x86_64.zip"
    sha256 "13044c0c4053704f4033d82ad847280a9bf6e2840864af6210606f15ddc4dfef"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.2.0/jreleaser-standalone-1.2.0-osx-aarch64.zip"
    sha256 "ea529d1b20975dc8c5f250e02bc43c66a0e793103070e10edc80cf765d4088f5"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.2.0/jreleaser-standalone-1.2.0-osx-x86_64.zip"
    sha256 "c9b85808e59f3b90e77d5615cc739ec3bc5c7d715443419fef19d43a3f732ec9"
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
    assert_match "1.2.0", output
  end
end
