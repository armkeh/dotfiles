(letrec ((log-dir      "~/logs/")
         (scratch-dir  "~/logs/scratch/")
         (dotfiles-dir "~/dotfiles/")
         (projects-dir "~/projects/")
         (emacs-dir    (concat dotfiles-dir "emacs/"))

         (emacs-init   (concat emacs-dir "emacs-init.org"))
         (yankpad-file (concat emacs-dir "yankpad.org"))

         (scratch (concat log-dir "scratch/scratch.org"))

         (dotfiles-tab-name "dotfiles")
         (logs-tab-name     "logs")
         (mail-tab-name     "mail")
         (homepage-tab-name "homepage"))

(tab-rename dotfiles-tab-name)
(tab-new)
(tab-rename logs-tab-name)
(tab-new)
(tab-rename mail-tab-name)
(tab-new)
(tab-rename homepage-tab-name)

(tab-new)
(find-file projects-dir)
(tab-rename "🚧")
(tab-new)
(find-file projects-dir)
(tab-rename "🏗️")
(tab-new)
(find-file projects-dir)
(tab-rename "👷")
(tab-new)
(find-file projects-dir)
(tab-rename "🛠️")

(tab-bar-switch-to-tab dotfiles-tab-name)
(find-file emacs-init)
(split-window nil nil 'right)      ; Normally would use `left' to leave the right in focus, but...
(describe-symbol 'describe-symbol) ; describe symbol will use the window not in focus.
(other-window 1)                   ; Switch to the help buffer on the right.
(split-window nil nil 'above)
(switch-to-buffer "*Messages*")
(other-window 1) ; Put focus on init file

(tab-bar-switch-to-tab logs-tab-name)
(find-file log-dir)
(split-window nil nil 'left)
(find-file log-dir)
(split-window nil nil 'above)
(find-file scratch)
(other-window 1)

(tab-bar-switch-to-tab mail-tab-name)
(with-demoted-errors "Error starting mu4e during session setup: %s"
  (mu4e))
(split-window nil nil 'right)
(find-file scratch)

(let ((github-io-dir "~/projects/armkeh.github.io/"))
  (let ((github-io-main (concat github-io-dir "index.org")))
    (tab-bar-switch-to-tab homepage-tab-name)
    (find-file github-io-main)
    (split-window nil nil 'right)
    (magit-status-setup-buffer)))

(tab-select 1)

)
