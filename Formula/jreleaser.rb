# Generated with JReleaser 1.20.0-SNAPSHOT at 2025-08-31T16:31:37.345453357Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.20.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.20.0/jreleaser-standalone-1.20.0-linux-aarch64.zip"
    sha256 "3c8ec8ff2435e907ef66b4a0c1c1aab89a06e1282a1bb38d7cefedc680c8a3d8"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.20.0/jreleaser-standalone-1.20.0-linux-x86_64.zip"
    sha256 "2cdbaacd4b615cf0119f1684ffecbd72ee3c76f31fc2c6a9457c386d791f9159"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.20.0/jreleaser-standalone-1.20.0-osx-aarch64.zip"
    sha256 "5e763500ca20628f9de01482428330e45a589c6089f4ef20c152a76708d66637"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.20.0/jreleaser-standalone-1.20.0-osx-x86_64.zip"
    sha256 "9d3adfcff9320e5e9d5a1a40c590ecedde526ecd6453b94fbc12fe88882b1216"
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
    assert_match "1.20.0", output
  end
end
