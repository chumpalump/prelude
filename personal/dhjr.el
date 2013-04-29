(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(scroll-bar-mode -1)
;;(ido-mode -1)
;;(require 'helm-config)
(load-library "ess")
(setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
(setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session

(add-to-list 'load-path "/home/dhjr/src/emacs/zencoding/")
(add-to-list 'load-path "/usr/lib/erlang/lib/tools-2.6.7/emacs/")
;;(add-to-list 'load-path "/var/lib/zotonic/zotonic/priv/emacs")

(load-theme 'subatomic)
(setq prelude-guru nil)
(setq prelude-clean-whitespace-on-save nil)

(setq user-mail-address "dhjr@hddesign.com")
(setq default-truncate-lines t)
(setq mouse-yank-at-point t)

(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)

(setq compilation-scroll-output t)

;; (require 'smart-tab)
;; (global-smart-tab-mode 1)

(add-to-list 'regexp-history "^ *class .*(\\|model.*Source\\|model.*Many\\|model.*Key")
(add-to-list 'regexp-history "^ *class .*Model\\|^ *def ")
(add-to-list 'regexp-history "^ *class \\|^ *def ")
(add-to-list 'regexp-history "^ *class ")
(add-to-list 'regexp-history "^class ")

(require 'find-dired)
(add-to-list 'find-args-history "\( -name '*.html' -o -name '*.styl' -o -name '*.less' -o -name '*.js' -o -name '*.css' -o -name '*.tpl' -o -name '*.erl' -o -name 'dispatch' -o -name 'config' \) -type f")
(add-to-list 'find-args-history "-name '*.html' -o -name '*.styl' -o -name '*.less' -o -name '*.js' -o -name '*.css'")
(add-to-list 'find-args-history "-name '*.md' -o -name '*.py' -o -name 'Makefile' -o -name '*.sh' -o -name 'requirements*.txt'")
(add-to-list 'find-args-history "-type f")

;; (setq find-ls-option  '("-ls" . "-dilsb"))  ;; default
;; (setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))
;; (setq find-ls-option '("-ls | grep -v -e '\.git/' -e '\.hg/' -e '\.pyc$' | sort -k 11" . "-dilsb"))
(setq find-ls-option '("-ls | grep -v -e '\.git/' -e '\.hg/' -e '\.pyc$' | sort -k 11" . "-dilsb"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (sh . t)
   (python . t)
   (emacs-lisp . t)
   ))

(setq org-confirm-shell-link-function `y-or-n-p)
(setq org-confirm-elisp-link-function `y-or-n-p)

(defun no-split-window ()
  (interactive)
  nil)

(defun hdd-no-splits ()
  "No auto splitting windows"
  (setq split-window-preferred-function 'no-split-window)
  )

(defun hdd-sensible-splits ()
  "Sensible auto splitting windows"
  (setq split-window-preferred-function 'split-window-sensibly)
  )

(hdd-no-splits)

(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(autoload 'dired-jump-other-window "dired-x"
  "Like \\[dired-jump] (dired-jump) but in other window." t)
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ;; Set dired-x global variables here.  For example:
            ;; (setq dired-guess-shell-gnutar "gtar")
            ;; (setq dired-x-hands-off-my-keys nil)
            ))
(add-hook 'dired-mode-hook
          (lambda ()
            ;; Set dired-x buffer-local variables here.  For example:
            ;; (dired-omit-mode 1)
            ))

(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

(defun hdd-notify (title body)
  "Notify everyone"
  (progn
    (require 'notifications)
    (require 'dbus)
    (let* ((icon "/home/dhjr/src/javascript/limejs/lime/demos/roundball/compiled/assets/ball_0.png")
           )
      (dbus-ignore-errors
        (notifications-notify :title (xml-escape-string title)
                              :body (xml-escape-string body)
                              :app-icon icon)))))

(defun hdd-test-notify ()
  (interactive)
  (hdd-notify "foo2" "bar2")
  )

(require 'dired-details)
(dired-details-install)
(setq dired-details-hidden-string "[...] ")

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "google-chrome")

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(autoload 'yaml-mode "yaml-mode")

(defun hdd-toggle-window-dedicated ()
  "Toggle the dedication of a window to a buffer."
  (interactive)
  (let* ((win (selected-window)) (bnm (buffer-name (window-buffer win))))
    (if (window-dedicated-p win)
        (progn
          (set-window-dedicated-p win nil)
          (message "This window is no longer dedicated to %s." bnm))
      (progn
        (set-window-dedicated-p win t)
        (message "This window is now dedicated to %s." bnm)))))

(setq deft-extension "md")
(setq deft-text-mode 'markdown-mode)
(setq deft-directory "~/src/wiki/chumpyland-pelican/src")

(add-to-list 'interpreter-mode-alist '("node"    . javascript-mode))
(add-to-list 'interpreter-mode-alist '("python3" . python-mode))
(add-to-list 'auto-mode-alist '("\\.zsh$"  . sh-mode))
(add-to-list 'auto-mode-alist '("\\.php$"  . php-mode))
(add-to-list 'auto-mode-alist '("\\.cnf$"  . conf-mode))
(add-to-list 'auto-mode-alist '("\\.md$"   . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd$"  . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.sls$"  . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml$"  . yaml-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile"  . ruby-mode))
(add-to-list 'auto-mode-alist '("^hosts-"  . conf-mode))
(add-to-list 'auto-mode-alist '("\\.tpl$"  . zotonic-tpl-mode))

(add-hook 'text-mode-hook (lambda () (auto-fill-mode -1)))
(add-hook 'markdown-mode-hook (lambda () (auto-fill-mode -1)))

;; (setq erlang-root-dir "/usr/lib/erlang")
;; (setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
;; (require 'erlang-start)
;; (require 'zotonic-tpl-mode)

(windmove-default-keybindings `control)
;; (browse-kill-ring-default-keybindings)
;; (setq anything-command-map-prefix-key "C-t")
(require 'move-text)
(defun move-text-dhjr-bindings ()
  "Bind `move-text-up' and `move-text-down' to M-up and M-down."
  (global-set-key [S-up] 'move-text-up)
  (global-set-key [S-down] 'move-text-down))
;; (move-text-default-bindings)
(move-text-dhjr-bindings)

(global-set-key (kbd "<f1>")            'find-dired)
(global-set-key (kbd "C-z")             'undo)
(global-set-key (kbd "M-o")             'ffap)
(global-set-key (kbd "C-t")             'anything-find-files)
(global-set-key (kbd "C-x g")           'magit-status)
(global-set-key (kbd "C-x C-z")         'compile)
;;(global-set-key (kbd "C-x C-f")         'helm-find-files)
(global-set-key (kbd "C-x C-d")         'hdd-toggle-window-dedicated)
(global-set-key (kbd "C-x C-a")         'deft)
(global-set-key (kbd "C-x m")           'eshell)
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t))) ;; Start a new eshell
(global-set-key (kbd "C-x C-j")         'dired-jump)
(global-set-key (kbd "C-x 4 C-j")       'dired-jump-other-window)
(global-set-key (kbd "<XF86Launch1>")   'jump-to-register)
(global-set-key (kbd "S-<XF86Launch1>") 'window-configuration-to-register)
(global-set-key (kbd "<XF86Eject>")     'jump-to-register)
(global-set-key (kbd "S-<XF86Eject>")   'window-configuration-to-register)

(modify-all-frames-parameters
 '(
   ;; (background-color . "#000000")
   ;; (background-color . "#090702")
   ;; (background-color . "#110904")
   ;; (background-color . "#150505")
   (alpha . 95)
   ;; (font . "Droid Sans Mono-9")
   ;; (font . "LMMono12-12")
   ;; (font . "Inconsolata-11")
   ;; (font . "Droid Sans Mono-8")
   ;; (font . "cure")
   ;; (font . "edges")
   ;; (font . "kates")
   ;; (font . "lime")
   ;;(font . "smoothansi")
   (font . "-unknown-Ubuntu Mono-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
   (cursor-color . "red")
   (mouse-color . "red")
   (menu-bar-lines . 0)
   (tool-bar-lines . 0)
   ))
;; (custom-set-faces
;;  '(mode-line ((t (:box (:line-width 1 :color "red")))))
;;  ;;'(minibuffer ((t (:box (:line-width 1 :color "red")))))
;;  '(text-cursor ((t (:background "red" :foreground "black"))))
;;  )
(global-set-key [f11]    'make-frame)
(global-set-key [f12]    'other-frame)

;; (bookmark-bmenu-list)
