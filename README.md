# Forked for the Launcher only

After having discovered the extremely powerful [Hammerspoon](http://www.hammerspoon.org/) app, and finally landing on a configuration that I am very happy with, I thought I should share it with others to enjoy. I've tried to comment `init.lua` to make it easier to understand.

I use this config together with some [Karabiner](https://karabiner-elements.pqrs.org) remapping to achieve a fast and usable config with a short learning curve.

# Features

- Reload on Save
- Hyper Key
- Window Switcher menu
- **Quick per-application window switcher (Across spaces!)**


# Additional details and usage

## Hyper and hotkeys

Hyper is what people like to call a special shortcut comprised of multiple modifier keys. In this case the hyper key is the following:

Hyper = <kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>cmd</kbd>


### Launcher
I use <kbd>Hyper</kbd> + `<key>` to either launch or switch to certain applications. This is easily configured in the init.lua file so feel free to modify it for your own use. 

examples:

- <kbd>Hyper</kbd>+<kbd>V</kbd> = Launch or switch to Vivaldi
- <kbd>Hyper</kbd>+<kbd>S</kbd> = Launch or switch to Slack
- <kbd>Hyper</kbd>+<kbd>C</kbd> = Launch or switch to Calendar
- <kbd>Hyper</kbd>+<kbd>E</kbd> = Launch or switch to Excel
... you get the idea

# Install

- Install [Hammerspoon](https://www.hammerspoon.org/)
- copy the contents of this repo into you `~/.hammerspoon` folder
- Reload the config
