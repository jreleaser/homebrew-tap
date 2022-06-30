# Generated with JReleaser 1.1.0-SNAPSHOT at 2022-06-30T15:46:43.841258289Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.1.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.1.0/jreleaser-standalone-1.1.0-linux-aarch64.zip"
    sha256 "0ebe8cc2aeb02345fdab38bcd739656b30dec05f941fa59efd002968f864f65d"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.1.0/jreleaser-standalone-1.1.0-linux-x86_64.zip"
    sha256 "8746059720dc8a51ddfb18d959670a9ce7719d9a7d22d805d4c0519d347d3f71"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.1.0/jreleaser-standalone-1.1.0-osx-aarch64.zip"
    sha256 "4cc9f7e08908668df0079cb9b8c3ac09797574765828684d44f77140de8d21af"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.1.0/jreleaser-standalone-1.1.0-osx-x86_64.zip"
    sha256 "a0228fbb8fce8e0fc9c70c1a4e426b64ae1212d3addb32621204a63bd548cdc0"
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
    assert_match "1.1.0", output
  end
end
