# Generated with JReleaser 1.12.0-SNAPSHOT at 2024-05-01T13:00:50.646676518Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.12.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.12.0/jreleaser-standalone-1.12.0-linux-aarch64.zip"
    sha256 "c2be883fe5645d574938d112cd27300eab7ab2a67e4231a63afd81e559a77384"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.12.0/jreleaser-standalone-1.12.0-linux-x86_64.zip"
    sha256 "c53b89050d7d57f5bb2cd5166c0ad982b50ab861f2827516afcab8f0af9644b9"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.12.0/jreleaser-standalone-1.12.0-osx-aarch64.zip"
    sha256 "c978de2a988c23367e33b07ca6b4dd7c61986d6bd0697d10db7fc7536114b03f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.12.0/jreleaser-standalone-1.12.0-osx-x86_64.zip"
    sha256 "f55b06bd40e37490b94e53380b185a59174c16f021abf8c182269e1ebe6d6867"
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
    assert_match "1.12.0", output
  end
end
