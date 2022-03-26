# Generated with JReleaser 1.0.0-SNAPSHOT at 2022-03-26T09:55:36.29189Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.0.0-RC1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC1/jreleaser-standalone-1.0.0-RC1-linux-aarch64.zip"
    sha256 "49068463c9b875a35fdbc975aae890043d115a8bca32abb45c6fa1b378603e6a"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC1/jreleaser-standalone-1.0.0-RC1-linux-x86_64.zip"
    sha256 "523e52b6a4523cd98d65f52ec7641432b042aa7b91985a8616eb8d14c4b096db"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC1/jreleaser-standalone-1.0.0-RC1-osx-aarch64.zip"
    sha256 "c6542188ed1ee1068e7f3704a502db025fc426c6e6dfdd355f8a9a7b12dff3c8"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-RC1/jreleaser-standalone-1.0.0-RC1-osx-x86_64.zip"
    sha256 "f8665cf0c5b98185b589434e43f1707eece73f8b84b12e8a118820ed3dca5ea7"
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
    assert_match "1.0.0-RC1", output
  end
end
