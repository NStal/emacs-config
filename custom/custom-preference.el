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
