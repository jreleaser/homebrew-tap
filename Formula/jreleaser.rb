# Generated with JReleaser 1.11.0-SNAPSHOT at 2024-02-29T12:31:31.529400801Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.11.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.11.0/jreleaser-standalone-1.11.0-linux-aarch64.zip"
    sha256 "d672a8745759413db405f3879aee7d754fd59600711ecc8e551d582b4f06cd18"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.11.0/jreleaser-standalone-1.11.0-linux-x86_64.zip"
    sha256 "4abc9b4e54ea6f6b85fc6863a425423821fb7ae9bc5875c659e9b23ee5b9bd2a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.11.0/jreleaser-standalone-1.11.0-osx-aarch64.zip"
    sha256 "96a254c387ac1dd1236612de22e9d6350cc0e08c426af771476230704199eaf5"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.11.0/jreleaser-standalone-1.11.0-osx-x86_64.zip"
    sha256 "a3a1c6967b015570eea3fbc6c533800973e70db4f8304b885b5e1e3e34fcd3fa"
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
    assert_match "1.11.0", output
  end
end
