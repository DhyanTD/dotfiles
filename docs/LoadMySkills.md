# LoadMySkills

Copies the canonical `skills/AGENTS.md` from your dotfiles into the current working directory.

## What it does

- **Source:** `skills/AGENTS.md` resolved relative to the executable (via `readlink -f "$0"`), with a fallback to `~/Documents/Github/dhyan/dotfiles/skills/AGENTS.md`.
- **Destination:** `$PWD/AGENTS.md` (the directory you run the command from).
- **Backup:** If `AGENTS.md` already exists in the destination, the existing file is renamed to `AGENTS.md.bak.<timestamp>` (e.g., `AGENTS.md.bak.20260902-010500`) before the new copy is written. Same-second collisions get an extra `.1`, `.2` suffix. If the destination is a directory, the command aborts.
- **No arguments:** The command takes no arguments — `LoadMySkills foo` prints usage and exits 1.

## Installation / Stow

The executable lives at `executables/.local/bin/LoadMySkills`. Stow exposes it as `~/.local/bin/LoadMySkills`.

```bash
cd ~/Documents/Github/dhyan/dotfiles
chmod +x executables/.local/bin/LoadMySkills
stow -R executables
which LoadMySkills        # ~/.local/bin/LoadMySkills
readlink -f ~/.local/bin/LoadMySkills
```

Requires `~/.local/bin` on your `$PATH`.

## Usage

```bash
cd /path/to/your/project
LoadMySkills
ls -l AGENTS.md AGENTS.md.bak.* 2>/dev/null
```

Re-running creates another timestamped backup of the previous `AGENTS.md`:

```bash
LoadMySkills              # AGENTS.md -> AGENTS.md.bak.<ts1>
# edit AGENTS.md locally, then refresh from dotfiles:
LoadMySkills              # AGENTS.md -> AGENTS.md.bak.<ts2>, fresh copy in place
```

## Exit codes

- `0` — success.
- `1` — source missing, destination is a directory, no write permission, or unexpected arguments.

## How to upgrade

### Changing the source file

Edit `skills/AGENTS.md` in the dotfiles repo. No change to `LoadMySkills` is needed — next invocation copies the new version.

```bash
$EDITOR skills/AGENTS.md
git diff skills/AGENTS.md
```

To refresh a project that already has a copy:

```bash
cd /path/to/project
LoadMySkills
diff AGENTS.md ~/Documents/Github/dhyan/dotfiles/skills/AGENTS.md
```

### Changing the executable

1. Edit `executables/.local/bin/LoadMySkills`.
2. Re-stow and test:

```bash
chmod +x executables/.local/bin/LoadMySkills
stow -R executables
LoadMySkills 2>&1
shellcheck executables/.local/bin/LoadMySkills  # if installed
```

3. Verify edge cases: fresh copy, backup-on-existing, same-second collision, missing source, directory collision (see Verification below).

### Changing the backup format

Current format is `AGENTS.md.bak.YYYYMMDD-HHMMSS` via `date +%Y%m%d-%H%M%S`. To change it, edit the `TS="$(date ...)"` and `BAK=...` lines. If you switch to a non-timestamped scheme, note that `*.bak` is already in `.gitignore` while `*.bak.*` is not — add `*.bak.*` to `.gitignore` if you want timestamped backups ignored.

### Moving the dotfiles repo

No change needed — `readlink -f "$0"` resolves the stow symlink back to the repo. The `$HOME/Documents/Github/dhyan/dotfiles` fallback only matters if the symlink can't be resolved.

## Verification

```bash
# fresh copy
tmpdir="$(mktemp -d)"; cd "$tmpdir"
LoadMySkills
diff AGENTS.md ~/Documents/Github/dhyan/dotfiles/skills/AGENTS.md

# backup on existing
echo "old" > AGENTS.md
LoadMySkills
ls AGENTS.md.bak.* && cat AGENTS.md.bak.*

# same-second collision (two runs in same second)
LoadMySkills; LoadMySkills
ls -1 AGENTS.md.bak.*

# arg rejection
LoadMySkills foo; echo $?

# cleanup
cd -; rm -rf "$tmpdir"
```

## Related

- Plan: `~/.commandcode/plans/load-my-skills-executable.md`
- Source: `skills/AGENTS.md`
- Executable: `executables/.local/bin/LoadMySkills`
