# Homebrew formula for tl.
class Tl < Formula
  desc "Git-native task ledger for human and AI agent coordination"
  homepage "https://github.com/aholbreich/tl"
  version "0.7.0"
  license "MIT"

  head "https://github.com/aholbreich/tl.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-amd64.tar.gz"
      sha256 "3eebd1b7369f8d7ebaba2c1ba757674529e7455518b6b292c984478fe4c990db"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-arm64.tar.gz"
      sha256 "2e38bba8d16b6e0cf8548351974492044a93199e041ab9edf38ba6b0b6333c87"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-amd64.tar.gz"
      sha256 "2fd98473eebdad366de08039193b5eb6e35085dcce45d9e30f4429140855594f"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-arm64.tar.gz"
      sha256 "1005b78c17f70a944e3dc6e01726345812f4fbc8b06b9a4e669d68e2bcdc9a59"
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
