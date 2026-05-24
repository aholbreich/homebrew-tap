# Homebrew formula for tl.
class Tl < Formula
  desc "Git-native task ledger for human and AI agent coordination"
  homepage "https://github.com/aholbreich/tl"
  version "0.6.0"
  license "MIT"

  head "https://github.com/aholbreich/tl.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-amd64.tar.gz"
      sha256 "66aee59474dc39e31ade3217a75192b540a89eddd75d1dcbcc5be2a74138f57b"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-arm64.tar.gz"
      sha256 "9100739e33c3f789043c937bba2f9268884542f3c2a0772c294fbdbe5f8c5128"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-amd64.tar.gz"
      sha256 "ab7a2fd929cf061d4b61eed1aa03f0cb3dd19827ece11f1b9f42a2bbaa4ef797"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-arm64.tar.gz"
      sha256 "98f9a5b43eae1f6783f51ac420b1cd97fe7edecd4883761836c56558322bf211"
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
