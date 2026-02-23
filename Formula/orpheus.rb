class Orpheus < Formula
  desc "Now Playing overlay for OBS - Works with any music service"
  homepage "https://github.com/collectif-pixel/orpheus"
  url "https://github.com/collectif-pixel/orpheus/releases/download/v0.3.0/orpheus-darwin-arm64.tar.gz"
  sha256 "b79fa248ee62334d70813eb03cb46fa4bce93f6e08cc867f6a9322952c2dddea"
  license "MIT"
  version "0.3.0"

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
