# fperdigon Homebrew Tap

This tap distributes [MacPocketKnife](https://github.com/fperdigon/macpocketknife), a personal pocket multi-tool for the Mac menu bar, starting with a battery guard.

## Install

```bash
brew install --cask fperdigon/tap/macpocketknife
```

Or add the tap first:

```bash
brew tap fperdigon/tap
```

```bash
brew install --cask macpocketknife
```

## Upgrade

```bash
brew upgrade --cask macpocketknife
```

The app's own updater also works, but then Homebrew's recorded version goes stale; prefer `brew upgrade` for Homebrew installs and turn off automatic update checks in the app's Settings if you want a single updater.

## Uninstall

```bash
brew uninstall --cask macpocketknife
```

To also remove the app's saved preferences, support files, and cache:

```bash
brew uninstall --cask --zap macpocketknife
```

## Security

MacPocketKnife is ad-hoc signed and is not notarized. After installation, the cask removes the quarantine flag from `MacPocketKnife.app` so Gatekeeper does not block it. Homebrew verifies the download against the SHA-256 checksum in the cask.
