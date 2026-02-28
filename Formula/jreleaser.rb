# Generated with JReleaser 1.23.0-SNAPSHOT at 2026-02-28T07:45:23.249774677Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.23.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.23.0/jreleaser-standalone-1.23.0-linux-aarch64.zip"
    sha256 "965725890e3150db711f46049ffaf7e2871e6b03ddc12bc3f9bc8d680574aab9"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.23.0/jreleaser-standalone-1.23.0-linux-x86_64.zip"
    sha256 "68dc09206f84fb363d72da5ed16012a12fba48c20bcc6d9bb417d86d7ff86736"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.23.0/jreleaser-standalone-1.23.0-osx-aarch64.zip"
    sha256 "272db64cdcc6663f5c7a20c66ec934db188e021fc95904cba4a33028dce0b21f"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.23.0/jreleaser-standalone-1.23.0-osx-x86_64.zip"
    sha256 "a7c630fd235e8e6211491f2e6585ab0c34a898594a56fbf2b0f4ea24894d57d8"
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
    assert_match "1.23.0", output
  end
end
