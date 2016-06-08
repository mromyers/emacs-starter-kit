(add-to-list 'load-path "~/.emacs.d/lisp/")

(load-library "package")
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(load-library "main-setup")

(defun cheat-sheet ()
 (interactive)
 (find-file-read-only "~/.emacs.d/cheat-sheet.org")
 (rename-buffer "*Cheat Sheet*")
 (cd "~/"))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
