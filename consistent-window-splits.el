;;; consistent-window-splits.el --- Consistent window splitting regardless of frame size  -*- lexical-binding: t -*-

;; Copyright (C) 2025  Mark Armstrong

;; Author: Mark Armstrong <markparmstrong@gmail.com>
;; Maintainer: Mark Armstrong <markparmstrong@gmail.com>
;; Homepage: https://github.com/armkeh/consistent-window-splits
;; Keywords: window resizing
;; Package-Version: 0.0.1
;; Package-Requires: ((emacs "24.1"))

;; This file is NOT part of GNU Emacs.

;; consistent-window-splits is free software; you can redistribute it
;; and/or modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; consistent-window-splits is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied warranty
;; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with consistent-window-splits.el. If not, see
;; <http://www.gnu.org/licenses>.

;;; Commentary:

;; consistent-window-splits is a package that enforces consistent
;; window splitting regardless of frame size.
;; See the project's README.md file for more details.

;;; Code:

(defconst consistent-window-splits--default-split-height-threshold split-height-threshold
  "Default minimum height for splitting windows sensibly;
set from `split-height-threshold' at package load time.")

(defconst consistent-window-splits--default-split-width-threshold split-width-threshold
  "Default minimum width for splitting windows sensibly;
set from `split-width-threshold' at package load time.")

(defun consistent-window-splits-set (min-width min-height &optional width-threshold height-threshold)
  (when min-width (setq window-min-width min-width))
  (when min-height (setq window-min-height min-height))
  (when width-threshold (setq split-width-threshold width-threshold))
  (when height-threshold (setq split-height-threshold height-threshold)))

(defun consistent-window-splits-prevent-vertical-splits ()
  (interactive)
  (setq split-height-threshold nil))

(defun consistent-window-splits-prevent-horizontal-splits ()
  (interactive)
  (setq split-width-threshold nil))

;; The following functions are temporary placeholders based on my own preferences.
;; They will be replaced by more general functions based on dividing
;; the frame size by given amounts (i.e., by 2 for 2 rows/ columns,
;; 3 for 3 rows/columns, etc.).

(defun consistent-window-splits-set:laptop ()
  "Set the window minimum width and split behaviour to
discourage vertical splits, and prevent more than one
horizontal split on a laptop-sized screen."
  (interactive)
  (message "Screen splitting behaviour optimized for laptops")
  (consistent-window-splits-prevent-vertical-splits)
  (consistent-window-splits-set 70 nil 100 nil))

(defun consistent-window-splits-set:wide ()
  "Set the window minimum width and split behaviour to
discourage vertical splits, and prevent more than one
horizontal split on a wide screen."
  (interactive)
  (message "Screen splitting behaviour optimized for widescreen monitors")
  (consistent-window-splits-prevent-vertical-splits)
  (consistent-window-splits-set 125 nil 200 nil))

(defun consistent-window-splits-set:ultrawide ()
  "Set the window minimum width and split behaviour to
discourage vertical splits, and prevent more than one
horizontal split on an ultrawide screen."
  (interactive)
  (message "Screen splitting behaviour optimized for ultrawide monitors")
  (consistent-window-splits-prevent-vertical-splits)
  (consistent-window-splits-set 150 nil 250 nil))

(defun consistent-window-splits-set:default ()
  "Revert the window minimum width and split behaviour to
their default settings."
  (interactive)
  (message "Screen splitting behaviour reverted to defaults")
  (consistent-window-splits-set 10 nil 100 80))

(defvar consistent-window-splits-width-threshold:ultrawide 400
  "Threshold for applying ultrawide monitor splitting behaviour to a frame.")
(defvar consistent-window-splits-width-threshold:wide 300
  "Threshold for applying widescreen monitor splitting behaviour to a frame.")
(defvar consistent-window-splits-width-threshold:laptop 200
  "Threshold for applying laptop monitor splitting behaviour to a frame.")

(defun consistent-window-splits-optimize (&optional frame)
  (interactive)
  (let ((width (frame-width frame)))
    (message (format "Automatically optimizing window split behaviour based on new frame width %d" width))
    ;; Check for screen width limits in decreasing order, and set appropriate splitting behaviour.
    (cond
     ((> width consistent-window-splits-width-threshold:ultrawide) (consistent-window-splits-set:ultrawide))
     ((> width consistent-window-splits-width-threshold:wide)      (consistent-window-splits-set:wide))
     ((> width consistent-window-splits-width-threshold:laptop)    (consistent-window-splits-set:laptop))
     (t                                                            (consistent-window-splits-set:default)))))

(defvar consistent-window-splits--observed-frame-width (frame-width)
  "The most recently observed frame width.
Updated when the `window-size-change-functions' are run.")

(defun consistent-window-splits-automatically-optimize ()

  ;; Optimize now
  (consistent-window-splits-optimize)

  ;; And re-optimize when window size changes (if observed frame width has changed)
  (add-to-list
   'window-size-change-functions
   ;; TODO: Define this as a function, add a function to remove it from the size change functions
   (lambda (frame)
     (let ((width (frame-width frame)))
       (when (/= width consistent-window-splits--observed-frame-width)
         (setq consistent-window-splits--observed-frame-width width)
         (consistent-window-splits-optimize frame))))))

(provide 'consistent-window-splits)
;;; consistent-window-splits.el ends here (consistent-window-splits-automatically-optimize)
