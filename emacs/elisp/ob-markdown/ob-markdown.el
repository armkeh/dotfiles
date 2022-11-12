;;; ob-markdown.el --- org-babel functions for markdown evaluation

;; Copyright (C) 2012 Takahiro Noda

;; Author: Takahiro Noda
;; Keywords: literate programming, reproducible research
;; Homepage: https://gitbub.com/tnoda/ob-markdown/
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Org-Babel support for evaluating markdown code

;;; Requirements:

;; - markdown-mode

;;; Code:
(require 'ob)
(require 'ob-eval)
(require 'markdown-mode)
;; possibly require modes required for your language

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("markdown" . "text"))

;; optionally declare default header arguments for this language
(defvar org-babel-default-header-args:markdown '())

;; This function expands the body of a source code block by doing
;; things like prepending argument definitions to the body, it should
;; be called by the `org-babel-execute:markdown' function below.
(defun org-babel-expand-body:markdown (body params &optional processed-params)
  "Expand BODY according to PARAMS, return the expanded body."
  body)

(defun org-babel-execute:markdown (body params)
  "Execute a block of Markdown code with org-babel.  This function is
called by `org-babel-execute-src-block'."
  (message "executing Markdown source code block")
  (org-babel-eval markdown-command (org-babel-expand-body:markdown body params)))

;; This function should be used to assign any variables in params in
;; the context of the session environment.
(defun org-babel-prep-session:markdown (session params)
  "Return an error if the :session header argument is Set.
Markdown does not support sessions."
  (error "Markdown sessions are nonsensical."))

(provide 'ob-markdown)
;;; ob-markdown.el ends here
