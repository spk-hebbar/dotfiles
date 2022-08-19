Tmux Configuration
=====================
My Tmux configuration which I am confortable with. [tmux](https://tmux.github.io/). This is subject to revisions, I keep changing this as per my needs.

![intro]

Table of contents
-----------------

1. [Features](#features)
1. [Installation](#installation)
1. [General settings](#general-settings)
1. [Key bindings](#key-bindings)
1. [Status line](#status-line)
1. [Nested tmux sessions](#nested-tmux-sessions)
1. [Clipboard integration](#clipboard-integration)
1. [Themes and customization](#themes-and-customization)
1. [iTerm2 and tmux integration](#iterm2-and-tmux-integration)

Features
---------

- "C-a" prefix instead of "C-b" (screen like)
- support for nested tmux sessions
- local vs remote specific session configuration
- A good status line
- prompt to rename window right after it's created
- newly created windows and panes retain current working directory
- highlight focused pane
- configurable visual theme/colors, with some elements borrowed from [Powerline](https://github.com/powerline/powerline)
- integration with 3rd party plugins: [tmux-sidebar](https://github.com/tmux-plugins/tmux-sidebar), [tmux-copycat](https://github.com/tmux-plugins/tmux-copycat), [tmux-open](https://github.com/tmux-plugins/tmux-open), [tmux-plugin-sysstat](https://github.com/samoshkin/tmux-plugin-sysstat)

**Status line widgets**:

- CPU, memory usage, system load average metrics
- username and hostname, current date time
- battery information in status line
- visual indicator when you press `prefix`
- visual indicator when pane is zoomed
- online/offline visual indicator
- toggle visibility of status line

Installation
-------------
Prerequisites:
- tmux >= "v2.4"
- Linux, tested on RHEL 8.


To install tmux-config:
```
```

`install.sh` script does following:
- copies files to `~/.tmux` directory.
- symlink tmux config file at `~/.tmux.conf`, existing `~/.tmux.conf` will be backed up.
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) will be installed at default location `~/.tmux/plugins/tpm`, unless already present.
- required tmux plugins will be installed.

Create new tmux session:

```
$ tmux new
```


General settings
----------------
Windows and pane indexing starts from `1` rather than `0`.
Scrollback history limit is set to `20000`.
Automatic window renameing is turned off.
Aggresive resizing is on. Message line display timeout is `1.5s`.
Mouse support in `on`.

```
# parent terminal
$ echo $TERM
xterm-256color

# jump into a tmux session
$ tmux new
$ echo $TERM
screen-256color
```

Key bindings
-----------
So `~/.tmux.conf` overrides default key bindings for many action, to make them more reasonable, easy to recall and comfortable to type.

<table>
    <tr>
        <td nowrap><b>tmux key</b></td>
        <td><b>Description</b></td>
        <td><b>iTerm2 key</b></td>
    </tr>
    <tr>
        <td nowrap><code>C-a</code></td>
        <td>Default prefix, used instead of "C-b". Same prefix is used in screen program, and it's easy to type. The only drawback of "C-a" is that underlying shell does not receive the keystroke to move to the beginning of the line.
        </td>
        <td>-</td>
    </tr>
    <tr>
        <td nowrap><code>&lt;prefix&gt; C-e</code></td>
        <td>Open ~/.tmux.conf file in your $EDITOR</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-r</code></td>
        <td>Reload tmux configuration from ~/.tmux.conf file</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; r</code></td>
        <td>Rename current window</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; R</code></td>
        <td>Rename current session</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; _</code></td>
        <td>Split new pane horizontally</td>
        <td>⌘⇧D</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; |</code></td>
        <td>Split new pane vertically</td>
        <td>⌘D</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; &lt;</code></td>
        <td>Select next pane</td>
        <td>⌘[</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; &gt;</code></td>
        <td>Select previous pane</td>
        <td>⌘]</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; ←</code></td>
        <td>Select pane on the left</td>
        <td>⌘⌥←</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; →</code></td>
        <td>Select pane on the right</td>
        <td>⌘⌥→</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; ↑</code></td>
        <td>Select pane on the top</td>
        <td>⌘⌥↑</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; ↓</code></td>
        <td>Select pane on the bottom</td>
        <td>⌘⌥↓</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-←</code></td>
        <td>Resize pane to the left</td>
        <td>^⌘←</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-→</code></td>
        <td>Resize pane to the right</td>
        <td>^⌘→</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-↑</code></td>
        <td>Resize pane to the top</td>
        <td>^⌘↑</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-↓</code></td>
        <td>Resize pane to the bottom</td>
        <td>^⌘↓</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; &gt;</code></td>
        <td>Move to next window</td>
        <td>⌘⇧]</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; &lt;</code></td>
        <td>Move to previous window</td>
        <td>⌘⇧[</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; Tab</code></td>
        <td>Switch to most recently used window</td>
        <td>^Tab</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; L</code></td>
        <td>Link window from another session by entering target session and window reference</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; \</code></td>
        <td>Swap panes back and forth with 1st pane. When in main-horizontal or main-vertical layout, the main panel is always at index 1. This keybinding let you swap secondary pane with main one, and do the opposite.</td>
        <td>⌘\</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-o</code></td>
        <td>Swap current active pane with next one</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; +</code></td>
        <td>Toggle zoom for current pane</td>
        <td>⌘⇧Enter</td>
    </td>
    <tr>
        <td><code>&lt;prefix&gt; x</code></td>
        <td>Kill current pane</td>
        <td>⌘W</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; X</code></td>
        <td>Kill current window</td>
        <td>⌘⌥W</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-x</code></td>
        <td>Kill other windows but current one (with confirmation)</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; Q</code></td>
        <td>Kill current session (with confirmation)</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-u</code></td>
        <td>Merge current session with another. Essentially, this moves all windows from current session to another one</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; d</code></td>
        <td>Detach from session</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; D</code></td>
        <td>Detach other clients except current one from session</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; C-s</code></td>
        <td>Toggle status bar visibility</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; m</code></td>
        <td>Monitor current window for activity</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; M</code></td>
        <td>Monitor current window for silence by entering silence period</td>
        <td>-</td>
    </tr>
    <tr>
        <td><code>&lt;prefix&gt; F12</code></td>
        <td>Switch off all key binding and prefix hanling in current window. See "Nested sessions" paragraph for more info</td>
        <td>-</td>
    </tr>
</table>


Status line
-----------

The left part contains only current session name.

The right part of status line consists of following components:

- CPU, memory usage, system load average metrics. Powered by [tmux-plugin-sysstat](https://github.com/samoshkin/tmux-plugin-sysstat)
- username and hostname (invaluable when you SSH onto remote host)
- current date time
- battery information
- visual indicator when you press prefix key: `[^A]`.
- visual indicator when pane is zoomed: `[Z]`
- online/offline visual indicator (just pings `google.com`)

Hide status bar using `<prefix> C-s` keybinding.


Nested tmux sessions
--------------------
Press F12 to off the first tmux session.

When key bindings are "OFF", special `[OFF]` visual indicator is shown in the status line, and status line changes its style (colored to gray).

###  Local and remote sessions

Remote session is detected by existence of `$SSH_CLIENT` variable. When session is remote, following changes are applied:
- status line is docked to bottom; so it does not stack with status line of local session
- some widgets are removed from status line: battery, date time. The idea is to economy width, so on wider screens you can open two remote tmux sessions in side-by-side panes of single window of local session.

Remote-specific settings can be extended in `~/.tmux/.tmux.remote.conf` file.

Most of the settings are derived from https://github.com/samoshkin/tmux-config. Thanks to Samoshkin.
