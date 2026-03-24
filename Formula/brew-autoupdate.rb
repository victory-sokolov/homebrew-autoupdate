class BrewAutoupdate < Formula
  desc "Selectively auto-update Homebrew packages using fzf"
  homepage "https://github.com/victory-sokolov/homebrew-autoupdate"
  url "https://github.com/victory-sokolov/homebrew-autoupdate/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "37c8e3d37bbe7d891c4889b201e3fbb3975f7273c546ee265ab6e9a431961352"
  license "MIT"
  head "https://github.com/victory-sokolov/homebrew-autoupdate.git", branch: "main"

  depends_on "fzf"

  def install
    (prefix/"VERSION").write version.to_s
    bin.install "bin/brew-autoupdate"
  end

  def caveats
    <<~EOS
      To get started, interactively select packages to auto-update:
        brew autoupdate select

      Then enable the background daemon (checks hourly by default):
        brew autoupdate start

      To check every 30 minutes instead:
        brew autoupdate start 1800

      View status and selected packages:
        brew autoupdate status
    EOS
  end

  test do
    assert_match(/brew-autoupdate \d+\.\d+\.\d+/, shell_output("#{bin}/brew-autoupdate version"))
  end
end
