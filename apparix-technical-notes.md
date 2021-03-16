# Apparish technical notes.

Directory bookmarking system. It used to be implemented in C, shipped with bash
wrapper functions and completion code. This is now legacy, and if you want it
you should go and get it from an old commit
(https://github.com/micans/bash-utils/tree/b825f656bc1092613d74d30ce5a1efc644d37948).

The new pure shell implementation is in `.bourne-apparix`. This works with bash
and zsh, providing tab completion for both. The zsh version goes through the
native zsh completion mechanism for files, so it will complete exactly like you
expect it to.

The bash version implements its own file completions. It has an extra
sophisticated mode called Gödel completion, which quotes directories and can
still complete on subdirectories. To disable this mode, set the variable
`$APPARIX_BERTRAND_RUSSEL` to a nonempty string.

There may be some weird behaviour if you have file names with colons in. This
is because of `$COMP_WORDBREAKS`: see
https://stackoverflow.com/questions/2805412/bash-completion-for-maven-escapes-colon.
You may have to manually override this variable. If you do, check that it
doesn't get re-overriden by any other scripts. (`git-completion` seems to
forcefully add a colon, for example.)

If you're a user of `bash-completion`
(requiring Bash >= 4.1) you may be interested in the compatibility-breaking
branch https://github.com/goedel-gang/bash-utils/tree/twenty-first-century,
which just uses `_filedir`.

This fork allows itself to be a little more extravagant, and also has an
alternative zsh apparix that wraps directory hashing, automatically providing
bookmarks everywhere that zsh does file expansion. It also has some more prompts
for Zsh and packages some demo shells and screenshots.

