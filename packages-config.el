;; Package config

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(add-to-list 'load-path "~/Downloads/ess-18.10.2/lisp")

;;load packages
(use-package ssh)
(use-package tramp)
(use-package ido)
(require 'ess-site)
(use-package textmate)
(use-package magit)
(use-package auto-complete)
(use-package elpy)
(require ' autopair)
(use-package ggtags)
;;(use-package pdf-tools)
(use-package flycheck)

;; C/C++
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;; Python
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(setq python-shell-interpreter "python3")
