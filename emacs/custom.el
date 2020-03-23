(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bibtex-completion-bibliography "~/Dropbox/McMaster/references.bib")
 '(custom-safe-themes
   '("6edf762b89c629f7f19571a1da2baae181bed8bb4733630efbee0903094a0b50" "c17157e15c1c1bfbff9692c32ffe22f28d8c85a45f59324c849764edeca69e60" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "fa3bdd59ea708164e7821574822ab82a3c51e262d419df941f26d64d015c90ee" "43c808b039893c885bdeec885b4f7572141bd9392da7f0bd8d8346e02b2ec8da" "e838d6375a73fda607820c65eb3ea1f9336be7bd9a5528c9161e10c4aa663b5b" "e3c87e869f94af65d358aa279945a3daf46f8185f1a5756ca1c90759024593dd" default))
 '(fci-rule-color "#62686E")
 '(jdee-db-active-breakpoint-face-colors (cons "#1c1f24" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1c1f24" "#7bc275"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1c1f24" "#484854"))
 '(objed-cursor-color "#ff665c")
 '(org-ref-default-bibliography '("~/Dropbox/McMaster/references.bib"))
 '(package-selected-packages
   '(counsel swiper xah-fly-keys modus-operendi modus-vivendi modus-operandi-theme modus-vivendi-theme all-the-icons helm auto-package-update toc-org typescript-mode rainbow-delimiters dimmer dimmer-mode auto-dim-other-buffers all-the-icons-dired org-bullets doom-modeline spaceline spaceline-config helm-bibtex org-ref unicode-fonts geiser yasnippet yankpad wordsmith-mode which-key use-package undo-tree racket-mode pdf-tools ox-tufte ox-reveal ox-pandoc org-plus-contrib org-mime magit htmlize general exwm emojify doom-themes dired-single diminish))
 '(pdf-view-midnight-colors (cons "#bbc2cf" "#242730"))
 '(reftex-default-bibliography '("~/Dropbox/McMaster/references.bib"))
 '(rustic-ansi-faces
   ["#242730" "#ff665c" "#7bc275" "#FCCE7B" "#51afef" "#C57BDB" "#5cEfFF" "#bbc2cf"])
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
           (lambda nil
             (save-to-drive "org"))
           nil 'local)
     (eval save-to-drive "Org")))
 '(toc-org-noexport-regexp
   "\\(^*+\\) +.*:\\(ignore\\|noexport\\)\\([@_][0-9]\\)?:\\($\\|[^ ]*?:$\\)" t)
 '(vc-annotate-background "#242730")
 '(vc-annotate-color-map
   (list
    (cons 20 "#7bc275")
    (cons 40 "#a6c677")
    (cons 60 "#d1ca79")
    (cons 80 "#FCCE7B")
    (cons 100 "#f4b96e")
    (cons 120 "#eda461")
    (cons 140 "#e69055")
    (cons 160 "#db8981")
    (cons 180 "#d082ae")
    (cons 200 "#C57BDB")
    (cons 220 "#d874b0")
    (cons 240 "#eb6d86")
    (cons 260 "#ff665c")
    (cons 280 "#d15e59")
    (cons 300 "#a35758")
    (cons 320 "#754f56")
    (cons 340 "#62686E")
    (cons 360 "#62686E")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "black" :background "DeepSkyBlue1"))))
 '(mode-line-inactive ((t (:foreground "black" :background "LightSkyBlue1"))))
 '(nobreak-space ((t (:underline t))))
 '(powerline-active0 ((t (:foreground "black" :background "DeepSkyBlue2"))))
 '(powerline-active1 ((t (:foreground "black" :background "DeepSkyBlue3"))))
 '(powerline-active2 ((t (:foreground "black" :background "DeepSkyBlue4"))))
 '(powerline-inactive0 ((t (:foreground "black" :background "LightSkyBlue2"))))
 '(powerline-inactive1 ((t (:foreground "black" :background "LightSkyBlue3"))))
 '(powerline-inactive2 ((t (:foreground "black" :background "LightSkyBlue4"))))
 '(show-paren-match ((t (:foreground "white" :background "black" :weight ultra-bold))))
 '(spaceline-modified ((t (:foreground "black" :background "gold1"))))
 '(spaceline-read-only ((t (:foreground "black" :background "seashell1"))))
 '(spaceline-unmodified ((t (:foreground "black" :background "green1"))))
 '(tab-bar ((t (:foreground "white" :background "DarkSlateGray4"))))
 '(tab-bar-tab ((t (:foreground "white" :background "DarkSlateGray3" :box (:line-width 1 :style released-button)))))
 '(tab-bar-tab-inactive ((t (:foreground "white" :background "DarkSlateGray4" :box (:line-width 1 :style released-button))))))
