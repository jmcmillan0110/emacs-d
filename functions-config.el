

;; Custom Functions -------------------------------------------------------------------

;; function to open a new blank buffer
(defun j-new-buffer ()
  "Open a new empty buffer."
  (interactive)
  (let ((-buf (generate-new-buffer "untitled")))
    (switch-to-buffer -buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))
(global-set-key (kbd "C-x C-k n") 'j-new-buffer) 



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


;; delete autosaves in current directory
(defun autosave-delete ()
  "Delete Emacs autosaved files in current directory"
  (interactive)
  (shell-command "rm $(find . -maxdepth 1 -type f -name \"*~\")"))



;; toggle images in eww browser
(defvar-local endless/display-images t)

(defun toggle-image-display ()
  "Toggle images display on current buffer."
  (interactive)
  (setq endless/display-images
        (null endless/display-images))
  (endless/backup-display-property endless/display-images))
;; set macro 
(global-set-key (kbd "C-x C-k i") 'toggle-image-display)



(defun endless/backup-display-property (invert &optional object)
  "Move the 'display property at POS to 'display-backup.
Only applies if display property is an image.
If INVERT is non-nil, move from 'display-backup to 'display
instead.
Optional OBJECT specifies the string or buffer. Nil means current
buffer."
  (let* ((inhibit-read-only t)
         (from (if invert 'display-backup 'display))
         (to (if invert 'display 'display-backup))
         (pos (point-min))
         left prop)
    (while (and pos (/= pos (point-max)))
      (if (get-text-property pos from object)
          (setq left pos)
        (setq left (next-single-property-change pos from object)))
      (if (or (null left) (= left (point-max)))
          (setq pos nil)
        (setq prop (get-text-property left from object))
        (setq pos (or (next-single-property-change left from object)
                      (point-max)))
        (when (eq (car prop) 'image)
          (add-text-properties left pos (list from nil to prop) object))))))

;;sql
  (defun upcase-sql-keywords ()
    (interactive)
    (save-excursion
      (dolist (keywords sql-mode-postgres-font-lock-keywords)
        (goto-char (point-min))
        (while (re-search-forward (car keywords) nil t)
          (goto-char (+ 1 (match-beginning 0)))
          (when (eql font-lock-keyword-face (face-at-point))
            (backward-char)
            (upcase-word 1)
            (forward-char))))))
