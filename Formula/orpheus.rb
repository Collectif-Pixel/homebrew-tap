class Orpheus < Formula
  desc "Now Playing overlay for OBS - Works with any music service"
  homepage "https://github.com/collectif-pixel/orpheus"
  url "https://github.com/collectif-pixel/orpheus/releases/download/v0.2.2/orpheus-darwin-arm64.tar.gz"
  sha256 "ef7884528561698194b6990d88451d0515e2ca0533f97b32a4d21cb24dd1ecfa"
  license "MIT"
  version "0.2.2"

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
