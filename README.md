Setup
==========
+  run `git clone https://github.com/poetic/dotfiles.git ~/.poetic_dotfiles`
+ `~/.poetic_dotfiles/install`

After that you will need to do whats listed in the "Vim Setup" section to have
the vim plugins properly installed

Our boxen configuration does this for us so I don't have a script to do it for
you right now.

Vim Setup (optional)
==========

To get powerline working with the arrow-like fonts you will need to install
a patched font from the powerline fonts repo on github. Then set up your
terminal profile to use this font

TMUX
-----------------------------
Prefix Key: Ctrl-A

Make your own customizations
----------------------------

Put your customizations in dotfiles appended with `.local`:

* `~/.aliases.local`
* `~/.gitconfig.local`
* `~/.tmux.conf.local`
* `~/.vimrc.local`
* `~/.vimrc.bundles.local`
* `~/.zshrc.local`

Credits
----------------------------

@jakecraige, @MatthewHager

Lots borrowed from Thoughtbot's Dotfiles(https://github.com/thoughtbot/dotfiles)

This is truely a compilation of lots of resources around the net into compiled
together. If you find something you wrote within here let us know and we'll give
you credit.

License
---------------------------
MIT

