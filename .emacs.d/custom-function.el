(defun create-pair (a b)
  (interactive)
  (progn
    (insert-string a)
    (insert-string b)
    (backward-char (length b))))
(defmacro gen-pair-handler (a b)
  (list 'lambda (list) (list 'interactive)
	(list 'create-pair a b)))
(global-set-key (kbd "M-\"") (gen-pair-handler "\"" "\""))
(global-set-key (kbd "M-(") (gen-pair-handler "(" ")"))
(global-set-key (kbd "M-{") (gen-pair-handler "{" "}"))
(global-set-key (kbd "M-{") (gen-pair-handler "{" "}"))
(provide 'custom-function)