;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

;; TODO: Write Elisp code that makes my font size 15 on PC and 16 on Laptop
(setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 16))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)
(setq doom-modeline-height 27)

(setq read-process-output-max (* 10 1024 1024 1024)) ;; 10GB

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq fancy-splash-image "~/.config/doom/.assets/default.jpg")


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/System/Org/")
(setq org-noter-notes-search-path '("~/System/Org/Notes/"))

;; Org present
(add-to-list 'load-path "~/System/Org/Notes/Presentations")
(autoload 'org-present "org-present" nil t)

;; Hooks
(defun trong/present-start ()
  (visual-fill-column-mode 1)
  (visual-line-mode 1))

(defun trong/present-end ()
  (visual-fill-column-mode 0)
  (visual-line-mode 0))

(add-hook 'emacs-startup-hook #'elcord-mode)
(add-hook 'emacs-startup-hook #'rainbow-mode)
(add-hook 'org-present-mode-hook 'trong/present-start)
(add-hook 'org-present-mode-quit-hook 'trong/present-end)


(with-eval-after-load 'org (global-org-modern-mode))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! visual-fill-column
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t))

(after! helm
  (define-key helm-map (kbd "M-j") #'helm-next-line)
  (define-key helm-map (kbd "M-k") #'helm-previous-line)

  (define-key helm-find-files-map (kbd "M-h") #'helm-find-files-up-one-level)
  (define-key helm-find-files-map (kbd "M-j") #'helm-next-line)
  (define-key helm-find-files-map (kbd "M-k") #'helm-previous-line)
  (define-key helm-find-files-map (kbd "M-l") #'helm-execute-persistent-action))
