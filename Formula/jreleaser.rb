# Generated with JReleaser 1.17.0-SNAPSHOT at 2025-02-28T08:12:05.668760258Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.17.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.17.0/jreleaser-standalone-1.17.0-linux-aarch64.zip"
    sha256 "1a1e4fd9ec49e559460bfed4e4d396234203f5fc4e8dd2c6d55a6f75e81b70a0"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.17.0/jreleaser-standalone-1.17.0-linux-x86_64.zip"
    sha256 "2871057d2d496dcdf0409370e673f84f807d8c6866aaf6787c91059ab7227d7c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.17.0/jreleaser-standalone-1.17.0-osx-aarch64.zip"
    sha256 "de5a2491dfddcebe5f7bd3c8b23757856a3fe04e32ce247d5470dc54b5d2e793"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.17.0/jreleaser-standalone-1.17.0-osx-x86_64.zip"
    sha256 "406e3106f28de4865180368656ce23474ccbf84ff7eade6693cf7c8f5166d1c0"
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
    assert_match "1.17.0", output
  end
end
