# apparix
Command line directory bookmarks with jumping to bookmarks, subdirectory tab completion, distant listing etc

Apparix is a tiny set of commands implementing directory bookmarking in **bash** and **zsh**.
You just need the file [.bourne-apparix](https://raw.githubusercontent.com/micans/apparix/main/.bourne-apparix).
What apparix provides:

- Bookmark the current directory by issuing `bm foo`. This takes effect instantly
  across all your sessions (it is stored in `$HOME/.apparixrc`).

- Jump to `foo` by issuing\
  `to foo`

- Even better, jump to the subdirectory `barzoodle` of `foo` using\
  `to foo barzoodle`

- Even betterer, use cyclic tab completion with subdirectory jumping:\
  `to foo b<TAB>` or just `to foo <TAB>`\
  👆 This is the oomphiest bit.

- This works at arbitrary levels:\
  `to foo barzoodle/ti<TAB>`

- There are several *distant* listing/editing commands (see table below).
  In all cases, tab completions work on subdirectories and files.

When I mentioned that the set of commands is tiny, what I really meant
was that the set of cd-related command is tiny; basically `bm` and `to`.
Having bookmarks for directories is useful for other commands
as well, such as distant listing, finding and editing, plus convenience
queries such as the age old questions: Am I a Bookmark? (`amibm`)
Am I or Is Any of My Parents a Bookmark? (`above`), and
Am I or is Any of My Children a Bookmark? (`below`).
The following table is the output of the apparix `ahoy` helper function:


```
Apparix functions, grouped and roughly ordered by expected use.
             Below all SUBDIR and FILE can be tab-completed.

  bm   MARK               Bookmark current directory as mark
  to   MARK [SUBDIR]      Jump to mark or a subdirectory of mark
-----------------------------
  ae MARK [SUBDIR/]FILE [editor options] Edit file in mark
  av MARK [SUBDIR/]FILE [editor options] View file in mark
---------------------------------
  aget MARK [SUBDIR/]FILE       Copy file to current directory
  aput MARK [SUBDIR] -- FiLE+   Copy files to mark (-- required)
  acat MARK [SUBDIR/]FILE       Cat file
----------------------------------------------
  amd  MARK [SUBDIR] [mkdir options] Make dir in mark
  a    MARK [SUBDIR/]FILE Echo the true location of file, useful
                 e.g. in: cp file $(a mark dir)
----------------------------------------------
  als  MARK [SUBDIR] [ls-options]  List mark dir or subdir
  ald  MARK [SUBDIR]      List subdirs of mark dir or subdir
                          ignores hidden directories
  aldr MARK [SUBDIR]      Like ald, recursively
------------------------
  amibm                   See if current directory is a bookmark
  above                   List . and all parents along bookmark names
  below                   List . and all children along bookmark names
  bmgrep PATTERN          List all marks where target matches PATTERN
--------------------
  agather MARK            List all targets for bookmark mark
  whence MARK             Menu selection for mark with multiple targets
----------------
  todo MARK [SUBDIR]      Edit TODO file in mark dir
  rme MARK [SUBDIR]       Edit README file
  portal                  current directory subdirs become mark names
  portal-expand           Re-expand all portals
  aghast MARK [SUBDIR/]FILE [dummy options] testing the apparix muxer
-------
  Where options passing is indicated above:
   - The sequence has to start with a '-' or '+' character.
   - Multiple options with arguments can be passed.
   - -- occurrences are removed but will start a sequence.
   - FWIW Arguments with spaces in them seemed to work under limited
     testing, e.g. ae pl main.nf '+set paste'
```

Tab completion with apparix works best, IMHO, with cyclic tab completion. This
is activated by the line `TAB: menu-complete` in the file `$HOME/.inputrc` (and you may
need as well put `INPUTRC=$HOME/.inputrc` in `$HOME/.bashrc`), or the
line `bind '"\t":menu-complete'` in `$HOME/.bashrc`. 

[Get it now](https://raw.githubusercontent.com/micans/apparix/main/.bourne-apparix):
```
wget https://raw.githubusercontent.com/micans/apparix/main/.bourne-apparix
```

Apparix allows the same mark to point to different directories.
This can be useful e.g. for subsequent projects with a common theme or
associated with the same collaborator, or simply using a `now` bookmark for the current
project. The `to` jump command will use the last occurrence in the resource file
as the destination to use (default target). I find it useful to keep the older destinations
around as a trail of my activities. Use `agather` to view all associated
targets, use `whence` to pick an older destination,
or edit the resource file with `via` to change the default target.

To list all bookmarks traversing upwards use `above`. This can be useful to
re-orient yourself when deep in some file hierarchy. Output e.g.

```
ax+ a- apx          /home/stijn/git/micans/apparix
gm                  /home/stijn/git/micans
git                 /home/stijn/git
h                   /home/stijn
                    /home
```

Similarly to list all bookmarks traversing the tree below the current directory use `below`.
`below` takes an optional integer argument `k`, limiting the output to paths with no more
than `k` steps below the current directory.


I use `amibm` in `PROMPT_COMMAND`. It lists the marks under which the current
directory `$PWD` is known. Let's call a mark `mrk` with multiple directories a
multi-mark. Now `mrk` is listed by `amibm` as `mrk-` if it is a multi-mark and
`$PWD` is not the default (last-listed) target, as `mrk+` if it is a multimark
and `$PWD` *is* the default target, and just as `mrk` if `$PWD` is the unique
target. As a contrived example, suppose this is the location where apparix source code lives:
```
> /git/micans/apparix (main *%) (ax+ a- apx) pwd
/home/stijn/git/micans/apparix
> /git/micans/apparix (main *%) (ax+ a- apx) amibm 
ax+ a- apx
```
It shows that the location `/home/stijn/git/micans/apparix` (that is, `$PWD`)
is associated with three bookmarks, two of which have this location as default target
The mark `apx` is unique. The mark `ax` points to `$PWD`
but has other (older) targets as well. The mark `a` points to another path
and `$PWD` is an older target.

There are two asymmetries between `aget` and `aput`. The former can only
retrieve a single file, but tab completion on the (distant) file to be copied
works. The latter can copy over multiple files, but tab completion is bound
to the target and hence does not work on the files to be copied. For other cases
just work with `$(a mark dir)`. This can be combined with globbing, as in

```
cp $(a mrk)/*.txt .
```

Many thanks to Sitaram Chamarty for the original idea of sub-directory
completion and the first bash implementation thereof, and to Izaak van Dongen
for the zsh completion code and complete overhaul and improvement of the bash
completion code.  Thanks to Martin Zuther
there is a cool [**fish** implementation](https://github.com/mzuther/appari-fish),
named appari-fish.


## Apparix/apparish developments, past and ongoing

In the beginning (2005-ish) the system was called Apparix. It was
implemented in C and shipped with bash wrapper functions and tab completion.
Sitaram Chamarty got in touch, instigated subdirectory tab completion and
contributed the bash code, adding pivotal oomph to apparix.
The C code was, in hindsight, a slightly heavy hammer.
A simple bash shell reimplementation was undertaken
many years later, around 2018 and published in the `micans/bash-utils`
repository.  Izaak thought of the name apparish and added zsh code and
additionally contributed a thorough rewrite of the bash completion layer (more
about that below).

Martin added appari-fish to the family. The valley was peaceful for a
while.  Early 2021 I realised that I still think of the valley as apparix, so
I've tweaked documentation and renamed files to revert back to apparix, followed
by moving it to its own repository.

A bleeding edge fork of apparix lives in [this repo](https://github.com/goedel-gang/bash-utils/),
supporting among other things newlines in the directory name that a bookmark
points to.  For various reasons (my dinosaur habits among them) that code did
not make it into this repository. The main reason you might want to use the
dinosaur code here is that I'm a pretty heavy apparix user and live
the distant directory experience every day.
The bash helper functions occasionally receive little additions and
improvements. When this happens the functionality is
described and added to the list of example commands at the top.
Happy to'ing!


