# Project notes

- Personal project under the `fperdigon` account; this tap distributes several apps through casks.
- Keep all repository content in English.
- Cross-promotion is not approved for this repository.
- MacPocketKnife is updated by the daily workflow in this tap; RMount casks are pushed by RMount's release workflow.
- Legacy `postflight` with `system_command` is intentional for compatibility with older Homebrew; `postflight_steps` requires the newest Homebrew.
- Do not add or use secrets; automation uses the default `GITHUB_TOKEN`.
