;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Aspen Price"
      user-mail-address "aspen@aspen-otr.com")

(defvar prefer-simpc-mode t
  "Use `simpc-mode' if non-nil, otherwise use `c-ts-mode' and `c++-ts-mode'.")


(setq my/font-size 22
      my/font-family "NotoSansM NF")
(setq doom-font (font-spec :family my/font-family :size my/font-size)
      doom-big-font (font-spec :family my/font-family :size (* 1.25 my/font-size))
      doom-variable-pitch-font (font-spec :family "Arimo Nerd Font")
      doom-symbol-font (font-spec :family "Symbols Nerd Font"))

(setq doom-theme 'doom-gruvbox)

(setq display-line-numbers-type 'relative)

(unless (modulep! :lang cc)
  (dolist (ext '("c" "h" "cpp" "hpp" "cc"))
    (add-to-list 'auto-mode-alist `(,(concat "\\." ext "\\'") .
                                    ,(if prefer-simpc-mode
                                         'simpc-mode
                                       (if (length= ext 1)
                                           'c-ts-mode
                                         'c++-ts-mode))))))

(after! evil
  (map! :localleader
        :mode (emacs-lisp-mode lisp-interaction-mode)
        :nvmi "ef" #'eval-defun
        :nvmi "ep" #'eval-print-last-sexp)
  (after! smartparens
    (map! :localleader
          :mode (emacs-lisp-mode lisp-interaction-mode)
          :n "sr" #'sp-raise-sexp)))

(after! dired
  (setq dired-listing-switches "-ahlB --group-directories-first")
  (map! :leader
        :n "o+" #'dired-jump-other-window))

(after! evil
  (map! :map evil-window-map
        "O" #'delete-other-windows))

(require 'typst-ts-mode)
(map! :localleader
      :mode typst-ts-mode
      :n "w" #'typst-ts-watch-mode
      :n "c" #'typst-ts-compile
      :n "p" #'typst-ts-preview
      :n "C" #'typst-ts-compile-and-preview)

(after! smartparens
  ;; TODO(DEL): $|$ -> |
  (sp-local-pair 'typst-ts-mode "$" "$"
                 :post-handlers '(("||\n[i]" "RET") ("| " "SPC")))
  (sp-local-pair 'typst-ts-mode "(" ")"
                 :post-handlers '(("||\n[i]" "RET") ("| " "SPC"))))

(map! :g "C-S-v" #'yank)

(defvar default-fl-decoration-level t
  "Default value for `font-lock-maximum-decoration'.")
(defvar fl-decoration-level-alist '((c-mode . 1)
                                    (c++-mode . 1)
                                    (simpc-mode . 2)
                                    (c-ts-mode . 2)
                                    (c++-ts-mode . 2))
  "Alist for `font-lock-maximum-decoration'.")
(setq font-lock-maximum-decoration (append `((t . ,default-fl-decoration-level)) fl-decoration-level-alist))

(defun echo (&rest args)
  (let (message-log-max)
    (apply #'message args)
    nil))

(after! hl-todo
 (setq hl-todo-keyword-faces
       '(("TODO" warning bold)
         ("PERF" warning bold)
         ("FIXME" error bold)
         ("SAFETY" font-lock-constant-face bold)
         ("REVIEW" font-lock-keyword-face bold)
         ("HACK" font-lock-constant-face bold)
         ("DEPRECATED" font-lock-doc-face bold)
         ("NOTE" success bold)
         ("BUG" error bold)
         ("XXX" font-lock-constant-face bold))))


(after! fsharp
  (setq fsharp-compile-command "dotnet run"))

(defun disable-evil-snipe-h ()
  (evil-snipe-local-mode 0))

(add-hook! '(simple-mpc-mode-hook minimpc-edit-mode-hook)
           #'disable-evil-snipe-h)

(map! :leader
      :prefix-map ("z" . "simple mpc")
      :n "e" #'simple-mpc
      :n "l" #'simple-mpc-view-current-playlist
      :n "SPC" #'simple-mpc-toggle
      :n ">" #'simple-mpc-next
      :n "<" #'simple-mpc-prev
      :n "-" #'simple-mpc-decrease-volume
      :n "+" #'simple-mpc-increase-volume)

(setq simple-mpc-playlist-auto-refresh 10
      simple-mpc-playlist-format "%itle%`%artist%`%album%`%time%"
      simple-mpc-table-separator "`")
