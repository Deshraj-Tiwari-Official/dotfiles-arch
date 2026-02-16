## Install Arch
Get the ISO from the internet and flash your USB drive. Turn off secure boot from BIOS. Boot from USB and make sure you have internet connection (plug your phone to your laptop and enable wired connection). Use 'archinstall' script (partioning theek se kariyo. don't remove your windows from your computer as you might need it maybe (always think of the worst day possible)) to install hyprland and use ly as your display manager, grub as bootloader. Also enable things like networkmanager, bluetooth etc.

---

## Pacman config edits

```bash
sudo nano /etc/pacman.conf
```

Uncomment or add:

```
MaxParallelDownloads = 7
ILoveCandy
```

---

## Update Your System

```bash
sudo pacman -Syu
```

---

## Set Up Wi-Fi / Network

1. **Identify your network hardware:**

```bash
lspci | grep -i network
```

2. **Install the driver:**

```bash
sudo pacman -S broadcom-wl-dkms
sudo modprobe wl
```

3. **Connect to Wi-Fi using nmtui command in terminal**


---

## Clone This Repo

```bash
git clone https://github.com/Deshraj-Tiwari-Official/dotfiles-arch ~/dotfiles
```

---

## Run the Setup Script, type password when prompted, and read the post setup script.

```bash
find ~/dotfiles -type f -name "*.sh" -exec chmod +x {} +
~/dotfiles/00_scripts/install.sh
```
