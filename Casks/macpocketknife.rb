cask "macpocketknife" do
  version "0.2.0"
  sha256 "a95bacf79a03b5b2bce89e95756dd7de00b3afc6b7a7303c27a26b814b2a18f5"

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

  postflight_steps do
    # The app is ad-hoc signed and not notarized, so remove quarantine to prevent Gatekeeper blocking it.
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MacPocketKnife.app"]
  end

  uninstall quit: "io.github.fperdigon.macpocketknife"

  zap trash: [
    "~/Library/Application Support/MacPocketKnife",
    "~/Library/Caches/io.github.fperdigon.macpocketknife",
    "~/Library/Preferences/io.github.fperdigon.macpocketknife.plist",
  ]
end
