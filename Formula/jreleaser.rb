# Generated with JReleaser 1.5.0-SNAPSHOT at 2023-02-26T14:50:16.547059026Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.5.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.0/jreleaser-standalone-1.5.0-linux-aarch64.zip"
    sha256 "65de7e3f031f9663779ce08d7bea6fa183e162588e61a87d2d045d167f8171b8"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.0/jreleaser-standalone-1.5.0-linux-x86_64.zip"
    sha256 "6513c1d6e0440cf2e382fda377c0bae9b84fc2ac04f3e6db6c83dda4b45ec847"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.0/jreleaser-standalone-1.5.0-osx-aarch64.zip"
    sha256 "3ac08599dce4d26c5761b6c7176df9eb353126fbccd58e0d0cde6ce8bf1e89e9"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.5.0/jreleaser-standalone-1.5.0-osx-x86_64.zip"
    sha256 "e2e495a9846a690a131694c1909e91d8ca856c0945d30a22cf5e1a94e51bfd27"
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
    assert_match "1.5.0", output
  end
end
