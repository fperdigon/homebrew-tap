# fperdigon Homebrew Tap

This tap distributes apps from the `fperdigon` account.

## Casks

| App | Install |
| --- | --- |
| [MacPocketKnife](https://github.com/fperdigon/macpocketknife) | `brew install --cask fperdigon/tap/macpocketknife` |
| [RMount](https://github.com/fperdigon/rmount) | `brew install --cask fperdigon/tap/rmount` |
| RMount Lite | `brew install --cask fperdigon/tap/rmount-lite` |

## Migrating from `fperdigon/rmount`

If you installed RMount from the old tap `fperdigon/rmount`, Homebrew migrates it automatically on `brew update`. Otherwise, run:

```bash
brew untap fperdigon/rmount && brew install --cask fperdigon/tap/rmount
```

## Updates

MacPocketKnife is updated by the daily workflow in this tap. The RMount casks are pushed by RMount's release workflow.

## Security

All three apps are ad-hoc signed and are not notarized. Their casks remove the quarantine flag after installation so Gatekeeper does not block them. Homebrew verifies each download against the SHA-256 checksum in its cask.
