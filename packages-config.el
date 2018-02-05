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


;;load packages
(require 'ssh)
(require 'tramp)
(require 'ido)
(require 'ess)
(require 'textmate)
(require 'magit)
(require 'auto-complete)
(require 'elpy)
(require 'w3)
(require 'autopair)
(require 'ggtags)
;;(require 'ensime)




;; C/C++
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))
