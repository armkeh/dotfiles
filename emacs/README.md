<!-- This file is tangled from README.org,
     which itself is tangled and imports from emacs-init.org.
     This file should not be modified directly.-->

This directory contains the files that make up my Emacs setup.

Below are the contents of my literate Emacs initialisation file.

See also my

-   [Yankpad snippets file](./yankpad.md)
    -   (Frequently used text expansions.)


# Table of Contents

1.  [Introduction](#orgac06626)
    1.  [The file layout](#org0f8de1f)
2.  [How to use this file](#orga9f3474)
3.  [Environment setup and package management](#org776dbfa)
    1.  [Set a “custom” file](#org69ad75c)
    2.  [Basic package management](#orgbc4b1b9)
    3.  [Set package repositories](#orgf255c52)
    4.  [A package manager – `use-package`](#orgbd3ea64)
    5.  [Update packages](#org1c2d181)
    6.  [Make sure we have the right PATH](#orgf15ff42)
    7.  [Set a directory for non-package manager managed Elisp files](#org0b4e5b8)
    8.  [Elisp utilities](#orgdc9eb14)
4.  [Custom Elisp](#org4a7ee8d)
    1.  [Toggle themes](#org2dcffca)
    2.  [Theme change hook](#org05e4aba)
    3.  [Cascading window setup](#org205cbba)
    4.  [Killing a buffer when its associated process finishes](#org7a4a93e)
5.  [Simple cosmetics](#orgc177521)
    1.  [First: disable the splashscreen and find the my emacs init file](#org1ba1756)
    2.  [Disable unnecessary interface elements](#org4118bd5)
    3.  [Fonts](#org2dba6f5)
    4.  [Line and column information](#orgb5ad1e2)
    5.  [Themes](#org9069ed7)
    6.  [Highlight matching delimters](#org5a75684)
    7.  [Kill the open init buffer and reopen it](#orgb32a52c)
6.  [Vital non-mode-specific settings](#org438f39f)
    1.  [User information](#orge6ab4cd)
    2.  [Automatically revert unchanged files which change on the disk](#orgdb23477)
    3.  [Set what characters qualify as delimiters](#org94e31b0)
    4.  [Always use spaces instead of tabs](#org06db2a1)
    5.  [Turn off electric indent mode](#orgab691c0)
7.  [Vital modes and vital mode-specific settings](#org2b138e2)
    1.  [Org mode](#org4a2f7a0)
    2.  [Sending email: `send-mail`](#orgf307fc8)
    3.  [Reading email: `mu4e` (with isync)](#org1e63f7e)
    4.  [`agda` mode](#org49c5ef1)
8.  [Keybindings](#org86e4de9)
    1.  [`general` definers](#orgb73a9ea)
    2.  [Invoke processes](#org02007ca)
    3.  [Buffer](#orgd9f3c3b)
    4.  [Appearance](#orgf505a3c)
    5.  [Window management](#org77ae9cb)
    6.  [Tab management](#org3dbca45)
    7.  [Counsel](#org3c2dec3)
    8.  [Company](#org7ba7eb2)
    9.  [Other](#orgcc42759)
9.  [Intermediate cosmetics](#org03a680a)
    1.  [Whitespace display](#org068f41b)
    2.  [Rainbow delimiters](#org7e70fec)
    3.  [Tab-bar](#orga6f3e8c)
    4.  [A more noticable divider between windows](#orge59957c)
    5.  [Dim buffers when not in use](#org88c27fc)
    6.  [Kill the open init buffer and reopen it](#orge023140)
10. [Intermediate modes and intermediate mode-specific settings](#org05f9061)
    1.  [Org mode cosmetics](#org532499d)
    2.  [Org mode exportation settings](#orgcf5b0c8)
    3.  [A completion framework; Ivy, Counsel and Swiper](#org1e2d958)
    4.  [COMpleting ANYthing; Company](#org86c4901)
    5.  [Snippets](#orgc1eda75)
    6.  [Previewing before undoing; `undo-propose`](#orgcb44cd5)
11. [Final cosmetics](#org416e12c)
    1.  [Modeline styling](#org16f04f0)
    2.  [Flash on error](#orgb8d0764)
    3.  [Diminish minor mode names](#org89d2cfa)
    4.  [Kill the open init buffer and reopen it](#org8485938)
12. [Final modes and final mode-specific settings](#orgda3e698)
    1.  [Org mode](#orgf56919f)
    2.  [`dired`](#org56116b9)
    3.  [`eshell`](#org34a8ace)
    4.  [`which-key`](#orgf7f1355)
    5.  [`winner-mode`](#orgb2762e2)
    6.  [`windmove`](#orgcbee3c6)
    7.  [Ediff](#orgcd9a8a8)
    8.  [`magit`](#orgb38fab1)
    9.  [Purescript](#orge14d78c)
13. [Session setup](#orgd165e45)
    1.  [Filepaths](#orgb67e1ae)
    2.  [Create tabs](#org602ad44)
    3.  [Visit tabs and setup buffers](#orga9d49bd)
14. [Cleanup](#orgc9a3890)
    1.  [Check the contents of the (proper/system) init file](#org70b235c)
    2.  [Update the `README` file](#org05e3eaa)
    3.  [Prompt before quitting Emacs](#org848b85b)


<a id="orgac06626"></a>

# Introduction

This document is now in its second major version, having been
started over after it previously grew unwieldly.

This iteration focuses on a more carefully organisation of settings.
Rather than grouping settings by major mode or thematically,
they are grouped by importance.

This grouping allows me to easily reduce my settings to “bare bones”
when needed, without compromising the settings that are most important to me.
And it simplifies the “binary search” approach to debugging,
where we recursively disable roughly half the init file in order
to find the source of some bug.

For the sake of searching for settings via their “theme”,
I try to tag headings in this file.


<a id="org0f8de1f"></a>

## The file layout

-   [2](#orga9f3474)
    -   Instructions on how this file is to incorporated
        into ones Emacs init.
    -   Includes the contents of my “actual” Emacs init file,
        which carries out the incorporation of this file into my init.
-   [3](#org776dbfa)
    -   Carries out environment variable setup
        and sets up package management
        that is used to install and set up packages
        in the remainder of the document.
-   [4](#org4a7ee8d)
    -   Elisp utilities I have written which have somewhat general purpose,
        so that it is not appropriate for them to be tucked in
        with the settings for a particular package.
    -   Some of these utilities are simply waiting
        for a better longterm home.
-   [5](#orgc177521)
    -   Harmless cosmetic changes, that make the worst case of a
        crash during initialisation more comfortable.
        -   Nothing that should affect performance.
    -   Activation of my themes.
    -   Toggle some basic features. Including but not limited to:
        -   For instance, disable splash screens, menus and scroll bars,
        -   and enable line numbers and highlighting of parentheses.
-   [6](#org438f39f)
    -   Change Emacs settings that are vitally important,
        but which are not tied to a specific mode.
    -   I identify these settings as
        “will I encounter unexpected behaviour or be likely
         to make mistakes when carrying out basic tasks
         if these settings are not established?”
    -   For instance,
        -   automatically revert buffers when they've
            changed on the disk,
        -   set up proper consideration of delimiters,
        -   use spaces instead of tabs everywhere, and
        -   ensure indentation behaves correctly.
-   [7](#org2b138e2)
    -   Activate packages I use near constantly, including:
        -   Org mode,
        -   mu4e, and
        -   while I am working on my thesis at least, Agda mode.
    -   And change any settings for them that are vital.
-   [8](#org86e4de9)
    -   Set up my keybindings.
    -   At time of writing, I use [general](https://github.com/noctuid/general.el) for all of this setup.
-   [9](#org03a680a)
    -   Cosmetics which are not absolutely vital,
        but make me significantly more comfortable and at home.
    -   Or cosmetics that may be vital, but were not simple enough
        to set up to go higher, where a failure
        would have more significant repercussions.
    -   Including
        -   display of some whitespace characters,
        -   colouring of delimiters,
        -   visuals that assist with distinguish the buffer in use more.
-   [10](#org05f9061)
    -   Additional modes and additional settings for modes installed above
        which are not vital, but important.
    -   Including:
        -   The majority of settings Org mode,
            in particular cosmetic settings
            and exportation settings.
        -   Completion and snippets setup.
        -   Undo assistants setup.
-   [11](#org416e12c)
    -   Any cosmetic settings that didn't fit in above.
    -   These should be truly “just for comfort” settings.
-   [12](#orgda3e698)
    -   Any modes that didn't fit in above.
    -   In the future, this section may need to be broken up
        if the number of headings here becomes excessive.
-   [13](#orgd165e45)
    -   Code to open my starting tabs and files,
        setting up the session for me.
-   [14](#orgc9a3890)
    -   Any final tasks, including
        -   checking that the actual init file has not been tampered with,
        -   generating the README for the Emacs directory
            of my dotfiles repo automatically,
        -   and as the last action, add a prompt before
            quitting Emacs; if we reach the end of this file,
            everything has gone well and we should be ready to start work,
            so we are unlikely to want to leave Emacs anytime soon.


<a id="orga9f3474"></a>

# How to use this file

I don't like to export this file to the proper Emacs init file,
since that file may be modified by Emacs itself
or sometimes other programs.
(See below where we [3.1](#org69ad75c), which should
 avoid most modifications on Emacs' end;
 I've still had external programs feel it's appropriate
 to edit the file without my explicit permission
 (the Agda installation process in particular.))
I like to keep that file a bit bare so I can catch any changes
made to it by entities other than myself.

So instead, I create a symbolic link to this file in `~/.config/emacs/`,
then add to `~/.config/emacs/init.el`
(see <https://www.gnu.org/software/emacs/manual/html_node/emacs/Find-Init.html>
 for a discussion of the acceptable locations for the init file)
these lines:

    ;; BEGIN my edits
    
    ;; Enable editing of version controlled files through symlinks.
    ;; Usual setting is to ask, which means asking each time my init is opened
    ;; since I use a symlink to it.
    (setq vc-follow-symlinks t)
    
    ;; Delete the old tangled and compiled init file.
    ;; Shouldn't be necessary, but better safe than sorry.
    (delete-file "~/.config/emacs/emacs-init.el")
    (delete-file "~/.config/emacs/emacs-init.elc")
    
    ;; Load my init file.
    (org-babel-load-file "~/.config/emacs/emacs-init.org")
    
    ;; END my edits

In [14](#orgc9a3890) below, we check the contents of the proper Emacs init file
against the above contents,
to warn me if changes are made.
Hence why the above source block is tangled to `/tmp/init.el`.


<a id="org776dbfa"></a>

# Environment setup and package management

Before we really begin, we ensure environment settings are correct
and setup `use-package` as a package manager.


<a id="org69ad75c"></a>

## Set a “custom” file

Emacs will, by default, insert all sorts of “custom” settings
into our actual init file
(`~/.emacs`, `/.emacs.el`, `./emacs.d/init.el`, or `/.config/emacs/init.el`;
 see <https://www.gnu.org/software/emacs/manual/html_node/emacs/Find-Init.html>)
especially those set via GUIs.

In order to avoid polluting that file, let's set it to use
a particular one. In fact, let's put it under my version control,
so I will be more able to notice changes to it.

    (setq custom-file "~/dotfiles/emacs/custom.el")
    (ignore-errors (load custom-file))


<a id="orgbc4b1b9"></a>

## Basic package management

`package` gives us the basic tools to add packages from repositories
to Emacs.

    (require 'package)

We will shortly setup a package manager to ease installation of packages.


<a id="orgf255c52"></a>

## Set package repositories

By default, the only package repository is the ELPA repo.
See the list of packages contained therein [here](http://elpa.gnu.org/packages/).

Here we add the MELPA repo and the NonGNU repo,
then refresh to get the latest contents.

    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
    (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
    (package-initialize)
    (package-refresh-contents)

If needed, we can set `package-archive-priorities`
to set the priority for these repositories.

Older versions of Org and the “Org+Contrib” package were hosted at
<http://orgmode.org/elpa/>,
but after Org 9.5, they are no longer distributed there.
Now Org is best available though GNU ELPA, and there is a new
“Org-Contrib” package available through NonGNU ELPA
(the + was dropped from the name.)


<a id="orgbd3ea64"></a>

## A package manager – `use-package`

The `use-package` package provides an easy-to-use interface
to install and customise packages.

I generally use it just to avoid having to `package-install` packages
whenever I migrate systems.
I haven't properly learned how to customise packages using it;
generally I just write my customisations as plain Elisp
after the `use-package` invocation to install them.
Where you see me use `use-package` to apply customisations,
I have probably copied someone else's initialisation.

Unless it's already installed, update the packages archives,
then install the most recent version of “use-package”.

    (unless (package-installed-p 'use-package)
      (package-refresh-contents)
      (package-install 'use-package))
    
    (require 'use-package)

I always want to download packages that aren't installed.

    (setq use-package-always-ensure t)


<a id="org1c2d181"></a>

## Update packages

For the moment, I use the `auto-package-update` to automatically update
packages for me.

    (use-package auto-package-update
      :config
      ;; Delete residual old versions
      (setq auto-package-update-delete-old-versions t)
      ;; Do not bother me when updates have taken place.
      (setq auto-package-update-hide-results t)
      ;; Update installed packages at startup if there is an update pending.
      (auto-package-update-maybe))


<a id="orgf15ff42"></a>

## Make sure we have the right PATH

See <https://github.com/purcell/exec-path-from-shell>

    (use-package exec-path-from-shell)
    (when (memq window-system '(mac ns x))
      (exec-path-from-shell-initialize))


<a id="org0b4e5b8"></a>

## Set a directory for non-package manager managed Elisp files

This directory is for Elisp files I develop myself
or that I download without use of a package manager.

This form is used, instead of `add-to-load-path`,
so that subdirectories are searched.
See <https://www.emacswiki.org/emacs/LoadPath>
This is useful so that git repositories can be added here
as subtrees in this directory, and the `.el` files will be picked up.

    (let ((default-directory "~/dotfiles/emacs/elisp"))
      (normal-top-level-add-subdirs-to-load-path))


<a id="orgdc9eb14"></a>

## Elisp utilities

These utility packages simplify many families of tasks.

`s` is for `s`-tring management.

    (use-package s)

`f` is for `f`-ile management.

    (use-package f)


<a id="org4a7ee8d"></a>

# Custom Elisp

Some of this code may be moved to separate files later,
but it's small and collected here for now.


<a id="org2dcffca"></a>

## Toggle themes

These functions allow me to clear and toggle my themes.

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
        most-recent-theme))
    
    (defun toggle-my-themes ()
      "Disable all custom, then try to toggle the themes
       my-dark-theme and my-light-theme, in that if one was
       the last applied theme, the other will be applied.
    
       If neither was the last applied theme, my-dark-theme
       will be applied as a default.
      "
    
      (let ((most-recent-theme (disable-all-custom-themes)))
        (if (eq most-recent-theme my/dark-theme)
            (load-theme my/light-theme t)
            (load-theme my/dark-theme t))))


<a id="org05e4aba"></a>

## Theme change hook

[Apparently](https://www.reddit.com/r/emacs/comments/4v7tcj/),
there is no hook in Emacs for when a theme change occurs.
This code snippet, taken from the linked reddit post, defines one I can use.

    (defvar after-load-theme-hook nil
      "Hook run after a color theme is loaded using `load-theme'.")
    (defadvice load-theme (after run-after-load-theme-hook activate)
      "Run `after-load-theme-hook'."
      (run-hooks 'after-load-theme-hook))


<a id="org205cbba"></a>

## Cascading window setup

I set up my default desktop using a “cascading pattern”,
moving from larger windows in the upper right to
smaller windows in the lower left.

This works best with 2 or 3 windows, but it can be used for more.

The process is:

-   If there are two or more files left to open:
    -   Create a new window to the left.
    -   Open the next file.
    -   Move the focus to the left.
    -   If there are two or more files left to open:
        -   Create a new window below.
        -   Open the next file.
        -   Move focus down.
-   Else if there is one file left to open,
    open it.
-   Else, quit.

    (defun cascading-find-files (files)
      "Opens a set of files in a cascading series of windows,
    created by splitting the current window.
    The windows begin in the upper right, with the first file,
    and move left and then down, each window being half the size
    of the previous (as long as this is possible)."
      (while files ;; there's at least one file to open
        (find-file (car files))
        (setq files (cdr files))
        (when files ;; there are two or more files
          (split-window nil nil 'left)
          (other-window 1)
          (find-file (car files)) ;; open second file on the left
          (setq files  (cdr files))
          (when files ;; there are still more files, so split horizontally
            (split-window nil nil 'below)
            (other-window 1)))))

:TODO: Create a alternate method for vertical screens, preferably also allowing on-the-fly switching between the two setups.


<a id="org7a4a93e"></a>

## Killing a buffer when its associated process finishes

When starting an asynchronous process using `async-shell-command`,
a buffer is created and brought into focus in another window
to show the output of the command.

We can use `start-process` or other functions to start
asynchronous processes without bringing into display,
if that's desired. Instead of that though,
I often want to see the output,
but don't want the buffer to remain once the process
has finished.

This function can be assigned to a sentinel for a process
to kill its associated buffer when the process finishes.

    (defun kill-buffer-on-process-finish (process signal)
      (when (memq (process-status process) '(exit signal))
        (kill-buffer (process-buffer process))
        (shell-command-sentinel process signal)))


<a id="orgc177521"></a>

# Simple cosmetics


<a id="org1ba1756"></a>

## First: disable the splashscreen and find the my emacs init file

This way, if something goes wrong below, I am positioned to fix it
right away.

    (setq inhibit-splash-screen t)
    (setq my/emacs-init-file "~/.config/emacs/emacs-init.org")
    (find-file my/emacs-init-file)

This file will be closed and re-opened below, to ensure
all cosmetic changes show correctly.


<a id="org4118bd5"></a>

## Disable unnecessary interface elements

I don't use the menubar, toolbar (icons usually below the menu),
or scroll bars.

    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)


<a id="org2dba6f5"></a>

## Fonts

I like the Cousine font, and usually use a small 11in screen,
and so use a small font; 9pt seems to be a sweet spot.

    (add-to-list 'default-frame-alist
                 '(font . "Cousine-9"))


<a id="orgb5ad1e2"></a>

## Line and column information


### Line numbers

As of Emacs 26, `display-line-numbers-mode` is the “proper”
way to display line numbers next to a buffer.
(Before 26, `linum-mode` was the usual method.)

    (add-hook 'text-mode-hook 'display-line-numbers-mode)
    (add-hook 'prog-mode-hook 'display-line-numbers-mode)

Line numbers are distruptive in some other modes,
hence why set them to show only in `text-mode` and `prog-mode` above.
To enable them globally, one would use `global-display-line-numbers-mode`.

I find it concerning when the width of the column
used for line numbers grows throughout the document;
it makes me think Org mode headlines further down are nested.
Setting `display-line-numbers-width-start` causes the system
to count the number of lines when opening a buffer, and
set the minimum width necessary to display all line numbers.
It wastes some screen space, but is good for my sanity.

    (setq display-line-numbers-width-start t)


### Fill column display

Traditionally, it's good style to keep lines under 80 characters wide.
I follow this tradition (though recently some argue the amount should be increased.)

The (as of Emacs 27) built in `display-fill-column-indicator-mode` puts a ruler,
by default at 70 characters.

    (global-display-fill-column-indicator-mode t)

Note that with `org-indent-mode`, the ruler will be off
by the length of the indentation (i.e. it will be
at line 68 if indented 2 characters, 66 if indented 4, etc).
That's okay; the ruler is there as a reminder more than a firm guideline.

Prior to Emacs 27, `fci-mode` could be used for this purpose,
but I found it to cause noticable lag.
Using `whitespace-mode` to highlight lines exceeding a certain number
of characters was my preferred approach at that time.


<a id="org9069ed7"></a>

## Themes

I use Protesilaos Stavrou's [Modus themes](https://protesilaos.com/modus-themes/), which
“[conform] with the highest standard for colour contrast
 between background and foreground values”. 
Prior to this I used the `vibrant` and `nord-light` themes
from [doom-themes](https://github.com/hlissner/emacs-doom-themes), but the Modus don't leave me desiring any other themes.

    (use-package modus-themes)

By default, I prefer the dark `modus-vivendi`,
but like to toggle between it and the light `modus-operandi` at need.

    (setq my/dark-theme 'modus-vivendi)
    (setq my/light-theme 'modus-operandi)
    
    (load-theme my/dark-theme t)


<a id="org5a75684"></a>

## Highlight matching delimters


### Highlight matching delimiters

It's useful to highlight the matching delimiter when the cursor
is on its match, especially when coding in Lisps.

    (show-paren-mode 1)

Since I use `rainbow-delimiters` (setup below) it's actually distinctive
to colour the matching delimiter in plain white,
rather than the default red.
In case we're in a light theme though, set the background
to be black.

    (custom-theme-set-faces
     'user
     '(show-paren-match ((t (:foreground "white"
                             :background "black"
                             :weight ultra-bold)))))


<a id="orgb32a52c"></a>

## Kill the open init buffer and reopen it

To ensure all these cosmetic changes are picked up,
kill my init buffer that we opened earlier and reopen it.

    (kill-buffer "emacs-init.org")
    (find-file my/emacs-init-file)


<a id="org438f39f"></a>

# Vital non-mode-specific settings


<a id="orge6ab4cd"></a>

## User information

    (setq user-full-name "Mark Armstrong")
    (setq user-mail-address "markparmstrong@gmail.com")


<a id="orgdb23477"></a>

## Automatically revert unchanged files which change on the disk

Ideally this helps us avoid conflicts, in case I edit open files elsewhere.
Note reverting will not take place if there are unsaved changes,
so this is relatively safe.

    (global-auto-revert-mode t)

I do use automatic syncing tools and sometimes work on other systems;
conflicts can still happen if one system is offline or the syncing
gets behind some other way, but with automatic reverts
it's less likely I trip over my own changes.


<a id="org94e31b0"></a>

## Set what characters qualify as delimiters


### Angle brackets are not delimiters to me

First, don't treat angle brackets as delimiters; even when writing
HTML or XML, I don't want them to qualify as delimiters for
the purpose of `show-paren-mode`, `check-paren` and `rainbow-delimiters`.
Treat them as symbols instead (this is the meaning of `_` in the
syntax table).

    (defun my/<>-symbol-syntax ()
      (modify-syntax-entry ?> "_")
      (modify-syntax-entry ?< "_"))

`modify-syntax-table` works on the current buffer
(unless given a buffer as optional argument)
and so we need to apply those modifications in each buffer.

    (add-hook 'org-mode-hook 'my/<>-symbol-syntax)
    (add-hook 'prog-mode-hook 'my/<>-symbol-syntax)
    (add-hook 'text-mode-hook 'my/<>-symbol-syntax)

The `org-mode` function modifies the entries when run,
and `yankpad` runs it regularly (albeit in a temporary buffer,
but the modification “leaks”), so we need to undo those
modifications.

    (defadvice org-mode (after override-<>-syntax activate)
      (my/<>-symbol-syntax))

Side note: I'm honestly uncertain if the “leaking” of
the syntax entry modifications from temporary buffers is a bug.
It's likely just unintuitive behaviour.
It can be observed easily; just modify the entry for i.e. `<`,

and evaluate

    (with-temp-buffer
      (org-mode))

and observe your modifications are undone.


### These unicode characters are delimiters

Do treat these unicode symbols as delimiters.
The first character in each entry means either

-   “open delimiter”, if it's a `(`, or
-   “close delimiter”, if it's a `)`.

The second symbol designates the matching delimiter. 

    (defun my/unicode-delimiter-syntax ()
      (modify-syntax-entry (string-to-char "⟨") "(⟩")
      (modify-syntax-entry (string-to-char "⟩") ")⟨")
      (modify-syntax-entry (string-to-char "⟪") "(⟫")
      (modify-syntax-entry (string-to-char "⟫") ")⟪")
      (modify-syntax-entry (string-to-char "⟦") "(⟧")
      (modify-syntax-entry (string-to-char "⟧") ")⟦")
      (modify-syntax-entry (string-to-char "⁅") "(⁆")
      (modify-syntax-entry (string-to-char "⁆") ")⁅")
      (modify-syntax-entry (string-to-char "｛") "(｝")
      (modify-syntax-entry (string-to-char "｝") ")｛")
      (modify-syntax-entry (string-to-char "“") "(”")
      (modify-syntax-entry (string-to-char "”") ")“"))

Apply those syntax entry modifications.

    (add-hook 'prog-mode-hook 'my/unicode-delimiter-syntax)
    (add-hook 'text-mode-hook 'my/unicode-delimiter-syntax)


<a id="org06db2a1"></a>

## Always use spaces instead of tabs

    (setq-default indent-tabs-mode nil)


<a id="orgab691c0"></a>

## Turn off electric indent mode

I don't use this or appreciate its interference.

    (electric-indent-mode -1)


<a id="org2b138e2"></a>

# Vital modes and vital mode-specific settings


<a id="org4a2f7a0"></a>

## Org mode


### Preamble

I use Org for almost everything, and utilise many
of the extras included in `org-contrib` (previously `org-plus-contrib`.)

    (use-package org
      :ensure org-contrib
      :config
      (require 'ox-extra))


### Literate programming

:TODO: Check over the Org literate programming section.

1.  Execution

    By default, Emacs will query whether we *actually* want to
    execute code when we evaluate a code block. Also, it seems to
    just *not* execute code marked for execution during export in an
    `org` file. So, I remove the safety.
    
        (setq org-confirm-babel-evaluate nil)
    
    By default only emacs lisp can be evaluated.
    Documentation [here](https://orgmode.org/manual/Languages.html).
    
    These languages have support built-in, it just has to be activated.
    
        (require 'ob-shell)
        (require 'ob-haskell)
        (require 'ob-latex)
        (require 'ob-C)
        (require 'ob-ruby)
        (require 'ob-plantuml)
        (require 'ob-R)
        (require 'ob-ditaa)
        (require 'ob-scheme)
        (require 'ob-dot)
        (require 'ob-python)
        (require 'ob-js)
        (require 'ob-clojure)
    
        (setq org-ditaa-jar-path "/usr/bin/ditaa")
    
    For shell code, we need to initialise via this function.
    See [here](https://emacs.stackexchange.com/questions/37692/how-to-fix-symbols-function-definition-is-void-org-babel-get-header).
    
        (org-babel-shell-initialize)
    
    PlantUML requires we set the path to the `.jar` file.
    
        (setq org-plantuml-jar-path "/usr/share/java/plantuml.jar")
    
    `ob-typescript` is [available](https://github.com/lurdan/ob-typescript).
    
        (use-package ob-typescript)
    
    `ob-ammonite` interacts with the `ammonite` REPL for `scala`.
    
        (use-package ob-ammonite)
    
    Note that the `scala` source blocks are marked as `amm` source,
    not actually `scala`. See
    [the documentation](https://github.com/zwild/ob-ammonite).
    
    This is not the right place to dump this,
    but this code should cause the `amm` blocks to export as `scala` blocks
    in LaTeX so `minted` knows how to handle them.
    This code inspired by a similar problem solved on
    [StackExchange](https://emacs.stackexchange.com/a/19941).
    
        (defun my/ammonite-src-to-scala-src (text backend info)
          "Translate Ammonite minted blocks resulting from LaTeX export
        to Scala minted blocks."
          (when (org-export-derived-backend-p backend 'latex)
            (with-temp-buffer
              (insert text)
              (goto-char (point-min))
              (replace-regexp "\\(\\\\begin{minted}.*\\){amm}" "\\1{scala}")
              (buffer-substring-no-properties (point-min) (point-max)))))
        
        (add-hook 'org-export-filter-src-block-functions 'my/ammonite-src-to-scala-src)
    
        (setq org-babel-clojure-backend 'cider)
        (use-package cider)
        (setq cider-default-repl-command "lein")

2.  Editing source code

    When I choose to edit a source block in a separate buffer,
    that source block becomes my main focus.
    So, open a new frame (OS window) in which to edit.
    Then I can open other material, help buffers, etc.,
    without disturbing the window setup around my Org window.
    When I finish editing, that frame is killed.
    
        (setq org-src-window-setup 'other-frame)
    
    Note, I didn't think I would like the `other-frame` option
    at all at first, but it grew on me when I realised
    it was the best way to ensure that editing source blocks in
    a separate buffer would not mess up my window layout
    —which `other-window` fails to do—
    give me the option at least to keep the Org buffer visible
    —which `current-window` of course disables—
    and give me enough room for the source buffer
    —which `split-window-below` and `split-window-right` fail to do
    on small screens.
    
    When we open a new window to edit source blocks
    the major mode of that window is determined by
    the setting for the language in `org-src-lang-modes`.
    Override the setting in that attribute list if you wish to
    change the major mode for a particular language.
    
    It's convenient to have `<tab>` act as it would in the source language
    when editing code blocks in the Org buffer.
    However, for some reason I have found this irritating
    and disabled it.
    
        ;;(setq org-src-tab-acts-natively t)
    
    :TODO:
    
        (setq org-src-fontify-natively t)


### Reveal hidden elements if they are edited

Folding a document raises the possibility of accidentally editing
hidden portions. Org provides a way to defend against this:
On making an “invisible” edit, the hidden portion will be unfolded
so the edit can be seen.

    (setq org-catch-invisible-edits 'show)


<a id="orgf307fc8"></a>

## Sending email: `send-mail`

:TODO: Check for cleanup of send-mail settings.

    (setq mail-user-agent 'mu4e-user-agent)

Whether or not you use Emacs to read your email,
you can use it to send emails with the builtin `send-mail`.
It can be configured to use your OS default for sending email
(for instance, through a mail program or browser),
or configured to send mail itself (for instance via SMTP).
For convenience, I choose the latter.

I use Gmail exclusively, so the setup is small.

    (require 'smtpmail)
    
    (setq message-send-mail-function 'smtpmail-send-it
       starttls-use-gnutls t
       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
       smtpmail-auth-credentials
         '(("smtp.gmail.com" 587 "markparmstrong@gmail.com" nil))
       smtpmail-default-smtp-server "smtp.gmail.com"
       smtpmail-smtp-server "smtp.gmail.com"
       smtpmail-smtp-service 587)

    (require 'auth-source)
    (setq auth-sources '((:source "~/.authinfo.gpg")))

If needed, we can create a queue to allow for sending of email
while offline. See
[the documentation](https://www.gnu.org/software/emacs/manual/html_node/smtpmail/Queued-delivery.html).

    ;;(setq smtpmail-queue-mail nil)

After sending an email, kill the buffer.

    (setq message-kill-buffer-on-exit t)


<a id="org1e63f7e"></a>

## Reading email: `mu4e` (with isync)

:TODO: Check for cleanup of mu4e settings.

Using Emacs as an email client provides us with powerful text editing
while composing email.

I initially followed the guide
[from this reddit post](https://www.reddit.com/r/emacs/comments/bfsck6/mu4e_for_dummies/)
to set it up, but I've customised things heavily at this point.

    (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
    (require 'mu4e)

Run `mu` in debug mode, so if something fails we get more information.

    (setq mu4e-mu-debug t)


### Basic setup

1.  The mail directories

    `mu4e` needs to know where my mail directory lives,
    and the paths of certain important mailboxes relative to that.
    Note that there should be an archive box here, but I don't make
    use of an archive mailbox.
    
        (setq
          mu4e-drafts-folder "/Drafts"
          mu4e-sent-folder   "/Sent Mail"
          mu4e-trash-folder  "/Trash")
    
    Previously I would set `mu4e-maildir` here;
    that is no longer a variable in new versions of `mu4e`.
    Instead the mail directory is taken from `mu`;
    set it with with, e.g., `mu init --maildir=~/.mail/gmail`.
    (Note: it may also be necessary to set the `--my-address` flag;
     I'm not certain.)
    You can check the setting with
    
        (mu4e-root-maildir)

2.  Get mail command

    I use isync (whose executable is called `mbsync`) to manage
    my local mail directory.
    
    I have two groups set up in my `mbsyncrc`; one smaller group
    of my most important Gmail labels
    which synchronises with the remote quickly,
    and a larger group of the remaining labels which takes
    a fair chunk of time to synchronise.
    The `mu4e` get mail command uses the former, to ensure
    it does not take an excessive amount of time when I manually run it.
    
        (setq
          mu4e-get-mail-command "mbsync gmail-quick"
          mu4e-update-interval 300 ;; 5 minutes
          mu4e-headers-auto-update t)
    
    Don't take over the minibuffer with a status notification
    when indexing messages.
    If something's going wrong, flip this setting
    as a first step in the diagnosis.
    
        (setq mu4e-hide-index-messages t)
    
    :TODO: Is background updating working again?

3.  Change file names when moving emails

    To work nicely with `mbsync`, we should
    change the file name when moving mail between mail directories;
    otherwise the UID portion of the name becomes stale
    and possibly causes issues such as duplicate UIDs
    or UIDs out of range.
    
        (setq mu4e-change-filenames-when-moving t)


### Viewing emails

1.  Email list

    This controls the information shown in the email lists.
    
    -   `:human-date` will show the time if the email was sent today
        (the alternative, `:date`, would not).
    -   `:from-or-to` is a special field that will show the sender if it was not me;
        otherwise it will show the recipient.
    
        (setq mu4e-headers-fields
          '( (:date       . 22)
             (:flags      . 4)
             (:from-or-to . 22)
             (:subject    . nil)))
    
        (setq mu4e-headers-date-format "%d %b/%y, %a, %R")
    
    Don't organise by threads; I find organising by date preferable.
    
        (setq mu4e-headers-show-threads nil)
    
    This can be toggled with `P` in the email list.
    
    By default, related mail is also included; for instance,
    if I reply to a message in a list, the reply will show up in the list.
    I find this unintuitive, especially since I don't organise by threads.
    
        (setq mu4e-headers-include-related nil)

2.  Individual mail

    Show images by default, and prefer to use `imagemagick` to do so.
    
        (setq mu4e-view-show-images t)
        
        (when (fboundp 'imagemagick-register-types)
          (imagemagick-register-types))
    
    Attachments can simply be placed in `~/Downloads`;
    I usually share this directory from ChromeOS, which makes it convenient
    to put attachments there (so I can open them in both OSes easily).
    
        (setq mu4e-attachment-dir  "~/Downloads")
    
    Show full email addresses when viewing messages.
    
        (setq mu4e-view-show-addresses 't)

3.  HTML support

    Emacs is not the ideal environment to read HTML emails;
    for that reason, if there is a plaintext version available,
    I prefer to see that first.
    
        (setq mu4e-view-prefer-html nil)
    
    If there is no plaintext available, or if the plaintext is unbearable
    for any reason, we can open emails in the browser by using
    this shortcut.
    
        (add-to-list 'mu4e-view-actions
          '("ViewInBrowser" . mu4e-action-view-in-browser) t)


### Shortcuts to mailboxes and bookmarks

    (setq mu4e-maildir-shortcuts
        '(("/Inbox"     . ?i)
          ("/Sent Mail" . ?s)
          ("/Desk/Followup"  . ?f)
          ("/Desk/Reference" . ?r)
          ("/Desk/Transient" . ?t)))

Bookmarks can be used from the `mu4e` main page,
and are also useful for programmatically jumping to maildirs.

    (add-to-list 'mu4e-bookmarks
      (make-mu4e-bookmark
        :name  "Inbox"
        :query "maildir:/Inbox"
        :key ?i))


### `mu4e-maildirs-extension`

The package `mu4e-maildirs-extension` causes the display of
the read/total count for each mail directory in the list.

    (use-package mu4e-maildirs-extension)
    
    (mu4e-maildirs-extension)


### Message composition settings

I don't use a signature.

    (setq mu4e-compose-signature-auto-include nil)

Don't automatically insert line breaks for long lines
in the message buffer! Such settings infuriate me.

    (add-hook 'mu4e-compose-mode-hook 'turn-off-auto-fill)

1.  Contacts

    I've had problems where contact completion breaks.
    For the moment, I make sure that the contacts are requested
    from `mu` upon starting Emacs.
    This function in particular was undefined on one of my systems,
    so first check it is defined as a function.
    
        (when (fboundp 'mu4e~request-contacts)
          (mu4e~request-contacts))
    
    Note that the contacts are stored in a hash table,
    and so I am unsure of how to actually see them in Emacs.

2.  Flow

    I write emails the way I write all my documents:
    trying as best I can to respect a maximum line length of 80 characters.
    But even 80 characters can be too wide on some mobile screens,
    and when I enter my linebreaks, the receiving client may turn this
    
        A line with a number of characters that is possibly too wide for mobile.
        Another line of a decent length.
    
    into this
    
        A line with a number of characters that is possibly
        too wide for mobile.
        Another line of a decent length.
    
    One option to solve seems to be to use long paragraphs and to
    send messages with `format=flowed`, which tells the receiving client
    to reflow paragraphs as needed.
    See for instance <https://www.emacswiki.org/emacs/FormatFlowed>.
    But this has two downsides: I dislike writing long lines,
    even with autofill.
    And `format=flowed` is not supported consistently;
    for instance Gmail does not respect it.
    
    I don't have a solution for this potential problem yet,
    so I choose to do nothing,
    and potentially have my emails flow broken on mobile screens.

3.  HTML support (nothing to see here)

    Note that there is a `org-mu4e` package that comes with `mu4e`,
    which would allow for sending HTML email using `mu4e`,
    but it is apparently depricated.
    The `org-mime` package above is probably the correct path
    if I ever want to send HTML emails.

4.  Changing the `From` address automatically

    I use my personal Gmail to collect all of my emails,
    but when replying I like to send back from whichever
    account the original mail was sent to.
    This hook updates the `From` field when replying to
    an email sent to one of my other accounts.
    It is taken from [the `mu4e` documentation](https://www.djcbsoftware.nl/code/mu/mu4e/Compose-hooks.html#Compose-hooks),
    with a modification to save the existing `user-mail-address` so
    that it can be reset afterwards.
    
        (add-hook 'mu4e-compose-pre-hook
          (defun my/set-from-address ()
            "Set the From address based on the To address of the original."
            (let ((msg mu4e-compose-parent-message))
              (when msg
                (setq my/user-mail-address-backup user-mail-address)
                (setq user-mail-address
                  (cond
                     ((mu4e-message-contact-field-matches msg :to "armstmp@mcmaster.ca")
                       "armstmp@mcmaster.ca")
                     ((mu4e-message-contact-field-matches msg :cc "armstmp@mcmaster.ca")
                       "armstmp@mcmaster.ca")
                     (t
                       "markparmstrong@gmail.com")))))))
    
    The `mu4e-compose-mode-hook` runs
    after the message has been formed.
    So we are safe to restore the original `user-mail-address`.
    
        (add-hook 'mu4e-compose-mode-hook
          (defun my/restore-user-mail-address ()
            "Restore the user-mail-address based on the value
             in my/user-mail-address-backup."
            (when my/user-mail-address-backup
               (setq user-mail-address my/user-mail-address-backup))))


### Miscellaneous

Don't prompt me upon quitting `mu4e`.

    (setq mu4e-confirm-quit nil)


### Start up `mu4e` so `mu` is running

We start `mu4e` here in case, for instance,
we use a bookmark to open a `mu4e` buffer
before we've started `mu4e` correctly.
Without this, we might get an error asking if we started `mu4e.`
(In particular, I was encountering a `root maildir unknown` error.)

    (mu4e)


<a id="org49c5ef1"></a>

## `agda` mode

:TODO: Check for cleanup of Agda settings.

Agda comes with a tool `agda-mode` which can be used to locate
the Elisp files for the `agda-mode`. It's recommended we
execute `agda-mode locate` when starting Emacs,
and load the files it reports.

    (load-file (let ((coding-system-for-read 'utf-8))
                   (shell-command-to-string "agda-mode locate")))

These packages are installed when setting up Agda,
so I simply `require` them.
They would be loaded when starting Agda mode,
but I need to load them now

-   because I use `agda2-info-buffer` to open that buffer on startup,
-   because I use `agda-input` everywhere, and

    (require 'agda2-mode)
    (require 'agda-input)


### Command line arguments

Dr. Wolfram Kahl has recommended customising the following settings.
Note that my machine is a virtual machine running on a Chromebook
which, at time of writing (January 2020) has around `6G` (out of
the system's total `8G`) available to it.

That said, my machine is routinely lagging quite badly,
and so I am trying to find the “sweet spot”.

    (setq agda2-program-args '("+RTS" "-M3.0G" "-H0.6G" "-A128M" "-RTS"))

These arguments specify

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left"><code>+RTS</code>, <code>-RTS</code></td>
<td class="org-left">Flags between these are arguments to the <code>ghc</code> runtime</td>
</tr>


<tr>
<td class="org-left"><code>-M[size]</code></td>
<td class="org-left">Maximum heap size</td>
</tr>


<tr>
<td class="org-left"><code>-H[size]</code></td>
<td class="org-left">Suggested heap size</td>
</tr>


<tr>
<td class="org-left"><code>-A[size]</code></td>
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
<td class="org-left"><code>-S[file]</code></td>
<td class="org-left">Produces information about “each and every garbage collection”</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">- Outputs to <code>stderr</code> by default</td>
</tr>
</tbody>
</table>


### Alternative problem highlighting

I find the background colouring used by Agda for reporting
errors/warnings makes the underlying code too difficult
to read, especially in dark themes.

So I modify the faces Agda defines.

    (require 'agda2-highlight)

First, we change all uses of background colouring to coloured boxes
instead.

    ;; Change backgrounds to boxes.
    (cl-loop for (_ . face) in agda2-highlight-faces
          do (if (string-prefix-p "agda2-" (symbol-name face)) ;; Some non-Agda faces are in the list; don't change them
                 (unless (equal face 'agda2-highlight-incomplete-pattern-face) ;; Workaround; this face is not defined in recent versions?
                 (set-face-attribute face nil
                   :box (face-attribute face :background)
                   :background 'unspecified))))

These can also be intrusive in some cases; specifically, for
warnings about pattern matching. So I modify them specifically.

    ;; Coverage warnings highlight the whole function;
    ;; change the box to an underline to be less intrusive.
    (set-face-attribute 'agda2-highlight-coverage-problem-face nil
      :underline (face-attribute 'agda2-highlight-coverage-problem-face :box)
      :box 'unspecified)
    
    ;; Deadcode warnings highlight the whole line;
    ;; change the box to a strikethrough to be less intrusive,
    ;; as well as thematically appropriate.
    (set-face-attribute 'agda2-highlight-deadcode-face nil
      :strike-through (face-attribute 'agda2-highlight-deadcode-face :box)
      :box 'unspecified)
    
    ;; Non-definitional pattern matching may be ignored;
    ;; remove the colouring and just italicise it to be less intrusive.
    (set-face-attribute 'agda2-highlight-catchall-clause-face nil
      :box 'unspecified
      :slant 'italic)

This code can be used to test out many of the redefined faces.

    module HighlightTesting where
      open import Data.Nat using (ℕ ; zero ; suc)
    
      -- Coverage problem, non-definitional pattern matching, dead code.
      bad-pattern-matching : ℕ → ℕ
    --bad-pattern-matching suc n   Missing case; other lines marked with coverage problem face
      bad-pattern-matching 0 = 0
      bad-pattern-matching (suc (suc 0)) = 0
      bad-pattern-matching (suc (suc n)) = 0 -- Non-definitional case (maybe use CATCHALL pragma?).
      bad-pattern-matching 0 = 0 -- Dead code.
    
      -- Non-terminating
      ∞? : ℕ
      ∞? = suc ∞?
    
      -- Unsolved meta warnings
      fail-to-solve-meta : ℕ
      fail-to-solve-meta = has-a-meta
        where
          has-a-meta : {n : ℕ} → ℕ
          has-a-meta = 0
    
      -- Shadowing in telescope
      shadowing-variable : (x : ℕ) → (x : ℕ) → ℕ
      shadowing-variable x y = x
    
      -- Missing function definition
      has-no-definition : Set
    
      data unpositive-type : Set where
        bad : (unpositive-type → ℕ) → unpositive-type


### Add unicode characters to Agda's translations

1.  Punctuation and parentheses

        (add-to-list 'agda-input-user-translations '(";;" "﹔"))
        (add-to-list 'agda-input-user-translations '(";;" "⨾"))
        (add-to-list 'agda-input-user-translations '("|" "❙"))
        (add-to-list 'agda-input-user-translations '("st" "•"))
        (add-to-list 'agda-input-user-translations '("{" "｛"))
        (add-to-list 'agda-input-user-translations '("}" "｝"))
        (add-to-list 'agda-input-user-translations '("{" "⁅"))
        (add-to-list 'agda-input-user-translations '("}" "⁆"))
        (add-to-list 'agda-input-user-translations '("..." "…"))

2.  Arrows

        (add-to-list 'agda-input-user-translations '("pto" "⇀"))
        (add-to-list 'agda-input-user-translations '("into" "↪"))
        (add-to-list 'agda-input-user-translations '("onto" "↠"))
        (add-to-list 'agda-input-user-translations '("conv" "↓"))
        (add-to-list 'agda-input-user-translations '("=v" "⇓"))
        (add-to-list 'agda-input-user-translations '("eval" "⇓"))

3.  Correct mistakes on subscripts/superscripts

    I often accidentally hold the shift key for too long when entering
    subscripts and superscripts; these translations account for that.
    
        (add-to-list 'agda-input-user-translations '("^!" "¹"))
        (add-to-list 'agda-input-user-translations '("^@" "²"))
        (add-to-list 'agda-input-user-translations '("^#" "³"))
        (add-to-list 'agda-input-user-translations '("^$" "⁴"))
        (add-to-list 'agda-input-user-translations '("^%" "⁵"))
        (add-to-list 'agda-input-user-translations '("^^" "⁶"))
        (add-to-list 'agda-input-user-translations '("^&" "⁷"))
        (add-to-list 'agda-input-user-translations '("^*" "⁸"))
        (add-to-list 'agda-input-user-translations '("^(" "⁹"))
        (add-to-list 'agda-input-user-translations '("^)" "⁰"))
        (add-to-list 'agda-input-user-translations '("_!" "₁"))
        (add-to-list 'agda-input-user-translations '("_@" "₂"))
        (add-to-list 'agda-input-user-translations '("_#" "₃"))
        (add-to-list 'agda-input-user-translations '("_$" "₄"))
        (add-to-list 'agda-input-user-translations '("_%" "₅"))
        (add-to-list 'agda-input-user-translations '("_^" "₆"))
        (add-to-list 'agda-input-user-translations '("_&" "₇"))
        (add-to-list 'agda-input-user-translations '("_*" "₈"))
        (add-to-list 'agda-input-user-translations '("_(" "₉"))
        (add-to-list 'agda-input-user-translations '("_)" "₀"))

4.  Emoticons

        (add-to-list 'agda-input-user-translations '(":)" "😀"))
        (add-to-list 'agda-input-user-translations '("grin" "😀"))
        (add-to-list 'agda-input-user-translations '("Grin" "😁"))
        (add-to-list 'agda-input-user-translations '("meh" "😐"))
        (add-to-list 'agda-input-user-translations '("sad" "🙁"))
        (add-to-list 'agda-input-user-translations '("gah" "😵"))
        (add-to-list 'agda-input-user-translations '("yes" "✔"))
        (add-to-list 'agda-input-user-translations '("no" "❌"))
    
    😀 😁 😐 🙁 😵

5.  Better access to prime symbols

        (add-to-list 'agda-input-user-translations '("''" "″"))
        (add-to-list 'agda-input-user-translations '("'''" "‴"))
        (add-to-list 'agda-input-user-translations '("''''" "⁗"))

6.  Small, halfwidth and fullwidth math symbols

    These can be useful where use of the normal symbols
    is restricted; for instance, in `ditaa` diagrams many
    of them have special meaning.
    
        (add-to-list 'agda-input-user-translations '("s*" "﹡"))
        (add-to-list 'agda-input-user-translations '("s+" "﹢"))
        (add-to-list 'agda-input-user-translations '("s-" "﹣"))
        (add-to-list 'agda-input-user-translations '("s<" "﹤"))
        (add-to-list 'agda-input-user-translations '("s>" "﹥"))
        (add-to-list 'agda-input-user-translations '("s=" "﹦"))
        (add-to-list 'agda-input-user-translations '("s\\" "﹨"))
        (add-to-list 'agda-input-user-translations '("f+" "＋"))
        (add-to-list 'agda-input-user-translations '("f<" "＜"))
        (add-to-list 'agda-input-user-translations '("f=" "＝"))
        (add-to-list 'agda-input-user-translations '("f>" "＞"))
        (add-to-list 'agda-input-user-translations '("f\\" "＼"))
        (add-to-list 'agda-input-user-translations '("f^" "＾"))
        (add-to-list 'agda-input-user-translations '("f|" "｜"))
        (add-to-list 'agda-input-user-translations '("f~" "～"))
        (add-to-list 'agda-input-user-translations '("fnot" "￢"))
        (add-to-list 'agda-input-user-translations '("h<-" "￩"))
        (add-to-list 'agda-input-user-translations '("hu" "￪"))
        (add-to-list 'agda-input-user-translations '("h->" "￫"))
        (add-to-list 'agda-input-user-translations '("hd" "￬"))

7.  Other

        (add-to-list 'agda-input-user-translations '("op" "⊕"))
        (add-to-list 'agda-input-user-translations '("^<" "﹤"))
        (add-to-list 'agda-input-user-translations '("d<" "⪡"))
        (add-to-list 'agda-input-user-translations '("powset" "℘"))
        (add-to-list 'agda-input-user-translations '("X" "⨉"))
        ;; Lunate sigmas
        (add-to-list 'agda-input-user-translations '("Ls" "ϲ"))
        (add-to-list 'agda-input-user-translations '("LS" "Ϲ"))
    
    This Yi script character for the syllable “git” I use
    as a shorthand for “git” (the version control software)
    in my tab names.
    
        (add-to-list 'agda-input-user-translations '("git" "ꇚ"))

8.  Activate the new additions

        (agda-input-setup)


### Activate Agda input mode in `text`, `prog` and `artist` modes

Agda input mode makes it extremely easy to use unicode in documents,
something I strongly prefer to do.
When I can use symbols directly, instead of (for instance)
LaTeX commands, it makes my plaintext far more readable.

So, let's enable Agda input mode in most instances.

    (add-hook 'text-mode-hook
           (lambda () (set-input-method "Agda")))
    (add-hook 'prog-mode-hook
           (lambda () (set-input-method "Agda")))
    (add-hook 'artist-mode-hook
           (lambda () (set-input-method "Agda")))


### Org Agda mode

Org-Agda mode is a Polymode Musa and I created
for working on literate Agda documents written in Org mode.
<https://github.com/alhassy/org-agda-mode>

We need to install Polymode.

    (use-package polymode)

    (require 'org-agda-mode)


<a id="org86e4de9"></a>

# Keybindings

I make use of `general` to organise keybindings.

    (use-package general)


<a id="orgb73a9ea"></a>

## `general` definers

You can use `general-define-key` directly to define shortcuts,
ideally using the keyword argument `:prefix` to avoid repeating
prefixes, but if you are (even only possibly)
using a prefix several times,
it's better to create a custom function to use instead of
`general-define-key`.

Setting `:keymaps` to `'override` ensures that no package will
override my shortcuts.

    (general-create-definer general-main-define-key
      :prefix "C-c"
      :keymaps 'override)
    
    (general-create-definer general-appearance-define-key
      :prefix "C-c a"
      :keymaps 'override)
    
    (general-create-definer general-buffer-define-key
      :prefix "C-c b"
      :keymaps 'override)
    
    (general-create-definer general-window-define-key
      :prefix "C-c w"
      :keymaps 'override)
    
    (general-create-definer general-tab-define-key
      :prefix "C-c t"
      :keymaps 'override)
    
    (general-create-definer general-dired-define-key
      :prefix "C-c d"
      :keymaps 'override)
    
    (general-create-definer general-shell-define-key
      :prefix "C-c s"
      :keymaps 'override)
    
    (general-create-definer general-other-package-define-key
      :prefix "C-c p"
      :keymaps 'override)


<a id="org02007ca"></a>

## Invoke processes


### `yankpad`

    (general-main-define-key
      "f" 'yankpad-expand)
    
    (general-other-package-define-key
      "y m" 'yankpad-map
      "y r" 'yankpad-reload)


### `dired`

1.  Jumping to specific files

    These are not properly `dired` shortcuts, but some files
    I open often enough to want a direct shortcut.
    
        (general-dired-define-key
          "s" '(:ignore t
                :which-key "scratch buffers")
          "sa" '((lambda () (interactive)
                   (find-file "~/Dropbox/McMaster/Agda/agda-scratch.agda"))
                 :which-key "agda scratch")
          "so" '((lambda () (interactive)
                   (find-file "~/logs/scratch/org-scratch.org"))
                 :which-key "org scratch")
          "e" '((lambda () (interactive)
                   (find-file "~/dotfiles/emacs/emacs-init.org"))
                 :which-key "emacs init"))

2.  Jumping to directories

    I use shortcuts to jump to frequently used directories in `dired`
    (from any buffer, not just while in `dired`).
    
    Some times it is convenient to use a different function to
    invoke `dired`; in particular, in the past,
    I used `dired-single` with the invokation `dired-single-magic-buffer`,
    in order to avoid having multiple `dired` buffers created.
    This turned out to be detrimental once I started keeping
    multiple `dired` windows open in different tabs.
    
        (defun my-dired-invocation (directory)
          "My custom dired invocation.
           It will use my special “magic buffer” for browsing."
          (dired directory))
    
        (general-dired-define-key
          "c" '((lambda () (interactive)
                  (my-dired-invocation default-directory))
                :which-key "current")
          "/" '((lambda () (interactive)
                  (my-dired-invocation "/"))
                :which-key "root")
          "h" '((lambda () (interactive)
                  (my-dired-invocation "~"))
                :which-key "home")
          "~" '((lambda () (interactive)
                  (my-dired-invocation "~"))
                :which-key "home")
          "d" '((lambda () (interactive)
                  (my-dired-invocation "~/dotfiles/"))
                :which-key "dotfiles")
          "D" '((lambda () (interactive)
                  (my-dired-invocation "~/Downloads/"))
                :which-key "downloads")
          "l" '((lambda () (interactive)
                  (my-dired-invocation "~/log/"))
                :which-key "logs")
          "r" '((lambda () (interactive)
                  (my-dired-invocation "~/reading/"))
                :which-key "reading")
          "p" '((lambda () (interactive)
                  (my-dired-invocation "~/projects/"))
                :which-key "projects")
          "t" '((lambda () (interactive)
                  (my-dired-invocation "~/teaching/"))
                :which-key "teaching")
          "T" '((lambda () (interactive)
                  (my-dired-invocation "~/projects/agda-computability"))
                :which-key "thesis"))


### `eshell`

:TODO: This will not work if `eshell` instances are created without this shortcut. Instead I should count the number of shell buffers existing?

    (general-shell-define-key
      "s" 'eshell)
    
    (setq my/eshell-counter 0)
    (general-shell-define-key
      "n" '((lambda () (interactive)
              (setq my/eshell-counter (+ 1 my/eshell-counter))
              (eshell my/eshell-counter))
            :which-key "new eshell"))


### `magit`

    (general-main-define-key
      "g" 'magit-status)


### `mu4e`

    (general-main-define-key
      "m" 'mu4e)

With insight on performing the buffer kill action
after the asynchronous
shell command finishes from [here](https://emacs.stackexchange.com/questions/42172/run-elisp-when-async-shell-command-is-done).
See the `kill-buffer-on-process-finish` definition earlier in this file.

    (general-other-package-define-key
      "m" '((lambda () (interactive)
              (let* ((output-buffer-name "*mbsync all directories*")
                     (output-buffer (generate-new-buffer output-buffer-name))
                     (process (progn
                             (async-shell-command "mbsync gmail-quick" output-buffer)
                             (get-buffer-process output-buffer))))
                  (if (process-live-p process)
                      (set-process-sentinel process #'kill-buffer-on-process-finish) 
                    (message "mbsync all directories is not running, but I expected it to be!"))))
            :which-key "mbsync all directories"))


### `list-processes`

    (general-other-package-define-key
      "p" 'list-processes)


<a id="orgd9f3c3b"></a>

## Buffer

    (general-buffer-define-key
      "r" '((lambda () (interactive) (revert-buffer () t ()))
            :which-key "revert buffer")
    
      "u" '(:ignore t
            :which-key "undo actions")
      "u p" '((lambda () (interactive) (undo-propose))
              :which-key "undo-propose")
      "u t" '((lambda () (interactive) (undo-tree-visualize))
              :which-key "undo-tree")
    
      "t" '((lambda () (interactive) (beginning-of-buffer))
            :which-key "buffer top")
      "b" '((lambda () (interactive) (end-of-buffer))
            :which-key "buffer bottom"))


<a id="orgf505a3c"></a>

## Appearance

    (general-appearance-define-key
      "t"   '(:ignore t
              :which-key "themes")
      "t t" '((lambda () (interactive) (toggle-my-themes))
              :which-key "toggle theme")
      "t c" '((lambda () (interactive) (disable-all-custom-themes))
              :which-key "clear theme"))

    (general-appearance-define-key
      "o"   '(:ignore t
              :which-key "org cosmetics")
      "o i"   '(:ignore t
                :which-key "org indent")
      "o i y" '((lambda () (interactive) (org-indent-mode 1))
                :which-key "org indent yes")
      "o i n" '((lambda () (interactive) (org-indent-mode 0))
                :which-key "org indent no"))

These are cosmetics relating to lines in the current buffer.

    (general-appearance-define-key
      "l"     '(:ignore t
                :which-key "line cosmetics")
      "l n"   '(:ignore t
                :which-key "line numbers")
      "l n y" '((lambda () (interactive) (display-line-numbers-mode 1))
                :which-key "line numbers - yes")
      "l n n" '((lambda () (interactive) (display-line-numbers-mode 0))
                :which-key "line numbers - no")
      "l w"   '(:ignore t
                :which-key "line wrap")
      "l w y" '((lambda () (interactive) (visual-line-mode 1))
                :which-key "yes line wrap")
      "l w n" '((lambda () (interactive) (visual-line-mode 0))
                :which-key "no line wrap"))

Sometimes I need to toggle fontlocking.

    (general-appearance-define-key
      "f"     '(:ignore t
                :which-key "font lock")
      "f y"   '((lambda () (interactive)
                  (font-lock-mode t))
                :which-key "yes font lock")
      "f n"   '((lambda () (interactive)
                  (font-lock-mode 0))
                :which-key "no font lock"))


<a id="org77ae9cb"></a>

## Window management

    (general-window-define-key
      "<right>" '((lambda () (interactive) (windmove-right))
                  :which-key "move focus right")
      "<left>"  '((lambda () (interactive) (windmove-left))
                  :which-key "move focus left")
      "<up>"    '((lambda () (interactive) (windmove-up))
                  :which-key "move focus up")
      "<down>"  '((lambda () (interactive) (windmove-down))
                  :which-key "move focus down")
    
      "f"  '((lambda () (interactive) (other-frame 1))
                  :which-key "other frame")
      
      "["  'winner-undo
      "]"  'winner-redo
    
      "-"     '((lambda () (interactive) (shrink-window 5))
                :which-key "shrink window")
      "="     '((lambda () (interactive) (enlarge-window 5))
                :which-key "enlarge window")
      "_"     '((lambda () (interactive) (shrink-window 999))
                :which-key "minimise window")
      "+"     '((lambda () (interactive) (enlarge-window 999))
                :which-key "maximise  window"))


<a id="org3dbca45"></a>

## Tab management

    (general-tab-define-key
      "r" 'tab-rename
      "k" 'tab-close
      "n" 'tab-new
    
      "<right>" 'tab-next
      "<left>"  'tab-previous
      "<down>"  'tab-recent
      "<up>"    'tab-undo
      "S-<right>" '((lambda () (interactive) (tab-move 1))
                  :which-key "move tab to left")
      "S-<left>"  '((lambda () (interactive) (tab-move -1))
                  :which-key "move tab to right")
    
      "1" (lambda () (interactive) (tab-select 1))
      "2" (lambda () (interactive) (tab-select 2))
      "3" (lambda () (interactive) (tab-select 3))
      "4" (lambda () (interactive) (tab-select 4))
      "5" (lambda () (interactive) (tab-select 5))
      "6" (lambda () (interactive) (tab-select 6))
      "7" (lambda () (interactive) (tab-select 7))
      "8" (lambda () (interactive) (tab-select 8))
      "9" (lambda () (interactive) (tab-select 9))
      "0" (lambda () (interactive) (tab-select 10))
      "-" (lambda () (interactive) (tab-select 11))
      "=" (lambda () (interactive) (tab-select 12)))


<a id="org3c2dec3"></a>

## Counsel

    (general-main-define-key
      "y" 'counsel-yank-pop)


<a id="org7ba7eb2"></a>

## Company

    (general-main-define-key
      "c" 'company-manual-begin)


<a id="orgcc42759"></a>

## Other

    (general-other-package-define-key
      "j" 'dad-joke)


<a id="org03a680a"></a>

# Intermediate cosmetics


<a id="org068f41b"></a>

## Whitespace display


### Tabs

I usually use spaces rather than tabs,
so I use `whitespace-mode` to alert me to the presence of tabs.

    (global-whitespace-mode t)

Setting `whitespace-style` to `tab-mark` visualises tabs
by changing the display table to show a character at the
location of the tab.

    (setq whitespace-style '(tab-mark))

Also, make tabs less wide. I dislike them taking up too much of the screen.

    (setq-default tab-width 2)


### Non-breaking spaces

Since I use unicode regularly, I do use non-breaking spaces
occasionally, especially for intraperiodic spaces, e.g.,
following `Dr.` or `Mrs.`.
I do want to be aware of those spaces; thankfully there is
a face for that.

    (custom-theme-set-faces
     'user
     '(nobreak-space ((t (:underline t)))))


### Deprecated whitespace highlighting

I previously used `whitespace-style` to highlight
trailing whitespace; however, I find this feature intrusive,
so I avoid it.

If it is wanted later, then I should add to the list

    (face trailing)

We need to add `face` to the list, to enable using faces
to highlight whitespace.

Note there is no way to visualise spaces only at the end of lines;
The visualisation is done by changing the display table,
and there is no ability to do so only in particular places.
Otherwise I would use that rather than highlighting.


<a id="org7e70fec"></a>

## Rainbow delimiters

Above, I have settings for highlighting the delimiter
matching the one under the cursor.

The package `rainbow-delimiters` goes ones step further than
highlighting the delimiter matching the one under cursor;
it makes the matching of all delimiters
obvious by using various colours.
Each level of nesting uses a different colour.

    (use-package rainbow-delimiters)
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'text-mode-hook #'rainbow-delimiters-mode)

One potential downside of `rainbow-delimiters` is that when
delimiter matching fails for reasons out of our control,
it can make the appearance of delimiters very poor in that buffer.

For instance, if we write a list using a parenthese after each label,

1.  such as here,

those parentheses will be unmatched, and will be highlighted in red.

Worse, in some modes, it is not clear which delimiters
should be matched and which not.
In particular, delimiters which occur inside strings
in code should not be considered as proper delimiters,
and programming modes usually set up this behaviour.
But Org mode source blocks for those languages do not inherit
that behaviour, so such delimiters are not given any special status
and will be highlighted.

If we are working on another's Org code, there is little we can do
to alleviate this.
In my own Org code, I tend to insert comments to match the delimiters,
or avoid cases where this can occur (such as using periods after
the labels in lists.)

For an example of this, see my settings for the Org emphasis
regular expressions, which require some commented out
delimiters to avoid breaking all delimiter matching
later in this file.


<a id="orga6f3e8c"></a>

## Tab-bar

    (tab-bar-mode)

The default colouring is a basic Emacs grey;
let's spruce it up.

    (custom-theme-set-faces
     'user
     '(tab-bar ((t
         (:foreground "black"
          :background "DarkSlateGray4"))))
      '(tab-bar-tab ((t
         (:foreground "black"
          :background "DarkSlateGray3"
          :box (:line-width 1 :style released-button)))))
      '(tab-bar-tab-inactive ((t
         (:foreground "black"
          :background "DarkSlateGray4"
          :box (:line-width 1 :style released-button))))))

Do show numbers on tabs, for the purpose of quickly changing.

    (setq tab-bar-tab-hints 't)

Remove the close buttons; hitting them by mistake is annoying,
and I can close tabs by other commands easily enough.

    (setq tab-bar-close-button-show nil)


<a id="orge59957c"></a>

## A more noticable divider between windows

One problem with a fill column ruler is that it can seem like
it is the divider between windows.

For that reason, I like to have a more noticable divider
between windows. `window-divider-mode` provides this.

    (window-divider-mode)


<a id="org88c27fc"></a>

## Dim buffers when not in use

The package `dimmer` will dim inactive windows to emphasise which
window has focus.
See its [Github page](https://github.com/gonewest818/dimmer.el).

    (use-package dimmer)

Turn `dimmer-mode` on when Emacs starts.

    (dimmer-mode)

Don't dim `which-key` and `helm` buffers.

    (dimmer-configure-which-key)
    (dimmer-configure-helm)

We can adjust the `:foreground` colours, the `:background` colours,
or `:both`. With a dark theme, adjusting the background causes
the background to become lighter in inactive buffers,
which “looks wrong” (makes them looked like they have focus).
So I set this to just `:foreground` (which is the default anyway).

    (setq dimmer-adjustment-mode :foreground)

I find the default dimming of `20%` to be too faint;
it is noticeable when changing windows, but it does not
remain noticeable enough later (e.g. when I look away from Emacs
then look back). Increasing that to `30%` seems to be sufficient,
while maintaing the readability of unfocussed buffers.

    (setq dimmer-fraction 0.3)

Note that by default, all windows will be dimmer when Emacs
notices that it does not have focus in the windowing system.
I like this behaviour; it could be changed by changing
the variable `dimmer-watch-frame-focus-events`.


<a id="orge023140"></a>

## Kill the open init buffer and reopen it

To ensure all these cosmetic changes are picked up,
kill my init buffer that we opened earlier and reopen it.

    (kill-buffer "emacs-init.org")
    (find-file my/emacs-init-file)


<a id="org05f9061"></a>

# Intermediate modes and intermediate mode-specific settings


<a id="org532499d"></a>

## Org mode cosmetics

1.  Indent text based on heading by default

    Although it wastes some space, it's generally easier to read
    Org files if the contents of a heading are indented
    based on the nesting of the heading.
    
        (setq org-startup-indented t)
    
    This can be overrode for particular files
    by using the `startup` setting `noindent`.
    (I.e., put `#+startup: noindent` in the file.)

2.  Hide emphasis markers by default

    Emphasis markers, the markup syntax that
    makes particular portions of the text bold, italicized, etc.,
    do not generally need to be seen when deiting.
    
        (setq org-hide-emphasis-markers t)
    
    It is convenient to show the emphasis markers around point.
    Otherwise it becomes tedious to edit emphasised text.
    
    There have been a couple Reddit posts seeking to solve this problem.
    First, [this code](https://www.reddit.com/r/orgmode/comments/43uuck/) which doesn't work for all emphasis markers.
    
        (defun org-show-emphasis-markers-at-point ()
          (save-match-data
            (if (and (org-in-regexp org-emph-re 2)
                     (>= (point) (match-beginning 3))
                     (<= (point) (match-end 4))
                     (member (match-string 3) (mapcar 'car org-emphasis-alist)))
                (with-silent-modifications
                 (remove-text-properties
                  (match-beginning 3) (match-beginning 5)
                   '(invisible org-link)))
              (apply 'font-lock-flush (list (match-beginning 3) (match-beginning 5))))))
    
    Then, [this more recent code](https://www.reddit.com/r/orgmode/comments/dj5u1y)
    which adds more checks.
    However, it seems to lag input a bit?
    
        (defun sbr-org-toggle-emphasis-markers-at-point ()
          (interactive)
          (save-match-data
            (when (or (org-in-regexp org-emph-re 2)
                      (org-in-regexp org-verbatim-re 2))
              (if (and (>= (point) (match-beginning 3))
                       (<= (point) (match-end 4))
                       (member (match-string 3) (mapcar 'car org-emphasis-alist))
                       (get-text-property (match-beginning 3) 'invisible))
                  (with-silent-modifications
                    (remove-text-properties
                     (match-beginning 3) (match-beginning 5)
                     '(invisible org-link)))
                (apply 'font-lock-flush (list (match-beginning 3) (match-beginning 5)))))))
    
    This is my attempt, combining the two to some extent.
    :TODO: this doesn't always hide the characters after point leaves
    
        (defun org-toggle-emphasis-markers-at-point ()
          (save-match-data
            (when (or (org-in-regexp org-emph-re 2)
                      (org-in-regexp org-verbatim-re 2)
                      (org-in-regexp org-link-any-re 2))
              (if (and (>= (point) (match-beginning 3))
                       (<= (point) (match-end 4))
                       (member (match-string 3) (mapcar 'car org-emphasis-alist)))
                       ;; invisible check?
                  (with-silent-modifications
                    (remove-text-properties
                     (match-beginning 3) (match-beginning 5)
                     '(invisible org-link)))
                (apply 'font-lock-flush
                  (list (match-beginning 3) (match-beginning 5)))))))
    
    We run the above function after each command in an Org mode buffer.
    :TODO: improve this functionality before use.
    
        ;(add-hook 'org-mode-hook
        ;  (lambda ()
        ;    (add-hook 'post-command-hook
        ;      'org-toggle-emphasis-markers-at-point nil t)))

3.  Emphasis marker regexps

    We can change the behaviour of Org emphasis markers
    in terms of what characters are allowed to occur around
    and between them; see 
    [this stack exchange post](https://emacs.stackexchange.com/questions/41111/)
    for a sample setup, and
    [this other post](https://emacs.stackexchange.com/questions/13820)
    which is linked to from the first and which has more details.
    
    Note that these settings are somewhat complicated
    by the fact that they are used to construct regular expressions;
    I lost a great amount of time to misplaced brackets and braces,
    which made Org very confused about what I wanted,
    since they were misinterpreted as regular expression syntax.
    See my
    [StackOverflow question](https://stackoverflow.com/q/63805679/2041536) on this.
    
    Everything here must be set when Org is loaded.
    
        (with-eval-after-load 'org
    
    Only these characters are allowed to immediately precede
    an emphasis character (left outer boundary characters).
    Note that, as I am including a dash, it must be the first or final character,
    and if including a closing bracket, it must be the first character.
    See [Special Characters in Regular Expression](https://www.gnu.org/software/emacs/manual/html_node/elisp/Regexp-Special.html#Regexp-Special).
    
        (setcar org-emphasis-regexp-components
          (concat
            ;; All whitespace characters.
            "[:space:]"
            (string
              ;; Opening delimiters; the comments prevent check-parens from getting mad 😀.
              ?\( ;;)
              ?\{ ;;}
              ?“  ;;”
              ?\[ ;;]
              ;; Dashes
              ?— ?– ?-))) ;; Do not move the dash. It will break the regexp.
    
    Only these characters are allowed to immedately follow
    an emphasis character (right outer boundary characters).
    
        (setcar (nthcdr 1 org-emphasis-regexp-components)
          (concat
            (string ;[
               ?\]) ;; Do not move the bracket. It will break the regexp.
            ;; All whitespace characters.
            "[:space:]"
            (string
              ;; Closing delimiters, with matching comments as above.
                  ;;(
              ?\) ;;{
              ?\} ;;“
              ?”
              ;; Single quote
              ?'
              ;; Punctuation
              ?. ?? ?! ?, ?\; ?:
              ;; Dashes
              ?– ?— ?-))) ;; Do not move the dash. It will break the regexp.
    
    Any characters are allowed as inner boundary characters,
    *except* for those listed here.
    
        (setcar (nthcdr 2 org-emphasis-regexp-components)
          "[:space:]")
    
    Any characters are allowed between the inner border characters.
    (The regular expression `.` matches any character).
    
        (setcar (nthcdr 3 org-emphasis-regexp-components)
          ".")
    
    Only one newline allowed, though.
    
        (setcar (nthcdr 4 org-emphasis-regexp-components) 1)
    
    Now we update the setting.
    
        (org-set-emph-re
          'org-emphasis-regexp-components
          org-emphasis-regexp-components))
    
    NOTE the extra closing parenthesis to end the `with-eval-after-load`!
    
    1.  Test it out
    
        Here are tests of all the `pre` and `post` values at time of writing.
        
             *test*
            (*test*
            )
            [*test*
            ]
            {*test*
            }
            “*test*
            ”
            -*test*
            –*test*
            —*test*
            
            *test* ;
            (
            *test*)
            [
            *test*]
            {
            *test*}
            “
            *test*”
            *test*-
            *test*–
            *test*—
            *test*.
            *test*?
            *test*!
            *test*,
            *test*;
            *test*:

4.  Highlight math mode blocks

    Org mode supports some LaTeX content inline.
    In particular, we can use math mode syntax `$…$` and
    subscripts `_{…}` and superscripts `^{…}`.
    We should highlight this content to emphasis its presence.
    
        (setq org-highlight-latex-and-related '(latex script entities))
    
    :TODO: What does `entities` refer to here?

5.  Pretty bullets

    Replace the plain asterisk bullets preceding Org headings
    with fancier characters; a collection is used, so that
    headings at different levels have different bullets.
    
        (use-package org-bullets
          :hook (org-mode . org-bullets-mode))

6.  Replace the ellipsis `...`

    By default, folded portions of the document are
    presented by an ellipsis, `...`. Let's replace that.
    
        (setq org-ellipsis " ⮷")
    
    But I find the arrow I use is not particularly visible with my theme;
    it gets set to a very faint colour.
    So, I customise the `org-ellipsis` face so that it has
    the same colour as the rest of the headline.
    It has to be set after every theme change, or the setting will
    be overwritten (probably the themes I use set it specifically?).
    
        (add-hook 'after-load-theme-hook
          (lambda ()
            (set-face-attribute
              'org-ellipsis
              nil ;; all frames
              :foreground 'unspecified)))

7.  Inline images

    We can configure Org to automatically inline linked images
    when opening documents.
    
        (setq org-startup-with-inline-images t)

8.  Tag position

    By default (as of Org 9.1.9),
    tags get shifted to the 77th column.
    But this causes blank lines to be inserted
    when working on narrower screens.
    I bump it down a good bit,
    to ensure tags stay away from the right side of the screen.
    
        (setq org-tags-column 48)

9.  Adjusting image display size

    I like to use inline images in Org mode, but of course
    I don't want large images to be shown at full size!
    Better to err on the side of making images too small,
    so set the width of all images to be just 100 pixels.
    
        (setq org-image-actual-width 100)

10. Colour-coded `src` block backgrounds

    The Modus themes allow for colour-coded
    backgrounds of Org `src` blocks,
    where the colour depends on the language.
    Neat!
    
        (use-package modus-themes)
        (setq modus-themes-org-blocks 'rainbow)
    
    This function will add some colour associations.
    :TODO: use more varied colours. There are subtle and fringe variants of each.
    
        (defun my/modus-add-org-src-block-faces ()
          (setq org-src-block-faces (append org-src-block-faces
                 `(("text"       modus-theme-nuanced-red)
                   ("emacs-lisp" modus-theme-nuanced-magenta)
                   ("elisp"      modus-theme-nuanced-magenta)
                   ("clojure"    modus-theme-nuanced-magenta)
                   ("latex"      modus-theme-nuanced-yellow)
                   ("ditaa"      modus-theme-nuanced-yellow)
                   ("dot"        modus-theme-nuanced-yellow)
                   ("haskell"    modus-theme-nuanced-blue)
                   ("elm"        modus-theme-nuanced-blue)
                   ("scala"      modus-theme-nuanced-blue)
                   ("amm"        modus-theme-nuanced-blue)
                   ("ruby"       modus-theme-nuanced-green)
                   ("prolog"     modus-theme-nuanced-cyan)
                   ("agda"       modus-theme-nuanced-cyan)))))
    
    Run the function every time we change themes.
    
        (add-hook 'after-load-theme-hook 'my/modus-add-org-src-block-faces)
    
    Run it now to apply the change, since the theme is already set.
    
        (my/modus-add-org-src-block-faces)


<a id="orgcf5b0c8"></a>

## Org mode exportation settings


### Export in the background

Using `latex-mk`, the export process for LaTeX takes a bit of time.
Tying up emacs during that time is annoying, so set the
export to happen in the background.
This setting can be modified locally in the export dialog frame
if desired by adding `C-a` to the export key sequence..

    ;;(setq org-export-in-background t)

This works by spawning a new Emacs session in which the file is exported.
By default, that session would use this init file, but that's overkill
and wastes time; most of this init is not relevant for that session.
So, we'll set a different init file, constructed from the relevant
portions of this file.

    ;(setq org-export-async-init-file
    ;  "~/.config/emacs/org-async-init.el") 

Some default settings.

    ;; Org export init, tangled from my Emacs init
    (require 'package)
    (setq package-enable-at-startup nil)
    (package-initialize)
    
    (require 'org)
    (require 'ox)
    (require 'ox-extra)
    
    (setq org-export-async-debug t)

:TODO: There must be a better way to generate this file.
These settings are from this exporting section.

    (ox-extras-activate '(ignore-headlines))
    ;;;; noexport is in the list by default
    ;; (add-to-list 'org-export-exclude-tags "noexport")
    (setq org-src-preserve-indentation t)
    (use-package htmlize)
    (setq org-html-link-org-files-as-html nil)
    (setq org-latex-compiler "lualatex")
    (setq org-latex-pdf-process
          '("latexmk -%latex -shell-escape -f %f"))
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
    (add-to-list
      'org-latex-classes
        '("beamer"
          "\\documentclass[presentation]{beamer}"
          ("\\section{%s}" . "\\section*{%s}")
          ("\\subsection{%s}" . "\\subsection*{%s}")
          ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
    
    (setq org-latex-hyperref-template
      "\\hypersetup{
       pdfauthor={%a},
       pdftitle={%t},
       pdfkeywords={%k},
       pdfsubject={%d},
       pdfcreator={%c},
       pdflang={%L},
       colorlinks,
       linkcolor=blue,
       citecolor=blue,
       urlcolor=blue
       }
    "
    )
    (use-package ox-reveal)
    (setq org-reveal-theme "black")
    (setq org-reveal-title-slide
      "<h2 class=\"title\">%t</h2>
       <h3>%s</h3>
       <h4>%a</h4>
       <h5>%d</h5>")
    
    (use-package ox-pandoc)
    (defun my/ensure-headline-ids (&rest _)
      "Org trees without a :CUSTOM_ID: property have the property
       set to be their headline.
    
       Trees whose headline are tagged with :ignore:
       are not given an ID.
    
       Trees whose headline are tagged with :noexport:
       and any subtrees of those trees are not given an ID.
    
       A prefix is used to identify IDs which were set by this process,
       so they can be recreated in case their headline changes.
       A postfix counter is used to prevent the case where
       trees cannot be linked to because they happen to share
       their heading with earlier trees.
      "
      (interactive)
      (let ((generated-ids ())
            (prefix "org-anchor-"))
        (cl-flet ((append-counter (x n) (concat x "^" (number-to-string n))))
          (org-map-entries
           (lambda ()
             (let* ((heading-components (org-heading-components))
                    (headline (nth 4 heading-components))       
                    (tags     (nth 5 heading-components)))
               (if (and tags (string-match-p (regexp-quote ":noexport:") tags))
                 ;; This heading is tagged as noexport.
                 ;; Set org-map-continue-from to next heading at this level.
                 ;; (Just moving to the next heading would not suffice;
                 ;;  children of this heading are also not exported.)
                 (setq org-map-continue-from (progn (org-goto-sibling)
                                                    (line-beginning-position)))
                 ;; Otherwise, check if this heading is tagged as ignore.
                 (unless (and tags (string-match-p (regexp-quote ":ignore:") tags))
                   ;; Otherwise, we want to check this heading's custom ID.
                   (let ((id (org-entry-get nil "CUSTOM_ID")))
                     ;; If `id` was not found, or if it seems to have been generated by this function,
                     ;; proceed to generate a new custom ID.
                     (unless (and id (not (string-prefix-p prefix id)))
                       ;; Create the id. Concatenate the prefix...
                       (let ((new-id (concat prefix
                                         ;; ...with this heading's headline
                                         ;; (note spaces are not allowed in links;
                                         ;; substitute dashes for any found.)
                                         (s-replace " " "-" headline))))
                              (push new-id generated-ids)
                         ;; Finally, add a counter of the number of
                         ;; previous occurrences of this id, to prevent repetition.
                         (let ((unique-id (append-counter
                                            new-id 
                                            (seq-count (lambda (x) (string-equal x new-id))
                                                       generated-ids))))
                           (org-entry-put nil "CUSTOM_ID" unique-id)))))))))))))
    
    ;; Whenever html & md export happens, ensure we have headline ids.
    (advice-add 'org-html-export-to-html :before 'my/ensure-headline-ids)
    (advice-add 'org-md-export-to-markdown :before 'my/ensure-headline-ids)
    (setq org-export-with-sub-superscripts '{})

We also need code evaluation settings, as code blocks may need
to be evaluated for export.

    (setq org-confirm-babel-evaluate nil)
    (require 'ob-shell)
    (require 'ob-haskell)
    (require 'ob-latex)
    (require 'ob-C)
    (require 'ob-ruby)
    (require 'ob-plantuml)
    (require 'ob-R)
    (require 'ob-ditaa)
    (require 'ob-scheme)
    (require 'ob-dot)
    (require 'ob-python)
    (require 'ob-js)
    (require 'ob-clojure)
    (setq org-ditaa-jar-path "/usr/bin/ditaa")
    (org-babel-shell-initialize)
    (setq org-plantuml-jar-path "/usr/share/java/plantuml.jar")


### Ignoring content

1.  Headings

    Use the `:ignore:` tag on headlines to omit the headline when
    exporting, but keep its contents.
    
        (ox-extras-activate '(ignore-headlines))
    
    Alternatively, use the `:noexport:` tag to omit the headline
    *and* its contents.
    
        ;;;; noexport is in the list by default
        ;; (add-to-list 'org-export-exclude-tags "noexport")

2.  Drawers

    Ignore all drawers when exporting, by default.
    
        (setq org-export-with-drawers nil)


### Source code block indentation and colouring

I want to preserve my indentation for source code during export.

    (setq org-src-preserve-indentation t)

The `htmlize` package preserves source code colouring on export to html.
(And presumably does a lot more I am not fully aware of).

    (use-package htmlize)

Now, since I work with a dark theme (at least most of the time),
the source code colouring `htmlize` uses might not show up well
on the typically white background in the exported HTML.
This code from [StackExchange](https://emacs.stackexchange.com/a/3512/30156)
removes that problem; use the current background colour when exporting!

    (defun my-org-inline-css-hook (exporter)
      "Insert custom inline css"
      (when (eq exporter 'html)
        (let ((my-pre-bg (face-background 'default)))
          ;;(setq org-html-head-include-default-style nil)
          (setq org-html-head-extra
                (format "<style>pre.src{background:%s;color:white;} </style>" my-pre-bg)))))
    
    (add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)

The above was modified to not explicitely disable the default styling
(don't need it in my case, but also don't need to disable it)
and to use `head-extra` instead of `head`, as `head` is overwritten
by the themes I use.

Note, if I set `HTML_HEAD_EXTRA` in an Org file,
then the background colour setting will be lost!

:TODO: It would be nice to pick up the background colour for that particular language, rather than default; I like the differing colours the Modus theme gives me for source blocks.


### Don't change `.org` links to `.html`

By default
(see the [manual](https://orgmode.org/manual/Links-in-HTML-export.html))
when exporting to HTML, Org will change `.org` links to `.html`.
I don't want this; for instance, when teaching a course,
I like to link to both a generated HTML file and
the original Org source version of notes
(on my generated course homepage).

    (setq org-html-link-org-files-as-html nil)

If I mean to link to the HTML file, I will do so explicitely.


### Require `{}` to denote sub/superscripts

Sometimes I want to export the characters `_` or `^`.
However, Org allows these to be used for LaTeX style sub/superscripts,
so a lone `_` will be exported (to LaTeX at least)
as `\_{}` (and similarly for a lone `^`).

In order to avoid this, but still allow for LaTeX style sub/superscripts,
we can use a setting to *require* that sub/superscripts be enclosed in brackets
(which is my preference in any case).

    (setq org-export-with-sub-superscripts '{})


### LaTeX export settings

1.  Default LaTeX compiler

    I use a lot of unicode, and I find `xelatex` and `lualatex`
    handle that more easily than `pdflatex`.
    
    From my experience so far, they seem pretty interchangable
    for my purposes, so the decision of which to use is arbitrary.
    
    Based on [this discussion on Stack Exchange](https://tex.stackexchange.com/questions/36/differences-between-luatex-context-and-xetex), LuaTeX seems the more
    “up and coming” engine. I've used it for quite a while now,
    and have found no problems with it.
    
        (setq org-latex-compiler "lualatex")

2.  LaTeX compilation process

    I use `latexmk` to automatically run as many passes as needed
    to resolve references, etc.
    
        (setq org-latex-pdf-process
              '("latexmk -%latex -shell-escape -f %f"))
    
    The flags/format specifiers are
    
    <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
    
    
    <colgroup>
    <col  class="org-left" />
    
    <col  class="org-left" />
    </colgroup>
    <tbody>
    <tr>
    <td class="org-left"><code>%latex</code></td>
    <td class="org-left">stands in for the latex compiler (defaults to the setting above)</td>
    </tr>
    
    
    <tr>
    <td class="org-left"><code>-f</code></td>
    <td class="org-left">force continued processing past errors</td>
    </tr>
    
    
    <tr>
    <td class="org-left"><code>%f</code></td>
    <td class="org-left">stands in for the (relative) filename</td>
    </tr>
    
    
    <tr>
    <td class="org-left"><code>-shell-escape</code></td>
    <td class="org-left">necessary to use <code>minted</code></td>
    </tr>
    </tbody>
    </table>

3.  Custom document classes

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
    
    Sometimes, for creating slides, `beamer` is useful.
    (Though I try to avoid it now; it feels low level to me).
    
        (add-to-list
          'org-latex-classes
            '("beamer"
              "\\documentclass[presentation]{beamer}"
              ("\\section{%s}" . "\\section*{%s}")
              ("\\subsection{%s}" . "\\subsection*{%s}")
              ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

4.  Use `minted` for code blocks

    First, make sure we load the `minted` package.
    
        (add-to-list 'org-latex-packages-alist '("newfloat" "minted"))
    
    The `newfloat` package can be used with `minted` with
    a `newfloat` option to, for instance, support pagebreaks
    in the float. See this StackExchange
    [post](https://tex.stackexchange.com/questions/254044/)
    if you want to set that up.
    
    Now, we tell Org to use a `minted` environment,
    rather than the default `verbatim`, for code.
    
        (setq org-latex-listings 'minted)
    
    1.  Default options for `minted`
    
        One reason to use `minted` or `listings` over the simple `verbatim` is
        that it can put decent-looking linebreaks where necessary
        to prevent code running out of the margins.
        This is controlled by the `breaklines` argument.
        
        Probably there are other options I should add as well.
        
            (setq org-latex-minted-options
              '(("breaklines" "true")))
    
    2.  Don't box unicode characters
    
        Since I primarily export Agda code, which is full of unicode characters,
        and most `minted` styles enclose those characters in a red `fbox`,
        I use this hack to disable `fbox`'s inside `minted` environments.
        (setq 'org-latex-packages-alist ())
        
            (add-to-list 'org-latex-packages-alist
              "\\makeatletter
            \\def\\dontdofcolorbox{\\renewcommand\\fcolorbox[4][]{##4}}
            \\AtBeginEnvironment{minted}{\\dontdofcolorbox}
            \\makeatother")
        
            (add-to-list 'org-latex-packages-alist '("" "etoolbox"))
    
    3.  Treat `agda2` source as `Haskell` for listings
    
        Unfortunately, `minted` doesn't support Agda,
        so we simply have Org tell it that it's Haskell code.
        
            (add-to-list 'org-latex-minted-langs '(agda2 "Haskell"))
    
    4.  Alternative: use `listings` in place of `minted`
    
        As a step between using `verbatim` blocks and
        using `minted` for source code,
        we can use the `listings` package.
        
        I found that `listings` caused odd typesetting of my Agda code;
        code was out of order, particularly when using underscores,
        and had oddly placed line breaks.
        It may have been an issue with treating Agda code as Haskell;
        I didn't diagnose much before switching to
        using `minted` instead.
        
        If the setup is desired, here is how to do it:
        
            (setq org-latex-listings t) ;; As opposed to 'minted
            (add-to-list 'org-latex-listings-langs '(agda2 "Haskell"))

5.  `hyperref` setup

    The `LaTeX` `hyperref` package gives us better links.
    I don't care for varying link colours, so I set them all to
    the common blue colour.
    
        (setq org-latex-hyperref-template
          "\\hypersetup{
           pdfauthor={%a},
           pdftitle={%t},
           pdfkeywords={%k},
           pdfsubject={%d},
           pdfcreator={%c},
           pdflang={%L},
           colorlinks,
           linkcolor=blue,
           citecolor=blue,
           urlcolor=blue
           }
        "
        )

6.  More flexible tables

    Adding the `tabularx` package as a dependency gives us
    more flexible tables when we need them.
    See [the Org manual](https://orgmode.org/manual/Tables-in-LaTeX-export.html)
    for information on how to export tables as `tabularx` tables.
    
        (add-to-list 'org-latex-packages-alist
          '("" "tabularx"))

7.  Image handling

    I prefer to be explicit about how images are handled during export.
    So, I turn off some defaults of how they are handled in LaTeX.
    
    In particular, the LaTeX export backend by default
    wraps images in `center` blocks; but this breaks the ability
    to include images in tables.
    
        (setq org-latex-images-centered nil)
    
    :TODO: Is this setting wise?
    
        (setq org-latex-image-default-width nil)


### HTML export settings

1.  Change the “Created” postamble to “Last update”

    By default, `org-html-postamble` is set to `auto`.
    We overwrite that to `t` so that the postamble is constructed
    following the `org-html-postamble-format`, which we set.
    
        (setq org-html-postamble t)
        
        (setq org-html-postamble-format
         '(("en"
            "<p class=\"author\">Author: %a</p>
             <p class=\"author\">Contact: %e</p>
             <p class=\"date\">Original date: %d</p>
             <p class=\"date\">Last updated: %C</p>
             <p class=\"creator\">Created using %c</p>
             <p class=\"validation\">%v</p>")))

2.  Ensure useful HTML anchors

    This code snippet is borrowed from Musa's
    [init](https://github.com/alhassy/emacs.d/#Ensuring-Useful-HTML-Anchors).
    
    > Upon HTML export, each tree heading is assigned
    > an ID to be used for hyperlinks.
    > Default IDs are something like org1957a9d,
    > which does not endure the test of time:
    > Re-export will produce a different id.
    > Here's a rough snippet to generate IDs from headings,
    > by replacing spaces with hyphens, for headings without IDs.
    
    I have made several edits.
    
    -   Begin by deleting all custom IDs which have apparently
        been added by this process.
    -   At each step, get the list of custom IDs from earlier in the file;
        if the ID we intend to add at this step is in that list,
        add a counter to the end, incrementing it until the ID is unique.
    -   Do not assign the custom id if
        the heading is tagged with `:noexport:` or `:ignore:`;
        there's no point to adding one if the heading is not included
        in the export.
    
        (defun my/ensure-headline-ids (&rest _)
          "Org trees without a :CUSTOM_ID: property have the property
           set to be their headline.
        
           Trees whose headline are tagged with :ignore:
           are not given an ID.
        
           Trees whose headline are tagged with :noexport:
           and any subtrees of those trees are not given an ID.
        
           A prefix is used to identify IDs which were set by this process,
           so they can be recreated in case their headline changes.
           A postfix counter is used to prevent the case where
           trees cannot be linked to because they happen to share
           their heading with earlier trees.
          "
          (interactive)
          (let ((generated-ids ())
                (prefix "org-anchor-"))
            (cl-flet ((append-counter (x n) (concat x "^" (number-to-string n))))
              (org-map-entries
               (lambda ()
                 (let* ((heading-components (org-heading-components))
                        (headline (nth 4 heading-components))       
                        (tags     (nth 5 heading-components)))
                   (if (and tags (string-match-p (regexp-quote ":noexport:") tags))
                     ;; This heading is tagged as noexport.
                     ;; Set org-map-continue-from to next heading at this level.
                     ;; (Just moving to the next heading would not suffice;
                     ;;  children of this heading are also not exported.)
                     (setq org-map-continue-from (progn (org-goto-sibling)
                                                        (line-beginning-position)))
                     ;; Otherwise, check if this heading is tagged as ignore.
                     (unless (and tags (string-match-p (regexp-quote ":ignore:") tags))
                       ;; Otherwise, we want to check this heading's custom ID.
                       (let ((id (org-entry-get nil "CUSTOM_ID")))
                         ;; If `id` was not found, or if it seems to have been generated by this function,
                         ;; proceed to generate a new custom ID.
                         (unless (and id (not (string-prefix-p prefix id)))
                           ;; Create the id. Concatenate the prefix...
                           (let ((new-id (concat prefix
                                             ;; ...with this heading's headline
                                             ;; (note spaces are not allowed in links;
                                             ;; substitute dashes for any found.)
                                             (s-replace " " "-" headline))))
                                  (push new-id generated-ids)
                             ;; Finally, add a counter of the number of
                             ;; previous occurrences of this id, to prevent repetition.
                             (let ((unique-id (append-counter
                                                new-id 
                                                (seq-count (lambda (x) (string-equal x new-id))
                                                           generated-ids))))
                               (org-entry-put nil "CUSTOM_ID" unique-id)))))))))))))
        
        ;; Whenever html & md export happens, ensure we have headline ids.
        (advice-add 'org-html-export-to-html :before 'my/ensure-headline-ids)
        (advice-add 'org-md-export-to-markdown :before 'my/ensure-headline-ids)


### Additional export formats

1.  `org-reveal`

    I make use of `org-reveal` to create `reveal.js` slide decks.
    This is way easier than dealing with `beamer` in LaTeX,
    and results in much more attractive and better organised slides.
    
        (use-package ox-reveal)
    
    If we're somewhat lazy, we to could keep
    a local copy of the `reveal.js` packages,
    and then point to it with the `org-reveal-root` variable.
    More proactively, we can include the repo as a subrepo
    of whatever project we're working on.
    :TODO: Add instructions on how to do that here.
    
    1.  Theme
    
        `reveal.js` comes with many themes; `black` is the current default
        at time of writing this. I set it just to be sure it stays consistent.
        
            (setq org-reveal-theme "black")
        
        At the time of writing, the included themes are
        
        -   `black`: Black background, white text, blue links
        -   `white`: White background, black text, blue links
        -   `league`: Gray background, white text, blue links
        -   `beige`: Beige background, dark text, brown links
        -   `sky`: Blue background, thin dark text, blue links
        -   `night`: Black background, thick white text, orange links
        -   `serif`: Cappuccino background, gray text, brown links
        -   `simple`: White background, black text, blue links
        -   `solarized`: Cream-colored background, dark green text, blue links
        
        (list from the [`reveal.js` github](https://github.com/hakimel/reveal.js/#theming)).
    
    2.  Title page
    
        The default title slide includes title and date, with the formatting
        
            <h1 class="title">%t</h1>
            <p class="date">Created: %d/p>
        
        where `%t` stands for the document title and `%d` stands for the date.
        
        I prefer a slightly smaller title, and additionally include
        
        -   the author name (`%s`) and
        -   the author email (`%a`).
        
            (setq org-reveal-title-slide
              "<h2 class=\"title\">%t</h2>
               <h3>%s</h3>
               <h4>%a</h4>
               <h5>%d</h5>")

2.  `ox-pandoc`

    `ox-pandoc` is “another exporter that translates Org-mode file to various other
    formats via Pandoc”.
    
    I don't make much use of it, but it more flexible, and so has
    lots of options which make be useful in the future.
    
        (use-package ox-pandoc)


### Export markdown blocks as HTML

If we are given some markdown we wish to place into an Org file,
we can of course convert it to Org and place it appropriately.

If we're only interested in exporting to HTML, though,
we can more easily just put the markdown into a `markdown` `src` block,
and it can automatically be evaluated into HTML.

Note the result will not be visible in PDF exports!

For the basic process,
see <https://christiantietze.de/posts/2020/10/org-babel-markdown-to-html/>

First, we need Org babel functions for markdown;
apparently, this ten-year old (at time of writing) code
—<https://github.com/tnoda/ob-markdown/blob/master/ob-markdown.el>—
that does not seem to be in a package repository is
the best candidate.

    (require 'ob-markdown)

Now we instruct Org mode to, by default,
wrap the results of evaluating `markdown` blocks in `example html` blocks,
and then export those results.
Again, note that nothing will show up in LaTeX exports!

    (add-to-list 'org-babel-default-header-args:markdown
                 '(:results . "output verbatim html"))
    (add-to-list 'org-babel-default-header-args:markdown
                 '(:exports . "results"))


<a id="org1e2d958"></a>

## A completion framework; Ivy, Counsel and Swiper

:TODO: Better documentation here.


### Ivy

    (use-package ivy
      :config
      (ivy-mode 1)

Add recent files and bookmarks to `ivy-switch-buffer`.

    (setq ivy-use-virtual-buffers t)

Display both the index and the count in the current candidate count.

    (setq ivy-count-format "(%d/%d) ")

Enable minibuffer commands in the minibuffer.

    (setq enable-recursive-minibuffers t)

    )


### Swiper

    (use-package swiper
      :config
      ;; (global-set-key "\C-r" 'swiper)
      (global-set-key (kbd "C-s") 'swiper))


### Counsel

:TODO: Move keybindings to General settings.

    (use-package counsel
     :config
      (global-set-key (kbd "M-x") 'counsel-M-x)
      (global-set-key (kbd "C-x C-f") 'counsel-find-file))


### Prescient

> `prescient.el` is a library which sorts and filters lists of candidates,
> such as appear when you use a package like Ivy or Company.
> Extension packages such as `ivy-prescient.el` and `company-prescient.el` adapt
> the library for usage with various frameworks.

In particular, I like to have recently run invoked commands appear
as the first suggestions when I use `M-x`.

    (use-package prescient)
    (use-package ivy-prescient)
    (ivy-prescient-mode)


<a id="org86c4901"></a>

## COMpleting ANYthing; Company

:TODO: Review these settings, and consider reformatting to avoid open parenthese across codeblocks.

Install `company` and set it to be used everywhere.

    (use-package company
      :diminish
      :config
      (global-company-mode 1)
      (setq

I do find it convenient to require few characters before
getting autocomplete suggestions, but on my Chromebook
that slows things down far too much.
Let's require 4 characters before suggestions are provided.

    company-minimum-prefix-length 4

Search buffers using the same major mode for completion candidates.
Setting `all` instead would search all buffers.

    company-dabbrev-other-buffers t
    company-dabbrev-code-other-buffers t

Sort candidates by importance, then case, then in-buffer frequency.

    company-transformers '(company-sort-by-backend-importance
                           company-sort-prefer-same-case-prefix
                           company-sort-by-occurrence)

Align any annotations to completions to the right.

    company-tooltip-align-annotations t

Annotate the completions with numbers.
We can select an annotation with `M-num` instead
of navigating to it.

    company-show-numbers t

Show up to ten candidates in a tooltip.
When we get to the bottom of the list, wrap.

    company-tooltip-limit 10
    
    company-selection-wrap-around t

Don't downcase by default,
but if I choose a completion with different casing
than my prefix, change the prefix casing.

    company-dabbrev-downcase nil
    company-dabbrev-ignore-case nil

Pause very briefly before offering completion.
This way if I am typing quickly it does not try to interrupt.

    company-idle-delay 0.2)

Rebind the controls for completion.
I find using `return` distruptive, as often I mean to insert a newline
instead of complete a suggestion.
Use `tab` instead.
Also, if documentation is available, `C-d` accesses it
in a new temporary buffer.

    :bind (:map company-active-map
                ;; Don't complete on return.
                ("<return>" . nil) ("RET" . nil)
                ;; Use tab instead.
                ("<tab>" . company-complete-selection)
                ("C-d" . company-show-doc-buffer))) 

Pop up a tooltip when I hover on a completion that has documentation.

    (use-package company-quickhelp
     :config
       (setq company-quickhelp-delay 0.1)
       (company-quickhelp-mode))

Add emoji support. For instance, `:smile:` completes to 😄.

    (use-package company-emoji
      :config (add-to-list 'company-backends 'company-emoji))


<a id="orgc1eda75"></a>

## Snippets

I use `yasnippets` for text expansion, and `yankpad` to organise my
snippets.

For inserting snippets, we require string manipulation functions
from the `subr-x` package (built-in).

    (require 'subr-x)

    (use-package yasnippet)
    (yas-global-mode t)
    
    (use-package yankpad)
    (setq yankpad-file "~/dotfiles/emacs/yankpad.org")

Ignore major mode, always use defaults.
Yankpad will freeze if no org heading has the name of the given category.

    (setq yankpad-category "Default")

`yas-wrap-around-region` controls what is inserted for a snippet's
`$0` field. A non-nil, non-character setting has it insert the
current region's contents (i.e. if we highlight a region and
invoke a snippet, the region will be wrapped).

    (setq yas-wrap-around-region t)

`yas-indent-line` controls how inserted snippets are inserted.
`fixed` indicates the snippet should be indented to the column at point.
`auto` instead causes each line to be indented using `indent-according-to-mode`.
I set it to fixed because this is usually what I want; I know best, not the mode.

    (setq yas-indent-line 'fixed)


### Interacting with Company

Taken without additional commentary for now from Musa's init.

    ;; Add yasnippet support for all company backends
    ;;
    (cl-defun my/company-backend-with-yankpad (backend)
      "There can only be one main completition backend, so let's
       enable yasnippet/yankpad as a secondary for all completion
       backends.
    
       Src: https://emacs.stackexchange.com/a/10520/10352"
    
      (if (and (listp backend) (member 'company-yankpad backend))
          backend
          (append (if (consp backend) backend (list backend))
                  '(:with company-yankpad))))
    
    ;; Set company-backend as a secondary completion backend to all existing backends.
    (setq company-backends (mapcar #'my/company-backend-with-yankpad company-backends))


<a id="orgcb44cd5"></a>

## Previewing before undoing; `undo-propose`

The `undo-propose` package is a fairly minimal addition to
the builtin undo features of Emacs
(which can be confusing, but are very powerful,
 since undo-ing is an action which can be undone.)
What `undo-propose` does is open a new, read-only buffer
in which the undoing is to be done
(`undo` and `undo-only` are wrapped so as to be allowed,
 although the buffer is read-only.)
It provides commands to

-   overwrite the original buffer,
    -   either as a single (squashed) action (`C-c C-s`),
    -   or as the chain of undo actions performed (`C-c C-c`),
-   run a diff against the original buffer (`C-c C-d`), or
-   be discarded entirely (`C-c C-k`.)

    (use-package undo-propose)

In the past, I have used `undo-tree` to visualise
the changes to a file as a tree,
allowing movement up and down branches as a local sort
of version control.
But the actual visualisation can sometimes cause lag,
and `undo-tree` has been known to cause corruptions
when undoing/redoing (though I have not experienced this personally.)
For the moment, I will stick to the builtin undo behaviour,
with `undo-propose` to help visualise the changes.


<a id="org416e12c"></a>

# Final cosmetics


<a id="org16f04f0"></a>

## Modeline styling

While I don't use Spacemacs, I do like it's sleek modeline.

    (use-package spaceline)

Using `spaceline-emacs-theme` instead
of `spaceline-spacemacs-theme` is supposed to improve compatibility.

    (spaceline-emacs-theme)


### Colour the modeline

This setting changes the colour of the start of the modeline
when the file has been modified and not saved,
a nice subtle reminder to save.

    (setq spaceline-highlight-face-func
      'spaceline-highlight-face-modified)

In fact, let's make that colouring constant across themes.

    (custom-theme-set-faces
     'user
     ;; The active buffer has a fairly vibrant blue modeline
     '(mode-line         ((t (:foreground "black"
                              :background "DeepSkyBlue1"))))
     '(powerline-active0 ((t (:foreground "black"
                              :background "DeepSkyBlue2"))))
     '(powerline-active1 ((t (:foreground "black"
                              :background "DeepSkyBlue3"))))
     '(powerline-active2 ((t (:foreground "black"
                                 :background "DeepSkyBlue4"))))
    
     ;; The inactive buffers have less vibrant gray/blue modelines
     '(mode-line-inactive  ((t (:foreground "black"
                                :background "LightSkyBlue1"))))
     '(powerline-inactive0 ((t (:foreground "black"
                                :background "LightSkyBlue2"))))
     '(powerline-inactive1 ((t (:foreground "black"
                                :background "LightSkyBlue3"))))
     '(powerline-inactive2 ((t (:foreground "black"
                                 :background "LightSkyBlue4"))))
    
     ;; Highlighting based on save status of buffer
     '(spaceline-unmodified ((t (:foreground "black"
                                 :background "green1"))))
     '(spaceline-modified   ((t (:foreground "black"
                                 :background "gold1"))))
     '(spaceline-read-only  ((t (:foreground "black"
                                 :background "seashell1")))))
    (powerline-reset)


<a id="orgb8d0764"></a>

## Flash on error

The doom themes package comes with a function to make
the mode line flash on error.

    (use-package doom-themes)
    (require 'doom-themes-ext-visual-bell)
    (doom-themes-visual-bell-config)

I'd previously just used `visible-bell`, but it's a bit nosier
than necessary.


<a id="org89d2cfa"></a>

## Diminish minor mode names

I use a lot of minor modes, so the mode list takes up a lot
of space on the mode line.

`diminish` alleviates this by allowing us to hide modes
or give them shorter names.

    (use-package diminish)

I don't need to see that these modes are active.

    (eval-after-load "yas-minor-mode" '(diminish 'yas-minor-mode))
    (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
    (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
    (eval-after-load "which-key" '(diminish 'which-key-mode))
    (eval-after-load "org-indent" '(diminish 'org-indent-mode))

:TODO: Add more modes to diminish, consider giving some briefer names instead.q

If later I want to rename modes, just add a string argument
to the above form with a (presumably shorter) name.


<a id="org8485938"></a>

## Kill the open init buffer and reopen it

To ensure all these cosmetic changes are picked up,
kill my init buffer that we opened earlier and reopen it.

    (kill-buffer "emacs-init.org")
    (find-file my/emacs-init-file)


<a id="orgda3e698"></a>

# Final modes and final mode-specific settings


<a id="orgf56919f"></a>

## Org mode


### Speed keys

Speed keys are single keystrokes which execute commands in an
`org` file when the cursor is at the start of a headline.
They are particularly useful for quickly moving a headline around,
or promoting/demoting a headline (and all children headlines accordingly.)

    (setq org-use-speed-commands t)

To see the commands available, execute

    (org-speed-command-help)


### Automatic tables of contents

This package provides automatic maintainance of a table of contents
under any heading which is labelled with the `:TOC:` tag.

    (use-package toc-org
      ;; Automatically update toc when saving an Org file.
      :hook (org-mode . toc-org-mode))


### Custom TODO keywords

These words, when appearing at the start of a headline,
mark that headline as a TODO task in the appropriate state.
I've added `SOON`, `NEXT`, `WORKING`, `DELEGATED` and `CANCELLED`.

    (setq org-todo-keywords
      '((sequence "TODO" "SOON" "NEXT" "WORKING" "|" "DELEGATED" "CANCELLED" "DONE")))


### Allow alphabetical lists

While not frequently that useful, it is nice to be allowed
to label list items alphabetically.
Note that the labels used in the plaintext Org do not affect the labels
used in most export formats (at least HTML and LaTeX.)

    (setq org-list-allow-alphabetical t)


<a id="org56116b9"></a>

## `dired`

`dired` (for DIRectory EDitor) is Emacs builtin utility
for browsing directories and operating on their contents.

Herein are my (fairly minimal) modifications to its behaviour.


### File information

`dired` makes use of switches for `ls`.

I like the following switches:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left"><code>--group-directories-first</code></td>
<td class="org-left">group directories before files</td>
</tr>


<tr>
<td class="org-left"><code>-a</code></td>
<td class="org-left">do not ignore entries starting with .</td>
</tr>


<tr>
<td class="org-left"><code>-B</code></td>
<td class="org-left">do not list implied entries ending with ~</td>
</tr>


<tr>
<td class="org-left"><code>-g</code></td>
<td class="org-left">long listing format, but do not list owner</td>
</tr>


<tr>
<td class="org-left"><code>-G</code></td>
<td class="org-left">in a long listing, don't print group names</td>
</tr>


<tr>
<td class="org-left"><code>-h</code></td>
<td class="org-left">print human readable size</td>
</tr>


<tr>
<td class="org-left"><code>-L</code></td>
<td class="org-left">show information for <i>references</i> rather than symbolic links</td>
</tr>
</tbody>
</table>

    (setq dired-listing-switches
          "--group-directories-first -aBDgGhL --time-style \"+  %Y %b %d %H:%M  \"")


### Cosmetic

Don't display whitespace information via `whitespace-mode` in Dired buffers.

    (add-hook 'dired-mode-hook
      (lambda ()
         (setq-local whitespace-style nil)))

Highlighting the whole line we're on helps keep track of what file
the cursor is on.

    (add-hook 'dired-after-readin-hook 'hl-line-mode)


<a id="org34a8ace"></a>

## `eshell`

The Eshell is a wonderful shell-like command interpreter inside of Emacs.
I find it's not appropriate for intensive command line tasks,
but it's nice not to have to leave Emacs for simple tasks.
(Note there are alternatives for this purpose, including
 popping up an external shell inside of Emacs.)

    (use-package eshell)

Jeremias Queiroz posted a “fancy eshell prompt” setup on [Reddit](https://www.reddit.com/r/emacs/comments/6f0rkz/my_fancy_eshell_prompt/),
from which I derived this setup, but I've modified it to use
builtin face colours to improve portability across themes.
For instance, the `default` colour will most likely be white
for dark themes and black for light themes.

    (setq eshell-prompt-function
      (lambda ()
        (let ((default  (face-attribute 'default :foreground))
              (green    (face-attribute 'success :foreground))
              (red      (face-attribute 'error   :foreground))
              (blue     (face-attribute 'link    :foreground))
              (yellow   (face-attribute 'warning :foreground)))
        (concat
        (propertize "┌—["                 'face  `(:foreground ,green))
        (propertize (user-login-name)     'face  `(:foreground ,red))
        (propertize "@"                   'face  `(:foreground ,blue))
        (propertize (system-name)         'face  `(:foreground ,red))
        (propertize "]──["                'face  `(:foreground ,green))
        (propertize (format-time-string "%a %b %d" (current-time)) 'face `(:foreground ,yellow))
        (propertize "]──["                'face `(:foreground ,green))
        (propertize (format-time-string "%H:%M" (current-time)) 'face `(:foreground ,yellow))
        (propertize "]\n"                 'face `(:foreground ,green))
        (propertize "│ "                  'face `(:foreground ,green))
        (propertize (concat (eshell/pwd)) 'face `(:foreground ,blue))
        (propertize "\n"                  'face `(:foreground ,green))
        (propertize "└─►"                 'face `(:foreground ,green))
        (propertize (if (= (user-uid) 0) " # " " $ ") 'face `(:foreground ,default))))))


<a id="orgf7f1355"></a>

## `which-key`

`which-key-mode` is a handy minor mode that shows us
possible completions as we type commands.
Very useful if you remember only a prefix of the command,
not the whole thing.

    (use-package which-key)
    (which-key-mode)

It is also useful for discovery of shortcuts;
occasionally it is enlightening to take some time
and browse the possible completions of prefixes as you type.


<a id="orgb2762e2"></a>

## `winner-mode`

`winner-mode` allows us to undo or redo changes to window layouts.
See my keybindings for this above.

    (winner-mode 1)


<a id="orgcbee3c6"></a>

## `windmove`

The package `windmove` lets us jump between windows in a frame.

    (use-package windmove)

For the uninitiated, a *window* in Emacs is not the same as
the OS window. Each OS window is a *frame*, and each pane within
a frame is called a *window*. (Emacs predates modern terminology).

`windmove` lets us move between windows with the arrow keys
while holding a key; by default, the key is `shift`.
That conflicts with `org` though, so we could use
`windmove-default-keybindings` to change it.

Unfortunately, on my system, all the other possibilities seem
to be taken with system shortcuts (which I cannot modify in ChromeOS),
or otherwise taken in Emacs.

So instead I've defined shortcuts using `general` above.


<a id="orgcd9a8a8"></a>

## Ediff

By default, when using the GUI, Ediff opens a new frame for
the controls for the Ediff session.
I typically use Emacs in fullscreen, and this additional frame
is usually unwelcome. Instead, use a window in the current frame.

    (setq ediff-window-setup-function 'ediff-setup-windows-plain)

I prefer to see the files being compared side by side,
rather than split vertically.

    (setq ediff-split-window-function 'split-window-horizontally)


<a id="orgb38fab1"></a>

## `magit`

Explicitely install `magit`, “a Git Porcelain inside Emacs”.
This is a killer feature of Emacs; `magit` not only simplifies
interation with Git, it also expands our capabilities
in many ways over the CLI.
:TODO: Explain some here or link to some examples?

    (use-package magit)

“Forge allows you to work with Git forges, such as Github and Gitlab,
from the comfort of Magit and the rest of Emacs.” 

    (use-package forge
      :after magit)


<a id="orge14d78c"></a>

## Purescript

    (use-package purescript-mode)


<a id="orgd165e45"></a>

# Session setup

First, we opened my init file earlier;
kill that buffer now, so that cosmetic changes we made above
will be properly applied (when we reopen it).

    (kill-buffer "emacs-init.org")


<a id="orgb67e1ae"></a>

## Filepaths

For maintainability, most files opened below
are listed here.

    (setq-local my/log-dir   "~/logs/")
    (setq-local my/scratch-dir "~/logs/scratch/")
    (setq-local my/dotfiles-dir "~/dotfiles/")
    (setq-local my/emacs-dir (concat my/dotfiles-dir "emacs/"))
    (setq-local my/agda-dir  "~/Dropbox/McMaster/Agda/")
    
    (setq-local my/emacs-init   (concat my/emacs-dir "emacs-init.org"))
    (setq-local my/yankpad-file (concat my/emacs-dir "yankpad.org"))
    
    (setq-local my/supervisor-log (concat my/log-dir "supervisors.org"))
    (setq-local my/todo (concat my/log-dir "todo.org"))
    
    (setq-local my/org-scratch  (concat my/scratch-dir "org-scratch.org"))
    (setq-local my/agda-scratch (concat my/agda-dir "agda-scratch.agda"))


<a id="org602ad44"></a>

## Create tabs

First, let's create some “consistent” tabs;
whatever projects I am working on, these tabs
will always be present.

-   First, of course, is my Emacs init.
-   Second, my Emacs init again, alongside a `magit` buffer for it.
-   Second, my Org log and my email.
-   Third, an `eshell` instance (separate from the one
    invoked by my `eshell` shortcut).

    (tab-rename "init")
    (tab-new)
    (tab-rename "dotfiles ꇚ")
    (tab-new)
    (tab-rename "Logs")
    (tab-new)
    (tab-rename "email")
    (tab-new)
    (tab-rename "eshell")

Now, setup for some projects I am currently working on;
this section is volatile!

    (tab-new)
    (tab-rename "Thesis")
    (tab-new)
    (tab-rename "Thesis ꇚ")
    (tab-new)
    (tab-rename "Blog")
    (tab-new)
    (tab-rename "Blog ꇚ")

Finally, open a few “blank” tab as the rightmost,
for use when working on other/random things.

    (tab-new)
    (tab-rename "-")
    (tab-new)
    (tab-rename "-")
    (tab-new)
    (tab-rename "-")


<a id="orga9d49bd"></a>

## Visit tabs and setup buffers

Now, let us visit the tabs, and set up the windows in them.
Since they're named (presumably uniquely),
we'll use `tab-bar-switch-to-tab` which takes a `name` argument.

My `cascading-find-files` sometime comes in handy here.


### Consistent tabs

First, the `init` tab.
Here I want my Emacs init in my usual three window split
(two vertically split windows on the left, large single window on the right),
with the messages buffer on the lower left
and a help buffer preemptively opened in the upper right.

    (tab-bar-switch-to-tab "init")
    (find-file my/emacs-init)
    (split-window nil nil 'left)
    ; describe symbol will use the window not in focus, so the left
    (describe-symbol 'describe-symbol)
    ; switch to the help window on the left
    (other-window 1)
    (split-window nil nil 'above)
    (switch-to-buffer "*Messages*")

My init file is part of my `dotfiles` repository.
In the tab for managing that repo,
I want my Emacs init on the left a magit buffer on the right.

    (tab-bar-switch-to-tab "dotfiles ꇚ")
    (find-file my/emacs-init)
    (split-window nil nil 'right)
    (magit-status-setup-buffer)

The `Logs` tab is similar, but has my supervisory report log
on the left and 
and my inbox on the right.

    (tab-bar-switch-to-tab "Logs")
    (find-file my/supervisor-log)
    (split-window nil nil 'left)
    ;;(find-file my/todo)

The `email` tab has a scratch file on the left
and my inbox on the right.

    (tab-bar-switch-to-tab "email")
    (find-file my/org-scratch)
    (split-window nil nil 'left)
    (mu4e-headers-search-bookmark (mu4e-get-bookmark-query ?i))

In the `Shell` tab, create buffers for three `eshell` instances
in the usual configuration. By passing a numeric argument,
we get unique buffers.

    (tab-bar-switch-to-tab "eshell")
    (eshell '3)
    (split-window nil nil 'right)
    (eshell '2)
    (split-window nil nil 'below)
    (eshell '1)


### Volatile tabs

1.  Thesis

    My thesis involves Agda, so I want the Agda information buffer open.
    I prefer that information buffer in the lower left,
    the master file in the upper left, and the thesis directory on the right.
    The `git` tab is setup the same way the `Setup ꇚ` tab is.
    
        (let ((thesis-dir "~/projects/agda-computability/"))
          (let ((thesis-master (concat thesis-dir "thesis-master.org")))
            (tab-bar-switch-to-tab "Thesis")
            (find-file thesis-dir)
            (split-window nil nil 'right)
            (find-file thesis-master)
            (split-window nil nil 'above)
            (switch-to-buffer (agda2-info-buffer))
        
            (tab-bar-switch-to-tab "Thesis ꇚ")
            (find-file thesis-master)
            (split-window nil nil 'right)
            (magit-status-setup-buffer)))

2.  Blog (and personal website)

    For the moment, my `Blog` tab setup is similar to the thesis setup,
    because I blog about Agda.
    
        (let ((github-io-dir "~/projects/armkeh.github.io/"))
          (let ((github-io-main (concat github-io-dir "index.org")))
            (tab-bar-switch-to-tab "Blog")
            (find-file github-io-dir)
            (split-window nil nil 'right)
            (find-file github-io-main)
            (split-window nil nil 'above)
            (switch-to-buffer (agda2-info-buffer))
        
            (tab-bar-switch-to-tab "Blog ꇚ")
            (find-file github-io-main)
            (split-window nil nil 'right)
            (magit-status-setup-buffer)))


### Focus on the first tab

    (tab-select 1)


<a id="orgc9a3890"></a>

# Cleanup


<a id="org70b235c"></a>

## Check the contents of the (proper/system) init file

It is not uncommon for the Emacs init file to be modified
without my direct action;
either because of some setting change
I consent to without thinking about it,
or some well-meaning process making a change I presumably want.

It is for that reason that this file is not directly tangled to `~/.emacs`.
Erasing those changes by re-writing the content
of that file every time I start Emacs is probably not what I actually want.

That said, I should be made aware of the fact that a change has been made;
either I will want to just undo the settings, or more likely, I will want
to migrate them to their proper place in this file.

Using the copy of the expected `.emacs` content which is tangled to `/tmp/.emacs` above,
this code checks the contents of `~/.emacs`. If it is not as expected,
show a popup message and then displays a diff buffer to alert me to the changes.

    (let* ((dotemacs-file "~/.config/emacs/init.el")
           (dotemacs-backup "/tmp/init.el")
           (dotemacs-contents
            (with-temp-buffer
              (insert-file-contents dotemacs-file)
              (buffer-string)))
           (dotemacs-expected
            (with-temp-buffer
              (insert-file-contents dotemacs-backup)
              (buffer-string))))
      (unless (equal dotemacs-contents dotemacs-expected)
        (message-box "~/.config/emacs/init.el content has been modified from my expected contents!\n\nOpening a diff buffer.")
        (diff dotemacs-file dotemacs-backup)))

Some notes about this:

-   I initially attempted to accomplish this comparison by somehow
    comparing the text of the Emacs init file to the text of the
    `src` block above directly, avoiding the need to tangle that block to `/tmp`.
    Unfortunately, I couldn't find a satisfying way to obtain the text
    of the `src` block in this file as a string.
    -   Copying it manually raises issues if it ever changes, of course.
    -   I could use noweb syntax to place its contents into this `src` block,
        but I could not make it a string, as it contains double quotes,
        and Emacs lacks a form for string literals.
        -   I could convert it to a string using the `string` function,
            but then comments would be lost. I followed this line briefly anyway,
            trying to read in the contents of Emacs init file as Elisp code,
            and then compare the code instead of comparing strings.
            This gets a bit too complicated though and makes
            the difference reporting less satisfying, as it cannot show
            the actual file contents.


<a id="org05e3eaa"></a>

## Update the `README` file

I want my `README.md` file for this directory
to be automatically kept up to date when changes are made.
To that end, we create both a `README.org` file
and include in this init file code to export
that `README.org` to a `README.md` file.

First, the `README.org` is tangled from here.
Note that this by itself is not sufficient to act as the README;
the `include` command will not be honoured by GitHub's Org rendering.
So this file is just an inbetween to allow us to export
the `README.md` file.
(We could overwrite `README.org` instead, if we prefer
 to stick entirely to Org; since it's automated,
 I don't mind using Markdown.)

    #+Options: toc:nil
    
    # This file is tangled from emacs-init.org,
    # and should not be modified directly.
    
    This directory contains the files that make up my Emacs setup.
    
    Below are the contents of my literate Emacs initialisation file.
    
    See also my
    - [[./yankpad.org][Yankpad snippets file]]
      - (Frequently used text expansions.)
    
    #+TOC: headlines 2
    
    #+include: ~/dotfiles/emacs/emacs-init.org

Now, we include in this file code
to automatically export the `README.org` file to `README.md`;
this will run every time Emacs starts,
keeping the README up to date.
I will notice the file has changed when checking the Git repo status,
an regularly commit the changes.

    (let* ((readme-directory "~/dotfiles/emacs/")
           (readme-org (concat readme-directory "README.org"))
           (readme-md  (concat readme-directory "README.md")))
      (with-temp-buffer
        ;; We need to visit the Org readme; we will want to close it afterwards
        ;; unless we were already visiting it.
        (let ((was-already-visiting-org (find-buffer-visiting readme-org))
              (was-already-visiting-md  (find-buffer-visiting readme-md)))
          (find-file readme-org)
          ;; Export it to a new buffer; exporting expands the included files.
          (org-md-export-as-markdown)
          ;; At the top, place a warning not to edit the file.
          (beginning-of-buffer)
          (insert "<!-- This file is tangled from README.org,\n")
          (insert "     which itself is tangled and imports from emacs-init.org.\n")
          (insert "     This file should not be modified directly.-->\n\n")
          ;; Now write it to a file.
          (write-file "~/dotfiles/emacs/README.md")
          ;; And clean up.
          (unless was-already-visiting-org
            (kill-buffer (find-buffer-visiting readme-org)))
          (unless was-already-visiting-md
            (kill-buffer (find-buffer-visiting readme-md))))))


<a id="org848b85b"></a>

## Prompt before quitting Emacs

It's rare that I actually want to close Emacs, so it's not an annoyance
to prompt first; in fact, it's much preferred to accidentally closing.

    (setq confirm-kill-emacs 'yes-or-no-p)

Note that the prompt is skipped if we already have a “do `x` before exiting?”
prompt, such as for saving some files.

This is the very last setting, because if we don't make it this far,
I want to be able to fix the error that stopped us reaching here
and quit without being hassled.

