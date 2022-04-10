# Generated with JReleaser 1.0.0-SNAPSHOT at 2022-04-10T05:36:33.640517Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.0.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0/jreleaser-standalone-1.0.0-linux-aarch64.zip"
    sha256 "08a3957f9562a62c8fb6d86559f20d521e0452e70183c893376b4c07ef453e2c"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0/jreleaser-standalone-1.0.0-linux-x86_64.zip"
    sha256 "583809566ddcfeb738b0f6db422bcc00ec28800242ca9572996011d7e93ec7c8"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0/jreleaser-standalone-1.0.0-osx-aarch64.zip"
    sha256 "61c3a8accc778bc62d3eec212b563d89fe610ea46bf6bcdef3f5bfd345f8f877"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0/jreleaser-standalone-1.0.0-osx-x86_64.zip"
    sha256 "1214799ddd407a2541db883e26880ac23bf6aa8724451e771b72ba96e5ccc124"
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
    assert_match "1.0.0", output
  end
end
