;; General Setup --------------------------------------------------------------

;; Added by Package.el.  This must come before configurations of
;; installed packages.
(package-initialize)

;; custom set variables, can only be one instance
(custom-set-variables
 '(custom-enabled-themes (quote (tango-dark)))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults)))
 '(package-selected-packages (quote (auctex ggtags elpy jedi marmalade-demo))))
(custom-set-faces)


(setq default-directory "~/Dropbox/VM_VirtualBox" )
(setq bongo-default-directory "~/Dropbox/Music/Bongo/")
(setq last-kbd-macro
   nil)

;; additional elisp paths
(add-to-list 'load-path "~/Dropbox/VM_VirtualBox/emacs.d/lisp/ESS/lisp")
(add-to-list 'load-path "~/Dropbox/VM_VirtualBox/emacs.d/lisp/predictive")
(add-to-list 'load-path "~/Dropbox/VM_VirtualBox/emacs.d/lisp/emms/lisp")
(add-to-list 'load-path "~/Dropbox/VM_VirtualBox/emacs.d/lisp/")
(add-to-list 'load-path "~/Dropbox/VM_VirtualBox/emacs.d/lisp/volume.el")
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
'("marmalade" . "http://marmalade-repo.org/packages/"))


;; make emacs open full screen 
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; set the opening screen to blank scratch page
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;;load packages
(require 'ssh)
(require 'tramp)
(require 'package)
(require 'ido)
(require 'predictive)
(require 'ess-site)
(require 'textmate)
(require 'magit)
(require 'auto-complete)


;; file backup settings
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t
; backup of a file the first time it is saved.
      backup-by-copying t
; don't clobber symlinks
      version-control t
; version numbers for backup files
      delete-old-versions t
; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6
; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9
; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t
; auto-save every buffer that visits a file
      auto-save-timeout 60
; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200)
; number of keystrokes between auto-saves (default: 300)



;; package specs
(ido-mode t)
;;(autopair-global-mode 1)
;;(elpy-enable)
(setenv "PYTHONPATH" "/usr/bin/python")
(setenv "SCALA_HOME" "/usr/local/bin/scala")



;;R auto-complete
(setq ess-use-auto-complete t)
(ess-toggle-underscore nil)
(global-auto-complete-mode t)

;; C++ mode
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;; Mail - Wanderlust
(autoload 'wl "wl" "Wanderlust" t)
  (autoload 'wl-user-agent-compose "wl-draft" nil t)
     (if (boundp 'mail-user-agent)
         (setq mail-user-agent 'wl-user-agent))
     (if (fboundp 'define-mail-user-agent)
         (define-mail-user-agent
           'wl-user-agent
           'wl-user-agent-compose
           'wl-draft-send
           'wl-draft-kill
           'mail-send-hook))


;; media system
(setq exec-path (append exec-path '("usr/bin/")))
(require 'emms-setup)
(require 'emms-player-mplayer)
(emms-standard)
(emms-default-players)
(define-emms-simple-player mplayer '(file(setq last-kbd-macro
   nil)
 url)
      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
      "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")
        

;; w3m browser
(setq browse-url-browser-function 'w3m-goto-url-new-session)

;;wikipedia search
(defun wikipedia-search (search-term)
  "Search for SEARCH-TERM on wikipedia"
  (interactive
   (let ((term (if mark-active
                   (buffer-substring (region-beginning) (region-end))
                 (word-at-point))))
     (list
      (read-string
       (format "Wikipedia (%s):" term) nil nil term)))
   )
(setq last-kbd-macro
   nil)
  (browse-url
   (concat
    "http://en.m.wikipedia.org/w/index.php?search="
    search-term
    ))
  )

;;when I want to enter the web address all by hand
(defun w3m-open-site (site)
  "Opens site in new w3m session with 'http://' appended"
(setq last-kbd-macro
   nil)
  (interactive
   (list (read-string "Enter website address(default: w3m-home):" nil nil w3m-home-page nil )))
  (w3m-goto-url-new-session
   (concat "http://" site)))


(setq w3m-use-filter t)
;; send all pages through one filter
(setq w3m-filter-rules `(("\\`.+" w3m-filter-all)))

(standard-display-ascii ?\225 [?+])
(standard-display-ascii ?\227 [?-])
(standard-display-ascii ?\222 [?'])

(defun w3m-filter-all (url)
  (let ((list '(
                ;; add more as you see fit!
               	("&#187;" "&gt;&gt;")
               	("&laquo class="comment">;" "&lt;")
                ("&raquo class="comment">;" "&gt;")
                ("&ouml class="comment">;" "o")
                ("&#8230;" "...")
                ("&#8216;" "'")
                ("&#8217;" "'")
                ("&rsquo class="comment">;" "'")
                ("&lsquo class="comment">;" "'")
                ("\u2019" "\'")
                ("\u2018" "\'")
                ("\u201c" "\"")
                ("\u201d" "\"")
                ("&rdquo class="comment">;" "\"")
                ("&ldquo class="comment">;" "\"")
                ("&#8220;" "\"")
                ("&#8221;" "\"")
                ("\u2013" "-")
               	("\u2014" "-")
                ("&#8211;" "-")
                ("&#8212;" "-")
                ("&ndash class="comment">;" "-")
                ("&mdash class="comment">;" "-")
                )))
  (while list
    (let ((pat (car (car list)))
          (rep (car (cdr (car list)))))
      (goto-char (point-min))
      (while (search-forward pat nil t)
        (replace-match rep))
      (setq list (cdr list))))))


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



;; Custom Functions -------------------------------------------------------------------

;; function to open a new blank buffer
(defun j-new-buffer ()
  "Open a new empty buffer."
  (interactive)
  (let ((-buf (generate-new-buffer "untitled")))
    (switch-to-buffer -buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))

;; functions for python mode
(defun forward-block (&optional Ï†n)
  (interactive "p")
  (let ((Ï†n (if (null Ï†n) 1 Ï†n)))
    (search-forward-regexp "\n[\t\n ]*\n+" nil "NOERROR" Ï†n)))

(defun elpy-shell-send-current-block ()
  "Send current block to Python shell."
  (interactive)
  (beginning-of-line)
  (push-mark)
  (forward-block)
  (elpy-shell-send-region-or-buffer)
  (display-buffer (process-buffer (elpy-shell-get-or-create-process))
                  nil
                  'visible))


;; function to evaluate lisp
(defun eval-region-or-buffer ()
  (interactive)
  (let ((debug-on-error t))
    (cond
     (mark-active
      (call-interactively 'eval-region)
      (message "Region evaluated")
      (setq deactivate-mark t))
     (t
      (eval-buffer)
      (message "Buffer evaluated")))))

(global-set-key (kbd "C-x C-k e") 'eval-region-or-buffer)


(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.
With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))



;; Custom Macros --------------------------------------------------------

;; open new empty buffer
(global-set-key (kbd "C-x C-k n") 'j-new-buffer) 

;; macro to login to app15
(fset 'login-15
   [?\M-x ?e ?s ?h ?e ?l ?l return ?c ?d ?  ?/ ?j ?m ?c ?m ?i ?l ?l ?a ?n ?@ ?1 ?0 ?. ?9 ?6 ?. ?2 ?6 ?. ?6 ?3 ?:])
(global-set-key (kbd "C-x C-k 1") 'login-15)

;; IP for app01 is 10.96.26.57
;; IP for app02 is 10.96.26.47
;; IP for app21 is 10.96.26.70
;; IP for app22 is 10.96.26.71


;; macro to login to app16
(fset 'login-16
   [?\M-x ?e ?s ?h ?e ?l ?l return ?c ?d ?  ?/ ?j ?m ?c ?m ?i ?l ?l ?a ?n ?@ ?1 ?0 ?. ?9 ?6 ?. ?2 ?6 ?. ?6 ?4 ?:])
(global-set-key (kbd "C-x C-k 2") 'login-16)

;; login to devapp04

(fset 'login-devapp1
   [?\M-x ?e ?s ?h ?e ?l ?l return ?c ?d ?  ?/ ?j ?m ?c ?m ?i ?l ?l ?a ?n ?@ ?1 ?0 ?. ?9 ?6 ?. ?2 ?6 ?. ?5 ?0 ?:])
(global-set-key (kbd "C-x C-k d") 'login-devapp1)

(setq last-kbd-macro
   nil)


(setq last-kbd-macro
   nil)
;; type IP to app15 server
(global-set-key (kbd "C-x C-j 1") "/jmcmillan@10.96.26.63:/")

;; macro to open the configuration file
(fset 'open-config
   [?\C-x ?\C-f ?/ ?~ ?/ ?D ?r ?o ?p ?b ?o ?x ?/ ?V ?M ?_ ?V ?i ?r ?t ?u ?a ?l ?B ?o ?x ?/ ?e ?m ?a ?c ?d backspace ?s ?. ?d ?/ ?i ?n ?i ?t ?. ?e ?l return up up S-down S-down ?\M-x ?i ?n tab ?s ?e ?t ?- ?n backspace backspace backspace ?r ?t ?- ?k tab])


(fset 'timesheet-dir
   [?\M-x ?e ?s ?h ?e ?l ?l return ?c ?d ?  ?~ ?/ ?D ?o ?c ?u backspace backspace backspace ?r ?o ?p ?b ?o ?x ?/ ?V ?M ?_ ?V ?i ?r tab ?D ?o ?c ?u ?m ?e ?n ?t ?s ?/ ?O ?r ?g tab ?T ?i ?m ?e ?s ?h tab return])


;; macros to navigate windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left) 
(global-set-key (kbd "C-S-x <left>") 'previous-buffer)
(global-set-key (kbd "C-S-x <right>") 'next-buffer)

;; set alt [ and ] be arrow keys
(global-set-key (kbd "M-[") [left])
(global-set-key (kbd "M-]") [right])
(global-set-key (kbd "M-p") [up])
(global-set-key (kbd "M-;") [down])
(global-set-key (kbd "M-'") [down])


;;macros to edit pane size
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)



;; make C-return send line to python shell
(eval-after-load "elpy"
  '(define-key elpy-mode-map (kbd " <C-return>") 'elpy-shell-send-current-statement))

;; shift C-return sends block to python shell
(eval-after-load "elpy"
  '(define-key elpy-mode-map (kbd " <C-S-return>") 'elpy-shell-send-region-or-buffer))

(setq last-kbd-macro
   [?\M-x ?e ?s ?h ?e ?l ?l return ?c ?d ?  ?~ ?/ ?D ?o ?c ?u backspace backspace backspace ?r ?o ?p ?b ?o ?x ?/ ?V ?M ?_ ?V ?i ?r tab ?D ?o ?c ?u ?m ?e ?n ?t ?s ?/ ?O ?r ?g tab ?T ?i ?m ?e ?s ?h tab return])
;; macro for git-status
(global-set-key (kbd "C-x g") 'magit-status)


;;emmms player
(global-set-key (kbd "C-c e <up>") 'emms-start)
(global-set-key (kbd "C-c e <down>") 'emms-stop)
(global-set-key (kbd "C-c e <left>") 'emms-previous)
(global-set-key (kbd "C-c e <right>") 'emms-next)
