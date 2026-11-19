cask "macpocketknife" do
  version "0.3.0"
  sha256 "236f39ab9813ac654e5cc7f5b04c6a70798b1b9a1742c844e4d44028fe7ec62c"

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
