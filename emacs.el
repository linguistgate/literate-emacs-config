(defun owl/config-reload ()
  "Reloads ~/.emacs.d/emacs.org at runtime."
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/emacs.org")))

(global-set-key (kbd "C-c r") 'owl/config-reload)

(setq user-full-name "Matthew Edward Adams"
      user-mail-address "m2eadams@gmail.com")

(eval-and-compile
  (setq gc-cons-threshold 402653184
	gc-cons-percentage 0.6))

(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))

(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)

(setq user-emacs-directory (file-truename "~/.emacs.d/"))

(setq custom-file "~/.emacs.d/user/custom.el")

(eval-and-compile
  (setq load-prefer-newer t
	package-user-dir "~/.emacs.d/elpa"
	package--init-file-ensured t
	package-enable-at-startup t)

  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t)))

(setq use-package-always-defer nil
      use-package-verbose t)

(eval-and-compile
  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t))))

(eval-when-compile
  (require 'package)

  (unless (assoc-default "melpa" package-archives)
    (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
  (unless (assoc-default "org" package-archives)
    (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))

  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (require 'use-package)
  (setq use-package-always-ensure t))
(require 'bind-key) ; Needs to be here for :bind to work with byte-compiled emacs.el ... not sure why

(use-package toc-org
  :after org
  :init (add-hook 'org-mode-hook #'toc-org-enable))

(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1)
