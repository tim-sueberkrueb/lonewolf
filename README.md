# Lone Wolf

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/timsueberkrueb/lonewolf.svg)](https://github.com/timsueberkrueb/lonewolf/releases)
[![GitHub issues](https://img.shields.io/github/issues/timsueberkrueb/lonewolf.svg)](https://github.com/timsueberkrueb/lonewolf/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2018.svg)](https://github.com/timsueberkrueb/lonewolf/commits/develop)

Lone Wolf is a role-playing book series from the 80s.

This is a fork of [Michael Terry](https://github.com/mikix)'s Lone Wolf app for Ubuntu Phone.

Lone Wolf is available for download from the [Open Store](https://open-store.io/app/lonewolf.timsueberkrueb).

## Story

You are the sole survivor of a devastating attack on the monastery where you were learning the skills of the Kai Lords. You swear vengeance on the Darklords for the massacre of the Kai warriors, and with a sudden flash of insight you know what you must do. You must set off on a perilous journey to the capital city to warn the King of the terrible threat that faces his people: For you are now the last of the Kai. You are now Lone Wolf.

## Dependencies

Qt >= 5.4.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)

The following modules and their dependencies are required:

 * [Ubuntu UI Toolkit 1.3](https://github.com/ubports/ubuntu-ui-toolkit)
 * [libxml2](http://xmlsoft.org/)

## Installation

We use [clickable](http://clickable.bhdouglass.com/).

To build and package the application, run:

```bash
clickable build
clickable build-click
```

To install the application on your device, make sure your device is
connected to your development machine with an USB cable and developer mode is enabled.

Run:

```
clickable install
clickable launch
```

## Credits

All credits go to [Michael Terry](https://github.com/mikix) for creating this gem.

## Licensing

Licensed under the terms of the GNU General Public License version 3.
