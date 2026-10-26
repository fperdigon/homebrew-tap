#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cask_file="$repo_root/Casks/macpocketknife.rb"
dry_run=0

if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=1
elif [[ $# -gt 0 ]]; then
  printf 'Usage: %s [--dry-run]\n' "$0" >&2
  exit 2
fi

command -v gh >/dev/null 2>&1 || { echo "gh is required" >&2; exit 1; }
command -v shasum >/dev/null 2>&1 || { echo "shasum is required" >&2; exit 1; }
command -v curl >/dev/null 2>&1 || { echo "curl is required" >&2; exit 1; }

release_json="$(gh api repos/fperdigon/macpocketknife/releases/latest)"
# Parse JSON locally with Ruby, which is available on both supported runner platforms.
tag="$(printf '%s' "$release_json" | ruby -rjson -e 'puts JSON.parse(STDIN.read).fetch("tag_name")')"
if [[ ! "$tag" =~ ^v([0-9]+\.[0-9]+\.[0-9]+([.-][0-9A-Za-z.-]+)?)$ ]]; then
  echo "Unexpected stable release tag: $tag" >&2
  exit 1
fi
version="${BASH_REMATCH[1]}"
asset_name="MacPocketKnife-${version}.dmg"
asset_url="$(printf '%s' "$release_json" | ruby -rjson -e 'j=JSON.parse(STDIN.read); a=j.fetch("assets").find { |x| x["name"] == ARGV[0] }; abort("Release asset not found: #{ARGV[0]}") unless a; puts a.fetch("browser_download_url")' "$asset_name")"
api_digest="$(printf '%s' "$release_json" | ruby -rjson -e 'j=JSON.parse(STDIN.read); a=j.fetch("assets").find { |x| x["name"] == ARGV[0] }; puts(a["digest"] || "")' "$asset_name")"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
curl --fail --location --silent --show-error "$asset_url" --output "$tmpdir/$asset_name"
sha="$(shasum -a 256 "$tmpdir/$asset_name" | awk '{print $1}')"
if [[ -n "$api_digest" ]]; then
  expected="${api_digest#sha256:}"
  if [[ "$sha" != "$expected" ]]; then
    echo "SHA-256 mismatch for $asset_name: calculated $sha, API reports $api_digest" >&2
    exit 1
  fi
fi

current_version="$(sed -n 's/^  version "\([^"]*\)"$/\1/p' "$cask_file")"
current_sha="$(sed -n 's/^  sha256 "\([^"]*\)"$/\1/p' "$cask_file")"
if [[ "$current_version" == "$version" && "$current_sha" == "$sha" ]]; then
  echo "macpocketknife is already current at $version (sha256 $sha)"
  exit 0
fi
if [[ "$dry_run" -eq 1 ]]; then
  printf 'Dry run: would update macpocketknife version %s -> %s and sha256 %s -> %s\n' "$current_version" "$version" "$current_sha" "$sha"
  exit 0
fi

awk -v version="$version" -v sha="$sha" '
  /^  version "[^"]*"$/ { print "  version \"" version "\""; next }
  /^  sha256 "[^"]*"$/ { print "  sha256 \"" sha "\""; next }
  { print }
' "$cask_file" > "$tmpdir/macpocketknife.rb"
cp "$tmpdir/macpocketknife.rb" "$cask_file"
printf 'Updated macpocketknife: version %s -> %s; sha256 %s -> %s\n' "$current_version" "$version" "$current_sha" "$sha"
