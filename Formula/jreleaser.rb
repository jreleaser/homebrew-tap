# Generated with JReleaser 1.15.0-SNAPSHOT at 2024-10-31T08:59:56.877249853Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.15.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.15.0/jreleaser-standalone-1.15.0-linux-aarch64.zip"
    sha256 "bc1e54f4638653e4ebb27a90c7ff322069099003f54423831bdb287884f08ee4"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.15.0/jreleaser-standalone-1.15.0-linux-x86_64.zip"
    sha256 "528eb1eb011798ad8b6a25c21aa6fcf414034e0b9b35aaa27aa658e5973b5dd7"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.15.0/jreleaser-standalone-1.15.0-osx-aarch64.zip"
    sha256 "56122a90d9efb4805fdce79d7a82ecc594b1c86675a8b3da6f92687ef2363edd"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.15.0/jreleaser-standalone-1.15.0-osx-x86_64.zip"
    sha256 "afe23adab54b10b2665536e130e8ad834292883000ee9a88e084294e4687d23b"
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
    assert_match "1.15.0", output
  end
end
