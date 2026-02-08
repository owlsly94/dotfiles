
<div align="center">
 <h1> Owlsly's dotfiles</h1>
</div>

<div align="center">

![GitHub last commit](https://img.shields.io/github/last-commit/owlsly94/dotfiles?style=for-the-badge&color=a6e3a1&logoColor=D9E0EE&labelColor=292324)
![GitHub Repo stars](https://img.shields.io/github/stars/owlsly94/dotfiles?style=for-the-badge&color=74c7ec&logoColor=D9E0EE&labelColor=292324&logo=andela)
![GitHub repo size](https://img.shields.io/github/repo-size/owlsly94/dotfiles?style=for-the-badge&color=cba6f7&logoColor=D9E0EE&labelColor=292324&logo=protondrive)

</a>
</div>
<hr />
<div align="center">
<p>
   Mostly config files of various window managers, compositors, editors and GTK themes and configs.</a>.<br/>
   Used mostly on Arch Linux, but I've also used them on Debian and Fedora.<br/>
</p>
</div>

> [!WARNING]
> I'm constantly changing my configs and I'm currently using Hyprland,<br/>
> so bare in mind that window managers like Qtile, XMonad or Awesome configs could be broken do to updates.


![image](https://raw.githubusercontent.com/owlsly94/dotfiles/main/assets/screen1.png)

## Installation
1. Clone the repo
```
git clone https://github.com/owlsly94/dotfiles.git
cd dotfiles
```
2. Copy `.config` folder into your home folder `~`
```
cp -r .config ~/
```
> [!NOTE]
> Be sure to backup your `.config` first with:
> ```
> mv .config .config.back
> ```
3. Copy `.zshrc` to your home folder `~`
```
cp .zshrc ~/
```
4. Make sure you untar the `zsh.tar.gz` from `~/.config/`
```
cd ~/.config/
tar -xzvf zsh.tar.gz
```

## Arch post-install script
> [!CAUTION]
> **This repository is ARCHIVED.** > The code is kept for historical reference and will no longer receive updates or bug fixes.
<p>
  You can easily use my <a href="https://github.com/owlsly94/arch-install">Arch Install script</a> to configure all this automatically.
</p>

## Arch post-install script for Hyprland
<p>
  If you just want to install Hyprland, go to <a href="https://github.com/owlsly94/hyprland">Hyprland</a>
</p>
