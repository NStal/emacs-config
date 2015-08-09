(set-background-color "black")
(set-foreground-color "Wheat")
(set-cursor-color "Wheat")

(global-linum-mode t) ;; allow line number
(provide 'custom-preference)

(add-to-list 'auto-mode-alist '("[.]less$" . css-mode))
(add-hook 'coffee-mode-hook 'auto-complete-mode)
(add-hook 'coffee-mode-hook 'electric-pair-mode)
(add-hook 'coffee-mode-hook 'whitespace-mode)

(defun yas-mode-handler ()
  (progn
    (define-key yas/minor-mode-map (kbd "<tab>") nil)
    (define-key yas/minor-mode-map (kbd "TAB") nil)
    (define-key yas/minor-mode-map (kbd "M-p") 'yas/expand)
    )
  )
(add-hook 'yas/minor-mode-hook 'yas-mode-handler)

;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))
;; only show bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab))

(setq show-paren-delay 0)
(tool-bar-mode -1)


;; put ~ saves to . .saves dir
(setq backup-directory-alist `(("." . "~/.saves")))





;;;; use only one desktop
;;(setq desktop-path '("~/.emacs.d/"))
;;(setq desktop-dirname "~/.emacs.d/")
;;(setq desktop-base-file-name "emacs-desktop")
;;
;;;; remove desktop after it's been read
;;(add-hook 'desktop-after-read-hook
;;	  '(lambda ()
;;	     ;; desktop-remove clears desktop-dirname
;;	     (setq desktop-dirname-tmp desktop-dirname)
;;	     (desktop-remove)
;;	     (setq desktop-dirname desktop-dirname-tmp)))
;;
;;(defun saved-session ()
;;  (file-exists-p (concat desktop-dirname "/" desktop-base-file-name)))
;;
;;;; use session-restore to restore the desktop manually
;;(defun session-restore ()
;;  "Restore a saved emacs session."
;;  (interactive)
;;  (if (saved-session)
;;      (desktop-read)
;;    (message "No desktop found.")))
;;
;;;; use session-save to save the desktop manually
;;(defun session-save ()
;;  "Save an emacs session."
;;  (interactive)
;;  (if (saved-session)
;;      (if (y-or-n-p "Overwrite existing desktop? ")
;;	  (desktop-save-in-desktop-dir)
;;	(message "Session not saved."))
;;  (desktop-save-in-desktop-dir)))
;;
;;;; ask user whether to restore desktop at start-up
;;(add-hook 'after-init-hook
;;	  '(lambda ()
;;	     (if (saved-session)
;;		 (if (y-or-n-p "Restore desktop? ")
;;		     (session-restore)))))
(setq desktop-files-not-to-save "^$")
