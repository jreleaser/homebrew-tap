# Generated with JReleaser 1.0.0-SNAPSHOT at 2022-04-02T15:50:07.287489Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.0.0-RC2"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC2/jreleaser-standalone-1.0.0-RC2-linux-aarch64.zip"
    sha256 "b483bff8e3b267c26616fdde1173cad7d8a7d85c9581023e22b855527df253be"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC2/jreleaser-standalone-1.0.0-RC2-linux-x86_64.zip"
    sha256 "a8589e8e4a4bd31ac174baa348bc625dbe7ed7b0ded8b23e97273b014390f1a6"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC2/jreleaser-standalone-1.0.0-RC2-osx-aarch64.zip"
    sha256 "0530a7551008ecd76e0f00dd4d7041c6160aba0d450992d6be4b2e8308f563cc"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC2/jreleaser-standalone-1.0.0-RC2-osx-x86_64.zip"
    sha256 "1873c754935df4b0d9f178319295d1912e533bc76c4b00a047fb09437fe462e5"
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
    assert_match "1.0.0-RC2", output
  end
end
