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
(require 'package)
(require 'ido)
(require 'ess-site)
(require 'textmate)
(require 'magit)
(require 'auto-complete)
(require 'elpy)
(require 'w3)
(require 'autopair)
;;(require 'ensime)
