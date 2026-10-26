cask "rmount-lite" do
  version "0.1.5"
  sha256 "2ff1bd1dffda4d320bf951d014b1524a087fdfa0e10278640631ead0ee9258fa"

  url "https://github.com/fperdigon/rmount/releases/download/v#{version}/rmount-lite-#{version}.dmg"
  name "RMount Lite"
  desc "Mount remote storage as native volumes, using your own rclone"
  homepage "https://github.com/fperdigon/rmount"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on formula: "rclone"
  depends_on macos: :sonoma

  app "rmount-lite.app"

  # RMount is signed ad hoc and not notarized, so clear the download flag or Gatekeeper refuses it.
  # Legacy postflight on purpose: it works on older Homebrew too; postflight_steps needs the newest.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/rmount-lite.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/ai.rmount.lite",
    "~/Library/Preferences/ai.rmount.lite.plist",
  ]
end
