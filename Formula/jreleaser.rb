# Generated with JReleaser 1.6.0-SNAPSHOT at 2023-04-29T10:13:03.544759325Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.6.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.6.0/jreleaser-standalone-1.6.0-linux-aarch64.zip"
    sha256 "d6ee9155934c4ecb622bf7ec3e701c72d26310f6746df297f4ad71372793cd59"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.6.0/jreleaser-standalone-1.6.0-linux-x86_64.zip"
    sha256 "78bb9d4a211af922bcb9e4d9ecb2481bf1a28b2b7709f22b833a9eb5377918f5"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.6.0/jreleaser-standalone-1.6.0-osx-aarch64.zip"
    sha256 "20f7366dc6372aebaac69a75678e255e64a11dee80f84bb83a1fdc169c8d0499"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.6.0/jreleaser-standalone-1.6.0-osx-x86_64.zip"
    sha256 "1e11b3ff10bb2c554dd1b2e9755561254481c5ec44fad7f16dba51c53f18314b"
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
    assert_match "1.6.0", output
  end
end
