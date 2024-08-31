# Generated with JReleaser 1.14.0-SNAPSHOT at 2024-08-31T07:00:25.327300349Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.14.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.14.0/jreleaser-standalone-1.14.0-linux-aarch64.zip"
    sha256 "6efdade50c38c884ef2f77d78cf4fc72ce56f65b49d0f08f8ca062ffdf6b6768"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.14.0/jreleaser-standalone-1.14.0-linux-x86_64.zip"
    sha256 "b2f0b9e7926279aefc5a291f50b6a659641a9e7eb408b3988c81a4eeed970f32"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.14.0/jreleaser-standalone-1.14.0-osx-aarch64.zip"
    sha256 "ad4466cc0e044331ba242e9d148d8104b490cb11173290b79fd9599b8deae384"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.14.0/jreleaser-standalone-1.14.0-osx-x86_64.zip"
    sha256 "f59294c622adf8c8eb8bbdf98e72632ab04c41f8f4ae9f3a7623011ef1c7ce81"
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
    assert_match "1.14.0", output
  end
end
