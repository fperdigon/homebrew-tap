cask "macpocketknife" do
  version "0.2.2"
  sha256 "e89bd1db6a8ee389ecd1e69703f67b8c626a154294330b160d7a8f1dd9e40fae"

  url "https://github.com/fperdigon/macpocketknife/releases/download/v#{version}/MacPocketKnife-#{version}.dmg"
  name "MacPocketKnife"
  desc "Pocket multi-tool for the menu bar, starting with a battery guard"
  homepage "https://github.com/fperdigon/macpocketknife"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "MacPocketKnife.app"

  # MacPocketKnife is ad-hoc signed and not notarized, so clear the download flag or Gatekeeper refuses it.
  # Legacy postflight on purpose: it works on older Homebrew too; postflight_steps needs the newest.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/MacPocketKnife.app"],
                   must_succeed: false
  end

  uninstall quit: "io.github.fperdigon.macpocketknife"

  zap trash: [
    "~/Library/Application Support/MacPocketKnife",
    "~/Library/Caches/io.github.fperdigon.macpocketknife",
    "~/Library/Preferences/io.github.fperdigon.macpocketknife.plist",
  ]
end
