
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

> [!WARNING]
> I'm constantly changing something about my configs and I'm currently using mostly Hyprland,<br/>
> so bare in mind that window managers like Qtile, XMonad or Awesome configs could be broken do to updates.

</div>


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
<p>
  You can easily use my <a href="https://github.com/owlsly94/arch-install">Arch Install script</a> to configure all this automatically.
</p>
