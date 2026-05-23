# Homebrew formula for tl.
class Tl < Formula
  desc "Git-native task ledger for human and AI agent coordination"
  homepage "https://github.com/aholbreich/tl"
  version "0.4.2"
  license "MIT"

  head "https://github.com/aholbreich/tl.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-amd64.tar.gz"
      sha256 "edf04793137adf57db84a113a0a9cdf1f3c554a1ac2d4ef16e6b52a502c5338c"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-arm64.tar.gz"
      sha256 "558987712a3a7ddf69804118e5cfb055dca33b72f1a423c3c69f515b1e7ca2ba"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-amd64.tar.gz"
      sha256 "07d95a63ff21bf3f9cb9130544bba1d3df6abd3911c4e1c75995ade29f954f5e"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-arm64.tar.gz"
      sha256 "abf7129f9357eff924913037d17f6d67a55f7eb836f5f33f6301311b70b6f9bf"
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
