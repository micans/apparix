# apparix
Command line directory bookmarks with subdirectory tab completion, immediate cd, distant listing etc

Apparix is a tiny set of commands implementing directory bookmarking in **bash** and **zsh**.
You just need the file [.bourne-apparix](https://raw.githubusercontent.com/micans/apparix/main/.bourne-apparix).
What apparix provides:

- Bookmark the current directory by issuing `bm foo`. This takes effect instantly
  across all your sessions (it is stored in `$HOME/.apparixrc`).

- Jump to `foo` by issuing\
  `to foo`

- Even better, jump to the subdirectory `barzoodle` of `foo` using\
  `to foo barzoodle`

- Even betterer, use tab completion with subdirectory jumping:\
  `to foo b<TAB>`

- Even even betterer, this works at arbitrary levels:\
  `to foo barzoodle/ti<TAB>`

- No less excellent, there are several *distant* listing/editing commands.
  In all cases, tab completions work on subdirectories and files:
```
  als foo              # list directory for apparix mark (plus optional subdirectories)
  als foo -ltr         # trailing part that looks like options is passed to ls
  amd foo              # make directory in apparix mark (plus optional subdirectories)
  ae foo bar.txt       # edit file in apparix mark (plus o.s.)
  av foo bar.txt       # view file in apparix mark (p.o.s.)
  aget foo bar.txt     # copy file from apparix mark (pos)
  amibm                # Is the current directory a bookmark? Useful in prompt.
  ald foo              # only list subdirectories of mark
  aldr foo             # list subdirectories recursively of mark
```
  These helper commands correspond to small bash functions and are easy to add.

Tab completion with apparix works best, IMHO, with cyclic tab completion. This
is activated by the line `TAB: menu-complete` in the file `$HOME/.inputrc` (and you may
need as well put `INPUTRC=$HOME/.inputrc` in `$HOME/.bashrc`), or the
line `bind '"\t":menu-complete'` in `$HOME/.bashrc`. 

Apparix's spiritual home nowadays is right here.
It previously was at what I would now consider the
[site of historical documents](http://micans.org/apparix).

Many thanks to Sitaram Chamarty for the original idea of sub-directory
completion and the first bash implementation thereof, and to Izaak van Dongen
for the zsh completion code and complete overhaul and improvement of the bash
completion code.
Thanks to Martin Zuther
there is a cool [**fish** implementation](https://github.com/mzuther/appari-fish),
named appari-fish.


## Apparix/apparish developments, past and ongoing

In the beginning (2005-ish) the system was called Apparix. It was
implemented in C and shipped with bash wrapper functions and completion code.
The C code was, in hindsight, a slightly heavy hammer (although it must consume
many fewer CPU cycles). A simple bash shell reimplementation was undertaken
many years later, around 2018.  Izaak thought of the name apparish and added
zsh code and additionally contributed a thorough rewrite of the bash completion
layer.  Martin added appari-fish to the family. The valley was peaceful for a
while.  Early 2021 I realised that I still think of the valley as apparix, so
I've tweaked documentation and renamed files to revert back to apparix. The
glorious shell code itself is still apparish-rich. Stay tuned for further
naming shenanigans. More relevant, the bash helper functions are still
undergoing little tweaks and improvements every now and then. When this happens
the functionality is described and added to the list of example commands at the top.


