# Homebrew formula for tl.
class Tl < Formula
  desc "Git-native task ledger for human and AI agent coordination"
  homepage "https://github.com/aholbreich/tl"
  version "0.8.0"
  license "MIT"

  head "https://github.com/aholbreich/tl.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-amd64.tar.gz"
      sha256 "ec4d877efc11cffb3da0d7c4652adc56d6ee49f4599fa2a9c3a0b4ba735a864d"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-arm64.tar.gz"
      sha256 "75cb692be75fe92f115d6876360557eb01d250432765212960ed0784840040ae"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-amd64.tar.gz"
      sha256 "c0a8af20b39f73fbec286bf126cc7dc70c738b0299fe0d35ca6df9735c129acb"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-arm64.tar.gz"
      sha256 "f0b6f66413dc2c723958892aa029fb2eb2791056fe26a38eb2b9c6e25ae9e10e"
    end
  end

  depends_on "go" => :build if build.head?

  def install
    if build.head?
      system "go", "build", "-o", bin/"tl", "-ldflags", "-s -w -X main.version=HEAD", "."
    else
      bin.install "tl"
    end
  end

  test do
    assert_match "tl version", shell_output("#{bin}/tl --version")
  end
end
