;; General Setup --------------------------------------------------------------


;; custom set variables, can only be one instance
(custom-set-variables
 '(custom-enabled-themes (quote (tango-dark)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
 '(package-selected-packages (quote (auctex ggtags elpy jedi marmalade-demo))))
(custom-set-faces)



;; load additional .el files
(setq load-path
      (append (list nil "~/MEGA/VM_VirtualBox/emacs.d/lisp/")
              load-path))
(let ((default-directory  "~/MEGA/VM_VirtualBox/emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))


;; load other config files
(load "~/MEGA/VM_VirtualBox/emacs.d/packages-config.el")
(load "~/MEGA/VM_VirtualBox/emacs.d/functions-config.el")
(load "~/MEGA/VM_VirtualBox/emacs.d/macros-config.el")


(add-to-list 'exec-path "/usr/local/bin")

(setq default-directory "~/MEGA/VM_VirtualBox" )
(setq bongo-default-directory "~/MEGA/Music/Bongo/")
(setq last-kbd-macro
   nil)

;; turn off menu bar
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Make emacs open full screen 
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; set the opening screen to blank scratch page
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)


;; file backup settings
;; store all backup and autosave files at ~/.saves
(setq backup-directory-alist
      `((".*" . ,"~/.saves")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.saves" t)))


;; prevent writing of tramp_history files
(setq tramp-histfile-override "/dev/null")


;; package specs
(ido-mode t)
(autopair-global-mode)
;;(elpy-enable)
(setenv "PYTHONPATH" "/usr/bin/python3.5")
(setenv "SCALA_HOME" "/usr/local/bin/scala")



;;R auto-complete
(setq ess-use-auto-complete t)
(global-auto-complete-mode)

;; C++ mode
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;;elpy
(setq python-shell-completion-native-enable nil)

;;scala mode
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;; TEX mode
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;;(load "auctex.el" nil t t)

;; to load TeX packages, put .sty file at:
;; /usr/share/texlive/texmf-dist/text
;; use root (sudo -s)


;; PDF tools
 (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
 TeX-source-correlate-start-server t
 )
;; revert pdf-view after compilation
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;; add line numbers to code buffers
(add-hook 'prog-mode-hook 'linum-mode)

;;change smerge host key 
(setq smerge-command-prefix "\C-c s")

;; turn off beep at end of file
(setq visible-bell       nil
      ring-bell-function #'ignore)
