cask "macpocketknife" do
  version "0.2.1"
  sha256 "b0e3a9a38ded1b486ed8ffbd024dfc109d1774a97bf5efbd1d1ea3013f4ec9db"

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
