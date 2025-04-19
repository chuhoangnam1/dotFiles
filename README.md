# chuhoangnam1 - dotFiles

## Set iTerm2 to read configuration from dotFiles directory
```shell
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```

## Disble MacOS's Dock from bouncing
```shell
defaults write com.apple.dock no-bouncing -bool TRUE;
```

## Change macOS's dock auto-hide delay
```shell
defaults write com.apple.dock autohide-delay -float 0;
defaults write com.apple.dock autohide-time-modifier -int 0;
killall Dock
```

## Restore macOS's dock auto-hide delay
```shell
defaults delete com.apple.Dock autohide-delay;
killall Dock
```
