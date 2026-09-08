# Homebrew formula for tl.
class Tl < Formula
  desc "Git-native task ledger for human and AI agent coordination"
  homepage "https://github.com/aholbreich/tl"
  version "0.11.0"
  license "MIT"

  head "https://github.com/aholbreich/tl.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-amd64.tar.gz"
      sha256 "4867e69c00ed9109fbcdf262206230e97822ee705ecee152404c83c021fae0fc"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-darwin-arm64.tar.gz"
      sha256 "0b47229a154eb6e50bcc033ddbdfb80c0a465a56c5debfbb5262ebf155d23ec9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-amd64.tar.gz"
      sha256 "7b4e7931bc871ebbba464af1e3b16c3b9f0a32e6e4a0d62416d8a5c262dcda18"
    else
      url "https://github.com/aholbreich/tl/releases/download/#{version}/tl-linux-arm64.tar.gz"
      sha256 "c1279ab46eb26c8187df953b5e26324020be9e4887a4204b558a948018ebc84d"
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
