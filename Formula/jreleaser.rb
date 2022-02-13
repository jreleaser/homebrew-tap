# Generated with JReleaser 1.0.0-SNAPSHOT at 2022-02-13T12:11:01.494659Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.0.0-M2"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M2/jreleaser-standalone-1.0.0-M2-linux-aarch64.zip"
    sha256 "87538ed9a3b62fc4f0f207ed23dd2954b1f84274da0056dbcddbccccc57949e0"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M2/jreleaser-standalone-1.0.0-M2-linux-x86_64.zip"
    sha256 "5df755974375b686afc392aeffa1c85914cd476d10b9791ca90d622a14e6270b"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M2/jreleaser-standalone-1.0.0-M2-osx-aarch64.zip"
    sha256 "08be1cfbe12060defc1b6f5326e8fa8bbef5b71fcf2a3bf6ed2f008ce7ba2f7a"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.0.0-M2/jreleaser-standalone-1.0.0-M2-osx-x86_64.zip"
    sha256 "c43725a9dcdc74eb6472a5742ae5e86f23e012dbee137e42316e0566eea4c346"
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
    assert_match "1.0.0-M2", output
  end
end
