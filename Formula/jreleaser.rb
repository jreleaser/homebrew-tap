# Generated with JReleaser 1.9.0-SNAPSHOT at 2023-11-01T11:30:46.9951+01:00
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.9.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.9.0/jreleaser-standalone-1.9.0-linux-aarch64.zip"
    sha256 "8650b88931ca5b9ed7c4d803db51e14accbf73289508edb5600c4308a95141b4"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.9.0/jreleaser-standalone-1.9.0-linux-x86_64.zip"
    sha256 "4ca02de2b8ac204dfd61ea081afb20792e9374c0787ece10276319aa091f9c4e"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.9.0/jreleaser-standalone-1.9.0-osx-aarch64.zip"
    sha256 "740cd96616206abdff081aede8bc64118b60acf06a4e97bfad50af8b02193fbc"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.9.0/jreleaser-standalone-1.9.0-osx-x86_64.zip"
    sha256 "1713553c2cc4de0a4ca3fe5f388cf1e6667758dd2483d98935d85f96c691805e"
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
        MachO.codesign!(dylib) if Hardware::CPU.arm?
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/jreleaser --version")
    assert_match "1.9.0", output
  end
end
