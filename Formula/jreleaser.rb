# Generated with JReleaser 1.4.0-SNAPSHOT at 2022-12-29T16:04:33.910943262Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.4.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.4.0/jreleaser-standalone-1.4.0-linux-aarch64.zip"
    sha256 "aa9a591847061b73cfd0bd1105c8330cd80b30732d9d0f8f754e2050826c0559"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.4.0/jreleaser-standalone-1.4.0-linux-x86_64.zip"
    sha256 "8fb25e06f421892836271995dffcf2a5c1afac25e9369f7dd2de58413496b7a0"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.4.0/jreleaser-standalone-1.4.0-osx-aarch64.zip"
    sha256 "aceb0accd7c397bb799b69945a4dac2b7031b26868a813e5c3648cea643c165f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.4.0/jreleaser-standalone-1.4.0-osx-x86_64.zip"
    sha256 "41b01d5b463eae819218edffb8626e53f2b88ef82d2317450533a2fb22c57049"
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
    assert_match "1.4.0", output
  end
end
