cask "rmount" do
  version "0.2.0"
  sha256 "b923236e6712e9490ce0a0b94d5e57420653efc5749ec33d3a2d82110fe42ec6"

  url "https://github.com/fperdigon/rmount/releases/download/v#{version}/rmount-#{version}.dmg"
  name "RMount"
  desc "Mount SFTP, S3, FTP, SMB, WebDAV and Google Drive as native volumes"
  homepage "https://github.com/fperdigon/rmount"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "rmount.app"

  # RMount is signed ad hoc and not notarized, so clear the download flag or Gatekeeper refuses it.
  # Legacy postflight on purpose: it works on older Homebrew too; postflight_steps needs the newest.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/rmount.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/ai.rmount",
    "~/Library/Preferences/ai.rmount.plist",
  ]
end
