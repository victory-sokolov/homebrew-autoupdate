class BrewAutoupdate < Formula
  desc "Selectively auto-update Homebrew packages using fzf"
  homepage "https://github.com/yourusername/brew-autoupdate"
  version "1.0.0"

  # Replace with your actual tarball URL and sha256 after publishing
  # url "https://github.com/yourusername/brew-autoupdate/archive/refs/tags/v1.0.0.tar.gz"
  # sha256 "REPLACE_WITH_ACTUAL_SHA256"

  license "MIT"
  head "https://github.com/yourusername/brew-autoupdate.git", branch: "main"

  depends_on "fzf"

  def install
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
    assert_match "brew-autoupdate", shell_output("#{bin}/brew-autoupdate version")
  end
end
