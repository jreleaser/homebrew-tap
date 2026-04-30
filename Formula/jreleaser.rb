# Generated with JReleaser 1.24.0-SNAPSHOT at 2026-04-30T11:17:23.903587413Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.24.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.24.0/jreleaser-standalone-1.24.0-linux-aarch64.zip"
    sha256 "3b9d73c8ec4c40128b4d96e07d89c01d4dfe3651a83d930791fd58cee78e9406"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.24.0/jreleaser-standalone-1.24.0-linux-x86_64.zip"
    sha256 "6fb3d30b82a95f3c8338c1d6b90027f748dd21063c50426951eac1bbaa0fda61"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.24.0/jreleaser-standalone-1.24.0-osx-aarch64.zip"
    sha256 "41205b5f14612a93bb5e8fcb5a909d3ff78320142f4127970096c80c85c6a356"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.24.0/jreleaser-standalone-1.24.0-osx-x86_64.zip"
    sha256 "b17a3ded5fc98b82c153de8ab24368187b8826237aefb8783d3305ad9252f0ec"
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
    assert_match "1.24.0", output
  end
end
