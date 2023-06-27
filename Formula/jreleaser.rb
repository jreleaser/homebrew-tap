# Generated with JReleaser 1.7.0-SNAPSHOT at 2023-06-27T13:02:28.955362088Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.7.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.7.0/jreleaser-standalone-1.7.0-linux-aarch64.zip"
    sha256 "707b8b24c10e70cb26dd978e2e1351c39f118ef85f54760a87e8ab7591112719"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.7.0/jreleaser-standalone-1.7.0-linux-x86_64.zip"
    sha256 "932013cfcdd5c18237065419d686c0524b0d1f01812fd67e248ad1fbe9ff913a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.7.0/jreleaser-standalone-1.7.0-osx-aarch64.zip"
    sha256 "e13253be304638b44fa84e884b93fb05b92cd8d6890206112c4b6e9e4b263a16"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.7.0/jreleaser-standalone-1.7.0-osx-x86_64.zip"
    sha256 "7a1947c973e5ab528fa61038433d02b09240f3be6e45212fd2bc003709ced828"
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
    assert_match "1.7.0", output
  end
end
