#!/usr/bin/env bash

# App Colors & Icons
HL='<span color="#00C8EC"> Hyprland </span>'
MED='<span color="#FA5252">󰎈 Media    </span>'
HW='<span color="#E5C07B">󰌌 Hardware </span>'
NV='<span color="#57A143"> Neovim   </span>'
WZ='<span color="#514CE5"> Wezterm  </span>'
TX='<span color="#1AAB1E"> Tmux     </span>'
RP='<span color="#AD80F5"> RMPC     </span>'

# Tab separator
T=$'\t'

KEYBINDS=$(cat << EOF
$HL$T Alt + Space                 $T App Launcher (Rofi)
$HL$T Super + Return              $T Terminal (Wezterm)
$HL$T Super + B                   $T Browser (Zen)
$HL$T Super + Q                   $T Quit Application
$HL$T Super + V                   $T Toggle Floating Window
$HL$T Super + Alt + L             $T Lock Screen
$HL$T Super + H                   $T Move Focus Left
$HL$T Super + J                   $T Move Focus Down
$HL$T Super + K                   $T Move Focus Up
$HL$T Super + L                   $T Move Focus Right
$HL$T Super + S                   $T Toggle Special Workspace (Magic)
$HL$T Super + Shift + S           $T Move Window to Special Workspace
$HL$T Super + [0-9]               $T Switch to Workspace 1-10
$HL$T Super + Shift + [0-9]       $T Move Window to Workspace 1-10
$HL$T Super + Scroll Down         $T Switch to Next Workspace (e+1)
$HL$T Super + Scroll Up           $T Switch to Previous Workspace (e-1)
$HL$T Super + Left Click          $T Move Window (Drag)
$HL$T Super + Right Click         $T Resize Window (Drag)
$HL$T Super + W                   $T Switch Theme (themeswitcher.sh)
$HL$T Super + Shift + W           $T Open Theme Switcher Menu (rofi_themeswitcher.sh)
$HL$T Super + X                   $T Open Power Menu (rofi_powermenu.sh)
$HL$T Super + N                   $T Toggle Night Light (hyprsunset_toggle.sh)
$HL$T Super + Y                   $T View Keybinds List
$HL$T Super + F1                  $T Screenshot (Copy to Clipboard)
$HL$T Super + Alt + F1            $T Screenshot (Save to File)
$HL$T Super + F2                  $T Color Picker (hyprpicker)
$HL$T Super + F11                 $T Enter Fullscreen Mode
$HL$T Super + F12                 $T Exit Fullscreen Mode

$HW$T XF86MonBrightnessUp         $T Screen Brightness Up (10%)
$HW$T XF86MonBrightnessDown       $T Screen Brightness Down (10%)
$MED$T XF86AudioRaiseVolume       $T Volume Up (5%)
$MED$T XF86AudioLowerVolume       $T Volume Down (5%)
$MED$T XF86AudioMute              $T Toggle Mute (Audio Output)
$MED$T XF86AudioMicMute           $T Toggle Mute (Microphone Input)
$MED$T XF86AudioPlay / Pause      $T Media Play / Pause
$MED$T XF86AudioNext              $T Next Track
$MED$T XF86AudioPrev              $T Previous Track

$NV$T ;                           $T <span color="#888888">[N]</span> Enter Command Mode (Mapped to :)
$NV$T Space + Y                   $T <span color="#888888">[N/V]</span> Copy to System Clipboard ("+y)
$NV$T Space + P                   $T <span color="#888888">[N/V]</span> Paste from System Clipboard ("+p)
$NV$T Alt + P                     $T <span color="#888888">[V]</span> Paste over selection (keep clipboard)
$NV$T J                           $T <span color="#888888">[N]</span> Join line below (cursor static)
$NV$T J                           $T <span color="#888888">[V]</span> Move selected lines Down
$NV$T K                           $T <span color="#888888">[V]</span> Move selected lines Up
$NV$T <                           $T <span color="#888888">[V]</span> Indent Left (keep selection)
$NV$T >                           $T <span color="#888888">[V]</span> Indent Right (keep selection)
$NV$T Space + S                   $T <span color="#888888">[N]</span> Search & Replace word under cursor
$NV$T Alt + K                     $T <span color="#888888">[N]</span> Next Quickfix Item
$NV$T Alt + J                     $T <span color="#888888">[N]</span> Previous Quickfix Item
$NV$T Ctrl + Up                   $T <span color="#888888">[N]</span> Increase Window Height
$NV$T Ctrl + Down                 $T <span color="#888888">[N]</span> Decrease Window Height
$NV$T Ctrl + Left                 $T <span color="#888888">[N]</span> Decrease Window Width
$NV$T Ctrl + Right                $T <span color="#888888">[N]</span> Increase Window Width
$NV$T Shift + H                   $T <span color="#888888">[N]</span> Previous Buffer
$NV$T Shift + L                   $T <span color="#888888">[N]</span> Next Buffer
$NV$T Shift + X                   $T <span color="#888888">[N]</span> Delete Buffer
$NV$T Ctrl + U                    $T <span color="#888888">[N]</span> Scroll Up 1/2 Page (center cursor)
$NV$T Ctrl + D                    $T <span color="#888888">[N]</span> Scroll Down 1/2 Page (center cursor)
$NV$T N                           $T <span color="#888888">[N]</span> Next Search Result (center cursor)
$NV$T Shift + N                   $T <span color="#888888">[N]</span> Previous Search Result (center cursor)
$NV$T Ctrl + N                    $T <span color="#888888">[I]</span> Autocomplete: Next Item
$NV$T Ctrl + P                    $T <span color="#888888">[I]</span> Autocomplete: Previous Item
$NV$T Ctrl + Y                    $T <span color="#888888">[I]</span> Confirm Completion
$NV$T Ctrl + E                    $T <span color="#888888">[I]</span> Abort Completion / Clear Supermaven
$NV$T Tab                         $T <span color="#888888">[I/S/C]</span> Next Completion / Fallback
$NV$T Shift + Tab                 $T <span color="#888888">[I/S/C]</span> Previous Completion / Fallback
$NV$T Ctrl + A                    $T <span color="#888888">[I]</span> Accept Supermaven AI Suggestion
$NV$T Space + PF                  $T <span color="#888888">[N]</span> Find Files (Fzf-Lua)
$NV$T Space + PB                  $T <span color="#888888">[N]</span> Switch Open Buffers (Fzf-Lua)
$NV$T Space + PR                  $T <span color="#888888">[N]</span> Resume Last Fzf Search (Fzf-Lua)
$NV$T Space + SG                  $T <span color="#888888">[N]</span> Live Grep Project (Fzf-Lua)
$NV$T Space + SW                  $T <span color="#888888">[N/V]</span> Search Word / Selection (Fzf-Lua)
$NV$T Space + SB                  $T <span color="#888888">[N]</span> Live Grep Current Buffer (Fzf-Lua)
$NV$T Space + LD                  $T <span color="#888888">[N]</span> LSP Definitions (Fzf-Lua)
$NV$T Space + LR                  $T <span color="#888888">[N]</span> LSP References (Fzf-Lua)
$NV$T Space + LI                  $T <span color="#888888">[N]</span> LSP Implementations (Fzf-Lua)
$NV$T Space + LS                  $T <span color="#888888">[N]</span> Document Symbols (Fzf-Lua)
$NV$T Space + Shift + S           $T <span color="#888888">[N]</span> Workspace Symbols (Fzf-Lua)
$NV$T Space + XX                  $T <span color="#888888">[N]</span> Workspace Diagnostics (Fzf-Lua)
$NV$T Space + XB                  $T <span color="#888888">[N]</span> Buffer Diagnostics (Fzf-Lua)
$NV$T Space + GS                  $T <span color="#888888">[N]</span> Git Status (Fzf-Lua)
$NV$T Space + GC                  $T <span color="#888888">[N]</span> Git Commits (Fzf-Lua)
$NV$T Space + GB                  $T <span color="#888888">[N]</span> Git Branches (Fzf-Lua)
$NV$T Space + GF                  $T <span color="#888888">[N]</span> Git Files (Fzf-Lua)
$NV$T Space + LG                  $T <span color="#888888">[N]</span> Open LazyGit
$NV$T K                           $T <span color="#888888">[N]</span> Hover Documentation (LSP)
$NV$T GD                          $T <span color="#888888">[N]</span> Go to Definition (LSP)
$NV$T Space + CA                  $T <span color="#888888">[N]</span> Code Actions (LSP)
$NV$T Space + CF                  $T <span color="#888888">[N]</span> Format File (LSP)
$NV$T Space + TQ                  $T <span color="#888888">[N]</span> Add TODO Comments to Quickfix List
$NV$T Space + U                   $T <span color="#888888">[N]</span> Toggle UndoTree Visualizer
$NV$T S                           $T <span color="#888888">[N/X/O]</span> Flash Jump (quick navigation)
$NV$T Shift + S                   $T <span color="#888888">[N/X/O]</span> Flash Treesitter
$NV$T R                           $T <span color="#888888">[O]</span> Flash Remote
$NV$T Shift + R                   $T <span color="#888888">[O/X]</span> Flash Treesitter Search
$NV$T Ctrl + S                    $T <span color="#888888">[C]</span> Toggle Flash Search
$NV$T Alt + A                     $T <span color="#888888">[N]</span> Harpoon: Add Current File
$NV$T Alt + E                     $T <span color="#888888">[N]</span> Harpoon: Toggle Quick Menu
$NV$T Alt + X                     $T <span color="#888888">[N]</span> Harpoon: Clear All Files
$NV$T Alt + H                     $T <span color="#888888">[N]</span> Harpoon: Select File 1
$NV$T Alt + J                     $T <span color="#888888">[N]</span> Harpoon: Select File 2
$NV$T Alt + K                     $T <span color="#888888">[N]</span> Harpoon: Select File 3
$NV$T Alt + L                     $T <span color="#888888">[N]</span> Harpoon: Select File 4
$NV$T GCC                         $T <span color="#888888">[N]</span> Toggle Comment (Line)
$NV$T GBC                         $T <span color="#888888">[N]</span> Toggle Comment (Block)
$NV$T GC                          $T <span color="#888888">[V/O]</span> Toggle Comment (Selection / Motion)
$NV$T GB                          $T <span color="#888888">[O]</span> Toggle Block Comment (Motion)
$NV$T GCA                         $T <span color="#888888">[N]</span> Comment Insert Above
$NV$T GCB                         $T <span color="#888888">[N]</span> Comment Insert Below
$NV$T GCE                         $T <span color="#888888">[N]</span> Comment Insert End of Line
$NV$T Backspace                   $T <span color="#888888">[N]</span> Open Oil (Parent Directory)

$WZ$T Ctrl + +                    $T Increase Font Size
$WZ$T Ctrl + -                    $T Decrease Font Size
$WZ$T Ctrl + 0                    $T Reset Font Size
$WZ$T Ctrl + H/J/K/L              $T <span color="#666666">[Disabled]</span> Pane Navigation
$WZ$T Ctrl + Space + | / _        $T <span color="#666666">[Disabled]</span> Split Horizontal / Vertical
$WZ$T Ctrl + Space + X            $T <span color="#666666">[Disabled]</span> Close Current Pane
$WZ$T Ctrl + Space + Z            $T <span color="#666666">[Disabled]</span> Toggle Zoom Pane
$WZ$T Ctrl + Space + C            $T <span color="#666666">[Disabled]</span> Create New Tab
$WZ$T Ctrl + Space + N / P        $T <span color="#666666">[Disabled]</span> Next / Previous Tab
$WZ$T Ctrl + Space + [            $T <span color="#666666">[Disabled]</span> Enter Copy Mode
$WZ$T Ctrl + Space + R            $T <span color="#666666">[Disabled]</span> Enter Resize Mode
$WZ$T Ctrl + Space + $            $T <span color="#666666">[Disabled]</span> Rename Workspace

$TX$T Ctrl + Space                $T Prefix Key
$TX$T Ctrl + H / J / K / L        $T Go to Pane Left / Down / Up / Right (No Prefix)
$TX$T Ctrl + \\                   $T Go to Previous Pane (No Prefix)
$TX$T Ctrl + Space + | / \\       $T Split Window Horizontally (Current Path)
$TX$T Ctrl + Space + - / _        $T Split Window Vertically (Current Path)
$TX$T Ctrl + Space + C            $T Create New Window (Current Path)
$TX$T Ctrl + Space + V            $T Enter Copy Mode
$TX$T Ctrl + Space + Shift + H    $T Resize Pane Left (5 cells)
$TX$T Ctrl + Space + Shift + J    $T Join Pane from Selected Window
$TX$T Ctrl + Space + Shift + K    $T Resize Pane Up (5 cells)
$TX$T Ctrl + Space + Shift + L    $T Resize Pane Right (5 cells)
$TX$T Ctrl + Space + Alt + J      $T Resize Pane Down (5 cells)
$TX$T Ctrl + Space + B            $T Break Current Pane into Background Window
$TX$T Ctrl + Space + Shift + S    $T Toggle Synchronize Panes
$TX$T Ctrl + Space + R            $T Reload tmux Configuration
$TX$T Ctrl + Space + U            $T Open URL Picker (tmux-fzf-url)
$TX$T Ctrl + Space + Ctrl + S     $T Save Session (tmux-resurrect)
$TX$T Ctrl + Space + Ctrl + R     $T Restore Session (tmux-resurrect)
$TX$T V                           $T <span color="#888888">[Copy Mode]</span> Begin Selection
$TX$T Ctrl + V                    $T <span color="#888888">[Copy Mode]</span> Rectangle Toggle
$TX$T Y                           $T <span color="#888888">[Copy Mode]</span> Yank Selection to Clipboard
$TX$T Escape                      $T <span color="#888888">[Copy Mode]</span> Cancel Selection / Exit

$RP$T Q                           $T Quit RMPC
$RP$T :                           $T Enter Command Mode
$RP$T - / =                       $T Volume Down / Up
$RP$T Tab / Shift + Tab           $T Next / Previous Tab
$RP$T 1 - 4                       $T Switch View (1:Dashboard, 2:Lib, 3:Playlists, 4:Search)
$RP$T S                           $T Stop Playback
$RP$T P                           $T Toggle Play / Pause
$RP$T > / <                       $T Next / Previous Track
$RP$T F / B                       $T Seek Forward / Backward
$RP$T Z / X                       $T Toggle Repeat / Random
$RP$T H / J / K / L               $T <span color="#888888">[Nav]</span> Move Left / Down / Up / Right
$RP$T GG / Shift + G              $T <span color="#888888">[Nav]</span> Jump to Top / Bottom
$RP$T Enter                       $T <span color="#888888">[Nav/Queue/Playlists]</span> Confirm / Play Item
$RP$T A                           $T <span color="#888888">[Nav/Playlists]</span> Add to Queue / Add to Playlist
$RP$T D                           $T <span color="#888888">[Queue/Playlists]</span> Delete Selected Item / Playlist
$RP$T Shift + D                   $T <span color="#888888">[Nav/Queue]</span> Delete Selection / Clear Queue
$RP$T /                           $T <span color="#888888">[Nav]</span> Enter Search Mode
$RP$T Shift + S                   $T <span color="#888888">[Queue]</span> Save Queue (as Playlist)
$RP$T Shift + X                   $T <span color="#888888">[Queue]</span> Shuffle Queue
EOF
)

# Display via rofi with pango markup and fuzzy matching enabled
echo "$KEYBINDS" | rofi -dmenu -i -markup-rows -matching fuzzy -p "󰌌 Keybinds" -theme "$HOME/.config/rofi/keybinds.rasi"
