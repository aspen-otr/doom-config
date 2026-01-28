;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Aspen Price"
      user-mail-address "aspen@aspen-otr.com")

(setq my/font-size 22
      my/font-family "NotoSansM NF")
(setq doom-font (font-spec :family my/font-family :size my/font-size)
      doom-big-font (font-spec :family my/font-family :size (* 1.25 my/font-size))
      doom-variable-pitch-font (font-spec :family "Arimo Nerd Font" :size my/font-size)
      doom-symbol-font (font-spec :family "Symbols Nerd Font" :size my/font-size))

(setq doom-theme 'doom-gruvbox)

(setq display-line-numbers-type 'relative)

(when (not (modulep! :lang cc))
  (require 'simpc-mode)
  (dolist (ext '("c" "h" "cpp" "hpp" "cc"))
    (add-to-list 'auto-mode-alist `(,(concat "\\." ext "\\'") . simpc-mode))))


(map! :g "C-S-v" #'yank)
