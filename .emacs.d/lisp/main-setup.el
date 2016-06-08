;;init mode
(winner-mode)
(delete-selection-mode)
(column-number-mode)

;;keys
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c w |") 'split-window-right)
(global-set-key (kbd "C-c w _") 'split-window-below)
(global-set-key (kbd "C-c w u") 'winner-undo)
(global-set-key (kbd "C-c w r") 'winner-redo)

(define-key isearch-mode-map (kbd "C-n") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "C-p") 'isearch-repeat-backward)

;;vars
(put 'dired-find-alternate-file 'disabled nil)

;; ido
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(global-set-key "\M-x"
  (lambda ()(interactive)
    (call-interactively
     (intern (ido-completing-read
	      "M-x " (all-completions "" obarray 'commandp))))))

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;misc funs
(defun eshell/clear ()
  (let ((eshell-buffer-maximum-lines 0))
    (eshell-truncate-buffer)))

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
