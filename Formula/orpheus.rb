class Orpheus < Formula
  desc "Now Playing overlay for OBS - Works with any music service"
  homepage "https://github.com/collectif-pixel/orpheus"
  url "https://github.com/collectif-pixel/orpheus/releases/download/v0.1.6/orpheus-darwin-arm64.tar.gz"
  sha256 "15079e443d9bdc20cacce7ae9521c24878d5046754d103d82920d0be1e0f528f"
  license "MIT"
  version "0.1.6"

  depends_on "media-control"
  depends_on :macos

  def install
    bin.install "orpheus"
  end

  def caveats
    <<~EOS
      To start Orpheus now and restart at login:
        brew services start orpheus

      Or run manually:
        orpheus start

      Then add http://localhost:3000/now-playing as a Browser Source in OBS.
    EOS
  end

  service do
    run [opt_bin/"orpheus", "start", "--foreground"]
    keep_alive true
    log_path var/"log/orpheus.log"
    error_log_path var/"log/orpheus.log"
  end

  test do
    assert_match "orpheus", shell_output("#{bin}/orpheus --help")
  end
end
