# Session initialization

Quick way to initialize your session for :
- vim
- git
- brew
- shell (zsh and fish)
- other packages...

## Installation
``` bash
git clone git@github.com:curquiza/init_session.git
cd init_42_session
sh start_init.sh
```
#### 42 session
Use `sh start_init_42.sh` instead.
Brew will be installed in home directory.

## Vim 
To install all Vim plugins.  
In a Vim file, enter :
```:PlugInstall```

## Fish shell

Add Fish as default shell :
``` bash
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
```

#### 42 session
Iterm -> Preferences -> Profil -> General tab -> Command paragraph -> enter "fish" in Send text as start

## Last tasks
- remove all useless icons from the Dock
- modify keyboard and mouse settings
- Iterm natural text editing : Iterm -> Preferences -> Profiles -> Keys -> Load Preset -> Natural Text Editing
- Use current directory when splitting terminal : Iterm -> Preference -> Profiles -> General tab -> Working directory paragraph -> Reuse previous session's directory
