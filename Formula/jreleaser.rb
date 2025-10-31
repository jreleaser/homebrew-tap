# Generated with JReleaser 1.21.0-SNAPSHOT at 2025-10-31T09:02:17.092272113Z

class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.21.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.21.0/jreleaser-standalone-1.21.0-linux-aarch64.zip"
    sha256 "be8d6a35de6915d1a56d8344f280116cd49a55effddeed201fd0b9d488c27938"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.21.0/jreleaser-standalone-1.21.0-linux-x86_64.zip"
    sha256 "380d22c15dfbddea29de9719cf2f0622d0c1583ec840712aab858f410752884f"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.21.0/jreleaser-standalone-1.21.0-osx-aarch64.zip"
    sha256 "8810da10d69df102f2fcd1e8207f7d48bf6398e8ebb793c22764ee0586ba7d11"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.21.0/jreleaser-standalone-1.21.0-osx-x86_64.zip"
    sha256 "f0a07e392fa17ca40b905e527b9b6ec469704aa075f855a6aef6c3803898d0bb"
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
    assert_match "1.21.0", output
  end
end
