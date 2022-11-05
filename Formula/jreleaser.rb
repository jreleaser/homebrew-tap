# Generated with JReleaser 1.4.0-SNAPSHOT at 2022-11-05T10:10:05.154313676Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.3.1"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.1/jreleaser-standalone-1.3.1-linux-aarch64.zip"
    sha256 "08ca7f2a25ada26f1d7fde892309041ded2a0d6ac0b12d2b3f1d511f44fe980c"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.1/jreleaser-standalone-1.3.1-linux-x86_64.zip"
    sha256 "74771901cee8caf2b7324ee8501b7289ab4e5d0fc2a0e228fe1b9693155339e1"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.1/jreleaser-standalone-1.3.1-osx-aarch64.zip"
    sha256 "f64b614b8a3f7aed472db8b9a714a1cf8b40da6a280c39f19680e72aa938c052"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.3.1/jreleaser-standalone-1.3.1-osx-x86_64.zip"
    sha256 "0b97f412d9eb14c801742e6157ac24b840693bdad6365a255ebfe48833c2e1e4"
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
    assert_match "1.3.1", output
  end
end
