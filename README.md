# Dotfiles

My dotfiles. Simple, clean, and not forked from anyone else's bulky repos. Mostly git aliases and utilities and a nice prompt. Used with pure bash, because it's the default on all unix machines.

![screenshot](http://files.jenius.im/_/DewZ8py.png)

### Installation

- Clone this repo down into whatever folder you store your projects in
- Make sure you have [hub](https://github.com/github/hub) installed, via `brew install hub`
- Make sure you have [lazygit](https://github.com/jesseduffield/lazygit) and [git-delta](https://github.com/dandavison/delta) installed, via `brew install lazygit git-delta`
- If you already have your own config files, you can back them up with `make backup`. This will rename them and put `.bak` at the end
- Run `make install`
- If you are entirely satisfied with all the new settings and want to permanently remove your old settings, you can run `make remove_backup`

### Select modules

Run `make install` to install every module. To select modules, use:

```sh
make install MODULES="music ghostty"
make install MODULES="homebrew shell prompt music ghostty"
make list-modules
```

The first command installs the music utilities and Ghostty config.
The second also installs Homebrew setup, general shell utilities, and the prompt.
The prompt works without Git. The installer does not install packages or check
command dependencies.

A shell module also installs the shared Bash and zsh startup files. The installer
backs up existing files with a `.bak` suffix before replacing them. It stops if
a required backup already exists. Links that already point to this repo stay
in place.

Each shell installation replaces the selection of active shell modules.
Old module links stay in place, but inactive modules are not loaded.
An installation with only app modules, such as `ghostty`, keeps the current shell
selection. Run `make install` without `MODULES` to enable all modules again.

Use the same selection when you update:

```sh
make install MODULES="music ghostty"
```

The backup commands also accept `MODULES`:

```sh
make backup MODULES="music ghostty"
make remove_backup MODULES="music ghostty"
```

`remove_backup` permanently removes the selected backups.

### Profile modules

`.profile` loads the dotfiles listed in `~/.profile-modules`.
The installer writes this list in load order. It also writes
`~/.profile-login` for modules needed by non-interactive zsh login shells.
Node loads last, as before.

| Module | Dotfile | Contents |
| --- | --- | --- |
| homebrew | `.homebrew` | Homebrew environment |
| git | `.git-aliases` | Git aliases, completion, worktree utility |
| prompt | `.prompt` | Bash and zsh prompts, with a fallback without Git |
| shell | `.shell` | General aliases, directory utilities, history |
| iterm | `.iterm` | iTerm shell integration |
| postgres | `.postgres` | PostgreSQL environment |
| go | `.go` | Go environment |
| tools | `.tools` | Command correction, 1Password helper, local executable path |
| music | `.music` | `flac2mp3` and `starsync` |
| node | `.node-env` | Node and nvm environment |

The other modules are `vim`, `tmux`, `ghostty`, `lazygit`, and `codex`.

### Add a module

Create the dotfile and a module file. For example, add `.example` and
`install/modules/85-example` with this content:

```text
profile .example
```

The installer discovers the new module automatically. Run
`make install MODULES="example"` to select it. No installer or loader changes
are needed. The numeric prefix sets load order. Keep Node last.

Module files support these entries:

| Entry | Effect |
| --- | --- |
| `profile .example` | Link the dotfile and load it from `.profile` |
| `login .example` | Also load it in non-interactive zsh login shells |
| `link .example` | Link a file or directory without loading it |
| `link source\|destination` | Link a repo path to a different path under the home directory |
| `retire destination` | Move an old config to a `.bak` file |

Paths are relative to the repo or home directory. Use literal paths, without
shell quotes or variables. Lines that start with `#` are comments.

### Host Mac installation

From a copy of this repo on the host Mac, run:

```sh
brew install ffmpeg
brew install --cask ghostty font-fira-code
make install MODULES="homebrew shell prompt music ghostty"
```

Homebrew must already be installed. Open a new terminal after installation.
Keep the repo at the same path so the links stay valid.

```sh
# Convert all FLAC files beside the given file to 320 kbps MP3 files.
flac2mp3 "$HOME/Music/Album/Track.flac"

# Copy the files listed in ~/Desktop/sync.txt from stardust.
starsync

# Use a different list of files.
starsync "$HOME/Desktop/other-sync.txt"
```

`starsync` needs `rsync`, SSH access to `stardust`, and a list of paths relative
to `stardust:files`. Set up the SSH connection on the host Mac separately.
The destination is `~/Music/Music/Media.localized/Music`.
Ghostty uses Fira Code. Its global Ctrl-Z shortcut needs macOS Accessibility
permission.

### Codex preferences

`make install` links `.codex/config.toml` to `~/.codex/config.toml`.
To install only Codex preferences, run `make install-codex`.

```toml
[tui]
alternate_screen = "never"
```

This setting preserves terminal scrollback. See the [Codex configuration guide](https://learn.chatgpt.com/docs/config-file/config-advanced#tui-options).
The installer moves an existing config to `~/.codex/config.toml.bak` before it
creates the link. It stops if that backup already exists. Other files in
`~/.codex`, such as credentials and sessions, stay in place.
Copy any settings you want to keep from the backup into `.codex/config.toml`.
Do not add credentials to this file. Restart Codex to apply the setting.

### Updating

- Go back into this project
- Run `git pull`
- Run `make install` (this creates new symlinks; it is safe to run again)
- Run `reload`
- You're up to date

### Troubleshooting

If you get any errors, that's because some of the files it's trying to install are already present. I don't want to overwrite your existing config, so make sure you have backed up and saved what you've got there, then remove or rename the file and try installing again.

### Getting Used To It

There are a lot of shortcuts and aliases here. Once you get used to them, it will boost your productivity massively. Look over the aliases here, test em out, understand what they are doing and try using them. If you are not about it, just fork the repo and make your changes.

Make sure to also consult the docs for [hub](https://github.com/github/hub) as it adds a number of additional very useful shortcuts for git.
