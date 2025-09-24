;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Aspen Price"
      user-mail-address "aspen@aspen-otr.com")

(setq github-username "aspen-otr")

(setq apotr/font-size 22)
(setq doom-font (font-spec :family "0xProto Nerd Font" :size apotr/font-size)
      doom-big-font (font-spec :family "0xProto Nerd Font" :size (* 1.25 apotr/font-size))
      doom-variable-pitch-font (font-spec :family "Arimo Nerd Font" :size apotr/font-size)
      doom-symbol-font (font-spec :family "Symbols Nerd Font" :size apotr/font-size))

(setq doom-theme 'doom-ayu-mirage)

(setq display-line-numbers-type 't)
