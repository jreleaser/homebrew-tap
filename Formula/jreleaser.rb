# Generated with JReleaser 1.8.0-SNAPSHOT at 2023-08-31T22:12:22.043287351Z
class Jreleaser < Formula
  desc "Release projects quickly and easily with JReleaser"
  homepage "https://jreleaser.org"
  version "1.8.0"
  license "Apache-2.0"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.8.0/jreleaser-standalone-1.8.0-linux-aarch64.zip"
    sha256 "2efcde7f698feaed5135d15c71c9068d3b0759cbfc36492637c22b98de0e2425"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.8.0/jreleaser-standalone-1.8.0-linux-x86_64.zip"
    sha256 "ad9f70fc724fa1009ec05ec68b84ac306ad54f2e16c2cc0ec32cb3018105ae62"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.8.0/jreleaser-standalone-1.8.0-osx-aarch64.zip"
    sha256 "34af29c284f3f69707c741ea96f779b5dcbe64cbdb124743ca3cf93173560df6"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/jreleaser/jreleaser/releases/download/v1.8.0/jreleaser-standalone-1.8.0-osx-x86_64.zip"
    sha256 "dd9e195a3199457b14b68f9eadf62a0498c4161640f190182f60463d6c317d77"
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
    assert_match "1.8.0", output
  end
end
