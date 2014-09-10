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


(defun npm-install (name)
  (interactive "MPackageName:\n")
  (progn
    (with-output-to-temp-buffer "*npm-install-buffer*"
      (switch-to-buffer "*npm-install-buffer*")
      (defun ansi-color-filter (proc string)
                                     (when (buffer-live-p (process-buffer proc))
                                       (with-current-buffer (process-buffer proc)
                                         
                                         (read-only-mode -1)
                                         (let ((moving (= (point) (process-mark proc))))
                                           (save-excursion
                                             ;; Insert the text, advancing the process marker.
                                             (goto-char (process-mark proc))
                                             (insert (ansi-color-apply string))
                                             (set-marker (process-mark proc) (point)))
                                           (if moving (goto-char (process-mark proc)))))))
      
      (set-process-filter 
       (start-process-shell-command "emacs-npm-install" (current-buffer) (concat "npm install " name))
       (function ansi-color-filter))
    )
    ))

(defun nodejs-export-selected-var ()
  """export the selected vard"""
  (interactive)
  (progn 
    (save-excursion
      (let ((name (buffer-substring (region-beginning) (region-end))))
            (goto-char (point-max))
            (insert "\n")
            (insert (concat "exports." name " = " name))
            )
      )
    )
  )
(defun coffee-global-require (name var)
  """globally require the package"""
  (interactive "Mpackage name: \nMvar name:\n")
  (progn
    (save-excursion
      (goto-char (point-min))
      (insert (concat var " = " "require(\"" name "\")\n"))
      ))
  )
(global-set-key (kbd "C-c p") 'nodejs-export-selected-var)
(global-set-key (kbd "C-c g") 'coffee-global-require)
