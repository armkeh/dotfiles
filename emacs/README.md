This repository contains the files that make up my Emacs setup.

For the moment, that is my (literate) Emacs initialisation file
and my `yankpad` file.


# Table of Contents

1.  [Introduction](#org1dfdbce)
    1.  [Setting up `.emacs` to use this code](#orga739776)
2.  [Major packages](#org50c0efe)
    1.  [Package repositories](#org24d2399)
    2.  [`general`](#orgfcb17bc)
    3.  [`agda` mode](#org04616c9)
    4.  [`org` mode](#org9c9bd13)
    5.  [`pdf-tools`](#org371af97)
    6.  [`yankpad` and `yasnippets`](#org8ae9340)
3.  [Cosmetics](#org88692e1)
    1.  [Always confirm before closing Emacs](#org02cbd24)
    2.  [Remove unnecessary interface elements](#org31ae006)
    3.  [Themes](#org99f2a1e)
    4.  [Information in the mode line](#org26e4e4d)
    5.  [Show line numbers on left (for `text` and `prog` mode)](#org066d0c6)
    6.  [Highlight matching parenthesis when cursor is near](#org6506f45)
    7.  [Show trailing whitespace](#org555538a)
    8.  [Display preferences for `dired`](#orgaca95b2)
    9.  [Show ruler at 80 characters for (for `text` and `prog` mode)](#org9a364a9)
    10. [Wrap lines](#org8843939)
    11. [Automatically revert unchanged files which change on the disk](#orgb902398)
    12. [Use `wordsmith` for English syntax highlighting](#orgfd1e5f3)
    13. [Show possible completions as I type shortcuts](#orgbec038d)
    14. [Use a single buffer for `dired`](#org387e15c)
    15. [Buffers to open upon startup](#org2453f68)
4.  [Other](#orgdf7a6a0)
    1.  [Run my custom “dropbox start” command to ensure dropbox is running on the system](#org2e21196)
5.  [Generating the README.md for my Emacs repo](#orgb614ffb)

-   Emacs initialisation


<a id="org1dfdbce"></a>

# Introduction

This is my `emacs` initialisation code, documented for my own understanding
in the future and for sharing with others.

I'm following [Musa's](https://alhassy.github.io/init/) example using an `org` file for this.


<a id="orga739776"></a>

## Setting up `.emacs` to use this code

Create a symbolic link to this file in `~/.emacs.d/~,
then add to the bottom of =~/.emacs` these lines:

    ;; BEGIN my edits
    
    ;; I've set up an init file following Musa's guide: https://alhassy.github.io/init/
    
    ;; Enable Emacs VC on symlinked files
    (setq vc-follow-symlinks t)
    
    ;; Evaluate my init file.
    (org-babel-load-file "~/.emacs.d/emacs-init.org")
    
    ;; Byte compile the file so that changes to emacs-init.org get picked up.
    (byte-compile-file "~/.emacs")
    
    ;; END my edits


### Why set `vc-follow-symlinks` here?

It's a setting I want anyway (it ensures Emacs's version control
works correctly on the target file), but why set it in `.emacs`?

Since `.emacs` uses a symlink to this version controlled file,
having Emacs prompt me every time is annoying and slows my start up.


<a id="org50c0efe"></a>

# Major packages


<a id="org24d2399"></a>

## Package repositories

    (require 'package)
    (setq package-archives
       '(("melpa" . "https://melpa.org/packages/")
         ("gnu" . "https://elpa.gnu.org/packages/")
         ("org" . "http://orgmode.org/elpa/")))
    (package-initialize)


### Set the load path for manually downloaded packages

(Currently I don't use manually downloaded packages)

    ;;(add-to-list 'load-path "~/Dropbox/Organisation/setup/emacs/downloaded-packages")


<a id="orgfcb17bc"></a>

## `general`

I use `general` to organise my custom keybindings.

    (require 'general)


### Prefixes

You can use `general-define-key` directly to define shortcuts,
ideally using the keyword argument `:prefix` to avoid repeating
prefixes, but if you are (even only possibly)
using a prefix several times,
it's better to create a custom function to use instead of
`general-define-key`.

Setting `:keymaps` to `'override` ensures that no package will
override my shortcuts.

For the moment, I'm experimenting with using `s`-key (“super”-key)
combinations as prefixes. I have my caps lock bound to super
(on my Chromebook's internal keyboard it's bound to that by
default), and I think if I restrict the combination keys to
those on the left side of the keyboard, I can avoid “Emacs pinky”.

So far I have three categories of shortcuts:

-   My main shortcuts, those that don't fall into another category.
-   Shortcuts to navigate around the current buffer.
-   Shortcuts to open a `dired` buffer for a certain folder.

    (general-create-definer general-main-define-key
      :prefix "s-a"
      :keymaps 'override)
    
    (general-create-definer general-buf-nav-define-key
      :prefix "s-w"
      :keymaps 'override)
    
    (general-create-definer general-dired-define-key
      :prefix "s-d"
      :keymaps 'override)


### `yankpad`

I use a non-prefixed shortcut for snippet expansion, since
I do it all the time.
(at least until yankpad has smart tab expansion).

    (general-define-key
      "s-f" 'yankpad-expand)

Alternatively, `y m` invokes `yankpad-map`, which brings up a
keymap of the last tags of snippets.

    (general-main-define-key
      "y m" 'yankpad-map)

Changes to the yankpad file require `yankpad-reload` to be run
to re-cache the snippets. For the moment, it seems like there is
separate caching for each buffer, meaning this command has to be
run in every buffer where I want changes to be picked up.
So, I have a shortcut key.

    (general-main-define-key
      "y r" 'yankpad-reload)


### `dired`

I use shortcuts to jump to frequently used directories in `dired`
(from any buffer, not just while in `dired`).

As seen in `Cosmetics`, I use `dired-single` in order to only have one
`dired` buffer at a time. In case this changes, I define another
local variable to store the command to invoke `dired` with.

    (defun my-dired-invocation (directory) (dired-single-magic-buffer directory))

    (general-dired-define-key
      "h" (lambda () (interactive) (my-dired-invocation "~"))
      "o" (lambda () (interactive) (my-dired-invocation "~/Dropbox/Organisation/"))
      "p" (lambda () (interactive) (my-dired-invocation "~/Dropbox/Projects/"))
      "m" (lambda () (interactive) (my-dired-invocation "~/Dropbox/McMaster/"))
      "t" (lambda () (interactive) (my-dired-invocation "~/Dropbox/McMaster/Agda/thesis/"))
      "c e" (lambda () (interactive) (my-dired-invocation "~/Dropbox/McMaster/3ea3/"))
    )


### Buffer navigation

    (general-buf-nav-define-key
      "r" (lambda () (interactive) (revert-buffer () t ()))
      "b" (lambda () (interactive) (beginning-of-buffer))
      "e" (lambda () (interactive) (end-of-buffer))
      "t t" (lambda () (interactive) (toggle-my-themes))
      "t c" (lambda () (interactive) (disable-all-custom-themes))
    )


### `magit`

    (general-main-define-key
      "g" 'magit-status
    )


### Other

    (general-main-define-key
      "j" 'dad-joke
    )


<a id="org04616c9"></a>

## `agda` mode

We need Emacs to locate Agda mode. This command is put in `.emacs`

    (load-file (let ((coding-system-for-read 'utf-8))
                    (shell-command-to-string "agda-mode locate")))

    (require 'agda-input)
    (require 'agda2-highlight)


### Command line arguments

Dr. Wolfram Kahl has recommended the following settings.

(I'm not setting them right somehow&#x2026;)

    ;;(setq agda2-program-args (quote ("RTS" "-M4G" "-H4G" "-A128M" "-RTS")))

These arguments specify

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">`+RTS`, `-RTS`</td>
<td class="org-left">Flags between these are arguments to the `ghc` runtime</td>
</tr>


<tr>
<td class="org-left">`-M[size]`</td>
<td class="org-left">Maximum heap size</td>
</tr>


<tr>
<td class="org-left">`-H[size]`</td>
<td class="org-left">Suggested heap size</td>
</tr>


<tr>
<td class="org-left">`-A[size]`</td>
<td class="org-left">Allocation area size used by the garbage collector</td>
</tr>
</tbody>
</table>

Full documentation for the `ghc` runtime argumentscan be found [here](https://downloads.haskell.org/~ghc/7.8.4/docs/html/users_guide/runtime-control.html).

Additional arguments that may be useful include

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">`-S[file]`</td>
<td class="org-left">Produces information about “each and every garbage collection”</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">- Outputs to `stderr` by default</td>
</tr>
</tbody>
</table>


### Alternative problem highlighting

I find the background coloring used by Agda for incomplete pattern matching,
redundant clauses and clauses which do not hold definitionally hard to read
in general, and usually unreadable with different themes.

So I use set other indicators instead.

    (defun my-agda-highlighting ()
      "Set face attributes to replace Agda highlighting I find annoying."
      (set-face-attribute
        'agda2-highlight-coverage-problem-face
        nil ;; all frames
        :background nil
        :underline "dark red"
      )
      (set-face-attribute
        'agda2-highlight-reachability-problem-face
        nil ;; all frames
        :background nil
        :strike-through t
      )
      (set-face-attribute
        'agda2-highlight-catchall-clause-face
        nil ;; all frames
        :background nil
        :slant 'italic
      )
    )
    
    (add-hook 'agda2-mode-hook 'my-agda-highlighting)


### Add unicode characters to Agda's translations

1.  Punctuation and parentheses

        (add-to-list 'agda-input-user-translations '(";;" "﹔"))
        (add-to-list 'agda-input-user-translations '(";;" "⨾"))
        (add-to-list 'agda-input-user-translations '("|" "❙"))
        (add-to-list 'agda-input-user-translations '("st" "•"))
        (add-to-list 'agda-input-user-translations '("{" "｛"))
        (add-to-list 'agda-input-user-translations '("}" "｝"))

2.  Activate the new additions

        (agda-input-setup)


### Activate Agda input mode in `text` and `prog` modes

    (add-hook 'text-mode-hook
           (lambda () (set-input-method "Agda")))
    (add-hook 'prog-mode-hook
           (lambda () (set-input-method "Agda")))


<a id="org9c9bd13"></a>

## `org` mode

    (require 'org)
    (require 'ox-extra)


### Speed keys

Speed keys are single keystrokes which execute commands in an
`org` file when the cursor is at the start of a headline.

    (setq org-use-speed-commands t)

To see the commands available, execute

    (org-speed-command-help)


### Hide emphasis markers by default

    (setq org-hide-emphasis-markers t)


### Highlight math mode blocks

    (setq org-highlight-latex-and-related '(latex))


### Exporting

1.  Allow for ignoring headlines and/or subtrees

    Use the `:ignore:` tag on headlines to omit the headline when
    exporting, but keep its contents.
    
        (ox-extras-activate '(ignore-headlines))
    
    Alternatively, use the `:noexport:` tag to omit the headline
    *and* its contents.
    
        ;;;; noexport is in the list by default
        ;; (add-to-list 'org-export-exclude-tags "noexport")

2.  Source code block indentation and colouring

    I want to preserve my indentation for source code during export.
    
        (setq org-src-preserve-indentation t)
    
    The `htmlize` package preserves source code colouring on export to html.
    (And presumably does a lot more I am not fully aware of).
    
        (require 'htmlize)

3.  Export in the background

    Using `latex-mk`, the export process takes a bit of time.
    Tying up emacs during that time is annoying, so set the
    export to happen in the background.
    
        (setq org-export-in-background t)

4.  LaTeX specific

    1.  Default LaTeX compiler
    
        I use a lot of unicode, and I find `xelatex` and `lualatex`
        handle that more easily than `pdflatex`.
        
        From my experience so far, they seem pretty interchangable
        for my purposes, so the decision of which to use is arbitrary.
        
        Based on [this discussion on Stack Exchange](https://tex.stackexchange.com/questions/36/differences-between-luatex-context-and-xetex), LuaTeX seems the more
        “up and coming” engine, so I'm using it at least until something breaks.
        
            (setq org-latex-compiler "lualatex")
    
    2.  LaTeX compilation process
    
        I use `latexmk` to automatically run as many passes as needed
        to resolve references, etc.
        
            (setq org-latex-pdf-process
                  '("latexmk -%latex -f %f"))
        
        The flags/format specifiers are
        
        <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
        
        
        <colgroup>
        <col  class="org-left" />
        
        <col  class="org-left" />
        </colgroup>
        <tbody>
        <tr>
        <td class="org-left">`%latex`</td>
        <td class="org-left">stands in for the latex compiler (defaults to the setting above)</td>
        </tr>
        
        
        <tr>
        <td class="org-left">`-f`</td>
        <td class="org-left">force continued processing past errors</td>
        </tr>
        
        
        <tr>
        <td class="org-left">`%f`</td>
        <td class="org-left">stands in for the (relative) filename</td>
        </tr>
        </tbody>
        </table>
        
        Other flags/format specifiers I may wish to add later include
        
        <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
        
        
        <colgroup>
        <col  class="org-left" />
        
        <col  class="org-left" />
        </colgroup>
        <tbody>
        <tr>
        <td class="org-left">`-shell-escape`</td>
        <td class="org-left">necessary to use `minted`</td>
        </tr>
        </tbody>
        </table>
    
    3.  Custom document classes (customising outermost structure)
    
        I want a `report` class that begins with `chapter`'s, rather than
        `part`'s.
        
            (add-to-list
              'org-latex-classes
                '("report-noparts"
                  "\\documentclass{report}"
                  ("\\chapter{%s}" . "\\chapter*{%s}")
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
    
    4.  Source code colouring in LaTeX exports
    
        We can use `minted` for source code colouring on export to LaTeX.
        
        Currently this breaks things with my literate Agda process,
        a problem I should resolve. For the moment, if I want to use
        `minted`, I can do so on a file-by-file basis.
        
        ⟪ `pygments` (also called `python-pygments`) must be installed on the
          system for this to work. ⟫
        
            ;;(setq org-latex-listings 'minted
            ;;      org-latex-packages-alist '(("" "minted")))


### Evaluating code

By default, Emacs will query whether we *actually* want to
execute code when we evaluate a code block. Also, it seems to
just *not* execute code marked for execution during export in an
`org` file. So, I remove the safety.

    (setq org-confirm-babel-evaluate nil)

Loading the following languages with `require` allows code blocks
in them to be evaluated.

By default only emacs lisp can be evaluated.

Documentation [here](https://orgmode.org/manual/Languages.html).

    (require 'ob-C)
    (require 'ob-haskell)
    (require 'ob-latex)
    (require 'ob-shell)

For shell code, we need to initialise via this function.
See [here](https://emacs.stackexchange.com/questions/37692/how-to-fix-symbols-function-definition-is-void-org-babel-get-header).

    (org-babel-shell-initialize)


<a id="org371af97"></a>

## `pdf-tools`

Need to “install” it each time emacs starts

    (pdf-tools-install)


<a id="org8ae9340"></a>

## `yankpad` and `yasnippets`

I use `yasnippets` for text expansion, and `yankpad` to organise my
snippets.

    (require 'yasnippet)
    (yas-global-mode t)
    
    (require 'yankpad)
    (setq yankpad-file "~/Dropbox/Organisation/setup/emacs/yankpad.org")

`yas-wrap-around-region` controls what is inserted for a snippet's
`$0` field. A non-nil, non-character setting has it insert the
current region's contents (i.e. if we highlight a region and
invoke a snippet, the region will be wrapped).

    (setq yas-wrap-around-region t)


### Don't add a final newline when editing snippet files

`yasnippets` will insert the final newline when expanding a snippet,
so snippet files generally shouldn't include a final newline.

    (add-hook 'snippet-mode-hook (setq require-final-newline nil))


<a id="org88692e1"></a>

# Cosmetics


<a id="org02cbd24"></a>

## Always confirm before closing Emacs

    (setq confirm-kill-emacs 'yes-or-no-p)


<a id="org31ae006"></a>

## Remove unnecessary interface elements

Emacs usually shows a splash screen on startup,
which doesn't interest me.

    (setq inhibit-splash-screen t)

I don't use the tool bar (icons below the menu bar).
(This setting must be `-1`, not `()`).

    (tool-bar-mode -1)

I also don't use the menu bar.
(Again, this must be `-1`, not `()`).

    (menu-bar-mode -1)

I also disable the scroll bars.

    (scroll-bar-mode -1)


<a id="org99f2a1e"></a>

## Themes

I use the `doom-nord` themes,
and toggle between the non-`light` and `light` variants.

    (load-theme 'doom-nord t)
    
    (setq my-dark-theme 'doom-nord)
    (setq my-light-theme 'doom-nord-light)
    
    (defun disable-all-custom-themes ()
      "Disable all custom themes.
       Returns the previous highest precendence theme
       (nil if no themes were previously enabled).
    
       Implementation:
         Gets the highest precedence applied theme as the first element
         of custom-enabled-themes.
    
         Then iteratively disables all the themes in custom-enabled-themes.
      "
      (let ((most-recent-theme (car custom-enabled-themes)))
        (while (car custom-enabled-themes)
          (disable-theme (car custom-enabled-themes)))
        most-recent-theme
      )
    )
    
    (defun toggle-my-themes ()
      "Disable all custom, then try to toggle the themes
       my-dark-theme and my-light-theme, in that if one was
       the last applied theme, the other will be applied.
    
       If neither was the last applied theme, my-dark-theme
       will be applied as a default.
      "
    
      (let ((most-recent-theme (disable-all-custom-themes)))
        (if (eq most-recent-theme my-dark-theme)
            (load-theme my-light-theme)
            (load-theme my-dark-theme)
        )
      )
    )
    
    (eq (car custom-enabled-themes) my-dark-theme)
    (disable-all-custom-themes)
    (toggle-my-themes)

Make it “play nice” with `org`

    (doom-themes-org-config)


<a id="org26e4e4d"></a>

## Information in the mode line

The doom themes package comes with a function to make
the mode line flash on error.

    (doom-themes-visual-bell-config)

I'd previously just used `visible-bell`, but it's a bit nosier
than necessary.

    ;;(setq visible-bell t)

I also like the mode line to show the data and time.

    (setq display-time-day-and-date t)
    (setq display-time-24h-format t)
    (display-time)

It's also useful to see the line number and column number.

    (line-number-mode t)
    (column-number-mode t)


<a id="org066d0c6"></a>

## Show line numbers on left (for `text` and `prog` mode)

    (add-hook 'text-mode-hook 'linum-mode)
    (add-hook 'prog-mode-hook 'linum-mode)

Setting it globally would conflict with `pdf-tools`.

    ;; (global-linum-mode t)


<a id="org6506f45"></a>

## Highlight matching parenthesis when cursor is near

    (load-library "paren")
    (show-paren-mode 1)
    (transient-mark-mode t)
    (require 'paren)


<a id="org555538a"></a>

## Show trailing whitespace

    (custom-set-variables '(show-trailing-whitespace t))


<a id="orgaca95b2"></a>

## Display preferences for `dired`

`dired` makes use of switches for `ls`.

I like the following switches:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">`--group-directories-first`</td>
<td class="org-left">group directories before files</td>
</tr>


<tr>
<td class="org-left">`-a`</td>
<td class="org-left">do not ignore entries starting with .</td>
</tr>


<tr>
<td class="org-left">`-B`</td>
<td class="org-left">do not list implied entries ending with ~</td>
</tr>


<tr>
<td class="org-left">`-g`</td>
<td class="org-left">long listing format, but do not list owner</td>
</tr>


<tr>
<td class="org-left">`-G`</td>
<td class="org-left">in a long listing, don't print group names</td>
</tr>


<tr>
<td class="org-left">`-h`</td>
<td class="org-left">print human readable size</td>
</tr>


<tr>
<td class="org-left">`-L`</td>
<td class="org-left">show information for *references* rather than symbolic links</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>
</tbody>
</table>

-group-directories-first~   “group directories before files”

-   `-a` “do not ignore entries”

    (setq dired-listing-switches "--group-directories-first -aBgGhL")


<a id="org9a364a9"></a>

## Show ruler at 80 characters for (for `text` and `prog` mode)

    (require 'fill-column-indicator)
    (add-hook 'text-mode-hook 'fci-mode)
    (add-hook 'prog-mode-hook 'fci-mode)


<a id="org8843939"></a>

## Wrap lines

    (global-visual-line-mode t)


<a id="orgb902398"></a>

## Automatically revert unchanged files which change on the disk

    (global-auto-revert-mode t)


<a id="orgfd1e5f3"></a>

## TODO Use `wordsmith` for English syntax highlighting

    (require 'wordsmith-mode)


<a id="orgbec038d"></a>

## Show possible completions as I type shortcuts

    (require 'which-key)


<a id="org387e15c"></a>

## Use a single buffer for `dired`

I use `dired-single` to avoid `dired` opening a new buffer
for every directory visited.

    (require 'dired-single)

I use a “magic” buffer with the name `*Dired*`, to avoid the single
`dired` buffer being named after whatever directory I first visit.

    (setq dired-single-use-magic-buffer t)
    (setq dired-single-magic-buffer-name "*Dired*")

The below code, which rebinds keys to use `dired-single` rather than `dired`,
is taken directly from the `dired-single` [GitHub readme](https://github.com/crocket/dired-single).

    (defun my-dired-init ()
      "Bunch of stuff to run for dired, either immediately or when it's
       loaded."
      ;; <add other stuff here>
      (define-key dired-mode-map [return] 'dired-single-buffer)
      (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
      (define-key dired-mode-map "^" 'dired-single-up-directory)
    )
    
    ;; if dired's already loaded, then the keymap will be bound
    (if (boundp 'dired-mode-map)
            ;; we're good to go; just add our bindings
            (my-dired-init)
      ;; it's not loaded yet, so add our bindings to the load-hook
      (add-hook 'dired-load-hook 'my-dired-init))


<a id="org2453f68"></a>

## Buffers to open upon startup

Note that this portion of the file should be *after* any settings
that would affect these buffers.

Otherwise those settings will not apply in these buffers.


### Emacs init (this file)

    (find-file "~/Dropbox/Organisation/setup/emacs/emacs-init.org")


### Emacs tips and tricks

    (find-file "~/Dropbox/Organisation/setup/emacs/tips-and-tricks.org")


### Yasnippets file

    (find-file "~/Dropbox/Organisation/setup/emacs/yasnippets.org")


### Yankpad file

    (find-file "~/Dropbox/Organisation/setup/emacs/yankpad.org")


### My Agda scratch file

    (find-file "~/Dropbox/McMaster/Agda/scratch.agda")


### My phone log

    (find-file "~/Dropbox/Organisation/log/phone-log.org")


### My log (as the initial buffer)

    (setq initial-buffer-choice "~/Dropbox/Organisation/log/log.org")


<a id="orgdf7a6a0"></a>

# Other


<a id="org2e21196"></a>

## Run my custom “dropbox start” command to ensure dropbox is running on the system

    (start-process-shell-command "dropbox-start"
                                 "*dropbox-start*"
                                 "/opt/dropbox-filesystem-fix/dropbox_start.py")


<a id="orgb614ffb"></a>

# Generating the README.md for my Emacs repo

This code generates a `README.md` file for my Emacs repo,
including this file and other relevant files.

    (with-temp-buffer
      (insert
        "#+EXPORT_FILE_NAME: README.md
         #+TITLE: My Emacs setup
         #+OPTIONS: toc:nil
    
         This repository contains the files that make up my Emacs setup.
    
         For the moment, that is my (literate) Emacs initialisation file
         and my ~yankpad~ file.
    
         #+TOC: headlines 2
    
         * Emacs initialisation
    
         #+INCLUDE: emacs-init.org
    
         * ~yankpad~
    
         #+INCLUDE: yankpad.org
      ")
      (org-mode)
      (org-md-export-to-markdown)
    )

