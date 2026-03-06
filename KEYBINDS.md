# HYPRLAND KEYBINDS
**Mod Key:** `<Super>` (Windows Key)

### General & Applications
| Key | Description |
| :--- | :--- |
| `<Super> + Enter` | Open **Terminal** (Wezterm) |
| `<Super> + b` | Open **Browser** (Zen) |
| `<Super> + <Alt> + Space` | Open **Rofi** (App Launcher) |
| `<Super> + q` | **Kill** Active Window |
| `<Super> + v` | Toggle **Floating** Window status |
| `<Super> + <Alt> + l` | **Lock** Screen (Hyprlock) |


### Navigation & Focus
| Key | Description |
| :--- | :--- |
| `<Super> + h` | Move Focus **Left** |
| `<Super> + j` | Move Focus **Down** |
| `<Super> + k` | Move Focus **Up** * (See note below) |
| `<Super> + l` | Move Focus **Right** |
| `<Super> + s` | Toggle **Special** Workspace (Magic) |
| `<Super> + Left Click` | **Move** Window (Drag) |
| `<Super> + Right Click` | **Resize** Window (Drag) |


### Workspaces
| Key | Description |
| :--- | :--- |
| `<Super> + [0-9]` | **Switch** to Workspace 1-10 |
| `<Super> + Shift + [0-9]` | **Move** Window to Workspace 1-10 |
| `<Super> + Shift + s` | **Move** Window to **Special** Workspace |
| `<Super> + Scroll` | Cycle through **Workspaces** |


### Scripts & Utilities
| Key | Description |
| :--- | :--- |
| `<Super> + w` | Switch **Wallpaper** |
| `<Super> + y` | View **Keybinds** List (Glow)* |
| `<Super> + F1` | Screenshot (**Copy** to Clipboard) |
| `<Super> + <Alt> + F1` | Screenshot (**Save** to file) |
| `<Super> + F11` | Enter **Fullscreen** Mode |
| `<Super> + F12` | Exit **Fullscreen** Mode |


### Media & Hardware Controls (NOT WORKING YET)
| Key | Description |
| :--- | :--- |
| `Vol Up` | Volume **Up** (5%) |
| `Vol Down` | Volume **Down** (5%) |
| `Mute` | Toggle **Mute** (Output) |
| `Mic Mute` | Toggle **Mute** (Input) |
| `Bright Up` | Screen Brightness **Up** |
| `Bright Down` | Screen Brightness **Down** |
| `Media Next` | **Next** Track |
| `Media Prev` | **Previous** Track |
| `Media Play` | **Play / Pause** |

---

# NEOVIM KEYBINDS
**Leader Key:** `<Space>`  

### General & Editing
| Key | Mode | Description |
| :--- | :--- | :--- |
| `;` | **N** | Enter Command Mode (Mapped to `:`) |
| `<Space>y` | **N/V** | **Copy** to System Clipboard (`"+y`) |
| `<Space>p` | **N/V** | **Paste** from System Clipboard (`"+p`) |
| `<Alt>p` | **V** | **Paste** over selection without overwriting clipboard |
| `J` | **N** | Join line below to current line (Cursor stays static) |
| `J` | **V** | Move selected lines **Down** |
| `K` | **V** | Move selected lines **Up** |
| `<` | **V** | Indent **Left** (Keeps selection) |
| `>` | **V** | Indent **Right** (Keeps selection) |
| `<Space>s` | **N** | **Search & Replace** the word under cursor globally |
| `<Space>tq` | **N** | Add **TODO** comments to Quickfix list |


### Navigation & Scrolling
| Key | Mode | Description |
| :--- | :--- | :--- |
| `Ctrl + u` | **N** | Scroll **Up** ½ Page (Center Cursor) |
| `Ctrl + d` | **N** | Scroll **Down** ½ Page (Center Cursor) |
| `n` | **N** | Next Search Result (Center Cursor) |
| `N` | **N** | Previous Search Result (Center Cursor) |
| `s` | **N** | **Flash Jump** (Quick navigation) |
| `Backspace` | **N** | Open **Oil** (File Explorer / Parent Dir) |


### Window & Buffer Management
| Key | Mode | Description |
| :--- | :--- | :--- |
| `Ctrl + Up` | **N** | Decrease Window Height |
| `Ctrl + Down` | **N** | Increase Window Height |
| `Ctrl + Left` | **N** | Decrease Window Width |
| `Ctrl + Right` | **N** | Increase Window Width |
| `Shift + h` | **N** | Go to **Previous Buffer** |
| `Shift + l` | **N** | Go to **Next Buffer** |
| `Alt + k` | **N** | **Next** Quickfix Item |
| `Alt + j` | **N** | **Previous** Quickfix Item |


### Search (Fzf-Lua)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<Space>pf` | **N** | Find **Project Files** |
| `Ctrl + p` | **N** | Find **Git Files** |
| `<Space>ps` | **N** | **Grep** (Search text) in Project |
| `<Space>sw` | **N** | Search **Word under Cursor** in Project |


### LSP & Coding
| Key | Mode | Description |
| :--- | :--- | :--- |
| `gd` | **N** | Go to **Definition** |
| `K` | **N** | **Hover** Documentation |
| `<Space>ca` | **N** | Code **Actions** |
| `<Space>gf` | **N** | **Format** File |
| `<Space>sd` | **N** | Search **Definitions** (Fzf) |
| `<Space>sr` | **N** | Search **References** (Fzf) |
| `<Space>si` | **N** | Search **Implementations** (Fzf) |
| `<Space>di` | **N** | Search **Diagnostics** (Fzf) |
| `gcc` | **N** | Toggle **Comment** (Line) |
| `gbc` | **N** | Toggle **Comment** (Block) |
| `gc` | **V** | Toggle **Comment** (Selection) |


### Autocomplete & AI
| Key | Mode | Description |
| :--- | :--- | :--- |
| `Ctrl + n` | **I** | Select **Next** Item |
| `Ctrl + p` | **I** | Select **Previous** Item |
| `Ctrl + y` | **I** | **Confirm** Completion |
| `Ctrl + e` | **I** | **Abort** Completion / Clear AI Suggestion |
| `Tab` | **I** | Jump **Next** Snippet Node |
| `Shift + Tab` | **I** | Jump **Prev** Snippet Node |
| `Ctrl + a` | **I** | **Accept** Supermaven AI Suggestion |


### Git Integration
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<Space>lg` | **N** | Open **LazyGit** |
| `<Space>gs` | **N** | Git **Status** (Fzf) |
| `<Space>gc` | **N** | Git **Commits** (Fzf) |
| `<Space>gb` | **N** | Git **Branches** (Fzf) |


### Harpoon (File Marks)
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<Space>ha` | **N** | **Add** file to Harpoon |
| `<Space>he` | **N** | Open Harpoon **Menu** |
| `<Space>hx` | **N** | **Clear** Harpoon List |
| `<Space>hh` | **N** | Go to File **1** |
| `<Space>hj` | **N** | Go to File **2** |
| `<Space>hk` | **N** | Go to File **3** |
| `<Space>hl` | **N** | Go to File **4** |


### Others 
| Key | Mode | Description |
| :--- | :--- | :--- |
| `<Space>u` | **N** | Toggle **UndoTree** Visualizer |

---

# WEZTERM KEYBINDS
**Leader:** `Ctrl + Space`

### General & Navigation
| Key | Description |
| :--- | :--- |
| `Ctrl + h` | Go to Pane **Left** |
| `Ctrl + j` | Go to Pane **Down** |
| `Ctrl + k` | Go to Pane **Up** |
| `Ctrl + l` | Go to Pane **Right** |
| `<Leader> + [` | Enter **Copy Mode** |
| `Ctrl + +` | Increase Font Size |
| `Ctrl + -` | Decrease Font Size |
| `Ctrl + 0` | Reset Font Size |

### Windows, Tabs & Workspaces
| Key | Description |
| :--- | :--- |
| `<Leader> + \|` | Split **Horizontal** |
| `<Leader> + _` | Split **Vertical** |
| `<Leader> + x` | **Close** Current Pane |
| `<Leader> + z` | Toggle **Zoom** Pane |
| `<Leader> + r` | Enter **Resize Mode** |
| `<Leader> + c` | Create **New Tab** |
| `<Leader> + n` | **Next** Tab |
| `<Leader> + p` | **Previous** Tab |
| `<Leader> + $` | **Rename** Workspace |

---

# TMUX KEYBINDS
**Prefix:** `Ctrl + Space`

### Panes & Windows
| Key | Description |
| :--- | :--- |
| `Ctrl + h` | Go to Pane **Left** (No Prefix) |
| `Ctrl + j` | Go to Pane **Down** (No Prefix) |
| `Ctrl + k` | Go to Pane **Up** (No Prefix) |
| `Ctrl + l` | Go to Pane **Right** (No Prefix) |
| `<Prefix> + H` | **Resize** Pane Left (5 cells) |
| `<Prefix> + J` | **Resize** Pane Down (5 cells) |
| `<Prefix> + K` | **Resize** Pane Up (5 cells) |
| `<Prefix> + L` | **Resize** Pane Right (5 cells) |
| `<Prefix> + \|` | Split Window **Horizontally** |
| `<Prefix> + _` | Split Window **Vertically** |

---

# RMPC KEYBINDS
### Playback & Volume
| Key | Description |
| :--- | :--- |
| `p` | Toggle **Play / Pause** |
| `s` | **Stop** Playback |
| `>` | **Next** Track |
| `<` | **Previous** Track |
| `f` | Seek **Forward** |
| `b` | Seek **Backward** |
| `=` | Volume **Up** |
| `-` | Volume **Down** |
| `z` | Toggle **Repeat** |
| `x` | Toggle **Random** |


### General & Navigation
| Key | Description |
| :--- | :--- |
| `k` / `j` | Scroll **Up / Down** |
| `h` / `l` | Scroll **Left / Right** |
| `gg` | Jump to **Top** |
| `G` | Jump to **Bottom** |
| `Tab` | **Next** Tab |
| `Shift + Tab` | **Previous** Tab |
| `1` - `4` | **Switch** to Tab (Dashboard, Library, etc.) |
| `:` | Enter **Command Mode** |
| `q` | **Quit** RMPC |


### Queue & Library Actions
| Key | Description |
| :--- | :--- |
| `Enter` | **Play** Selection / Confirm |
| `/` | **Search** |
| `a` | **Add** to Queue |
| `d` | **Delete** Selection |
| `D` | **Clear** Queue / Delete All |
| `S` | **Save** Queue (as Playlist) |
| `x` | **Shuffle** Queue |
