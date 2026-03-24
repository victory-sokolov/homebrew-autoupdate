class BrewAutoupdate < Formula
  desc "Selectively auto-update Homebrew packages using fzf"
  homepage "https://github.com/victory-sokolov/homebrew-autoupdate"
  url "https://github.com/victory-sokolov/homebrew-autoupdate/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "825144d97d4cd33dd40c114b83cbc3bfaa13070272ba5c011b6f1d0130ea8250"
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
