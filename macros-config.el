;; Macros


;; ALL IP ADDRESSES -------------------
;; IP for dev app01         | 10.96.26.57
;; IP for dev app02         | 10.96.26.47
;; IP for dev app04         | 10.96.26.50
;; IP for dev app05         | 10.96.26.51
;; IP for dev app06         | 10.96.26.52
;; IP for     app15         | 10.96.26.63
;; IP for     app16         | 10.96.26.64
;; IP for     app21         | 10.96.26.70
;; IP for     app22         | 10.96.26.71
;; IP for     app25(cron)   | 10.96.26.74
;;--------------------------------------


;; macro to login to app15
(fset 'login-15
   [?\M-x ?e ?s ?h ?e ?l ?l return ?c ?d ?  ?/ ?j ?m ?c ?m ?i ?l ?l ?a ?n ?@ ?1 ?0 ?. ?9 ?6 ?. ?2 ?6 ?. ?6 ?3 ?:])
(global-set-key (kbd "C-x C-k 1") 'login-15)

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


;; macro to open the configuration file
(fset 'open-config
   [?\C-x ?\C-f ?~ ?/ ?p ?C ?l ?o ?u ?d ?D ?r ?i ?v ?e ?/ ?e ?m ?a ?c ?s ?- ?d ?/ ?i ?n ?i ?t ?. ?e ?l return])



;; macro to go to timesheet directory
(fset 'timesheet-dir
   [?\M-x ?e ?s ?h tab return ?c ?d ?  ?~ ?/ ?D ?o ?c ?u tab ?O ?r ?g tab ?T ?i ?m ?e tab return])


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
  '(define-key elpy-mode-map (kbd " <C-return>") 'elpy-shell-send-statement-and-step))

;; shift C-return sends block to python shell
(eval-after-load "elpy"
  '(define-key elpy-mode-map (kbd " <C-S-return>") 'elpy-shell-send-region-or-buffer))

;; macro for git-status
(global-set-key (kbd "C-x g") 'magit-status)


;;emmms player
(global-set-key (kbd "C-c e <up>") 'emms-start)
(global-set-key (kbd "C-c e <down>") 'emms-stop)
(global-set-key (kbd "C-c e <left>") 'emms-previous)
(global-set-key (kbd "C-c e <right>") 'emms-next)
