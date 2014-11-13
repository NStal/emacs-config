(set-background-color "black")
(set-foreground-color "Wheat")
(set-cursor-color "Wheat")

(global-linum-mode t) ;; allow line number
(provide 'custom-preference)

(add-to-list 'auto-mode-alist '("[.]less$" . css-mode))
(add-hook 'coffee-mode-hook 'auto-complete-mode)


