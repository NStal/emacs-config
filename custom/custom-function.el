"123" (defun create-pair (a b)
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
(global-set-key (kbd "M-[") (gen-pair-handler "[" "]"))
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
(defun coffee-local-require (name var)
  """globally require the package"""
  (interactive "Mpackage name: \nMvar name:\n")
  (progn
    (save-excursion
      (goto-char (point-min))
      (insert (concat var " = " "require(\"" name ".coffee\")\n"))
      ))
  )



(defun narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
      (switch-to-buffer buf)))



(defun select-current-string-literal ()
  "Select current line"
  (interactive)
  (let (start end)
    (while (text-property-any (point) (+ (point) 1) 'face 'font-lock-string-face)
      (forward-char 1)
      )
    (setq end (point))
    (backward-char 1)
    (while (text-property-any (point) (+ (point) 1) 'face 'font-lock-string-face)
      (backward-char 1)
      )
    (forward-char 1)
    (setq start (point))
    (goto-char start)
    (push-mark end)
    (setq mark-active t)
    )
)
(defun select-current-string-literal-content ()
  "Select current line"
  (interactive)
  (let (start end)
    (while (text-property-any (point) (+ (point) 1) 'face 'font-lock-string-face)
      (forward-char 1)
      )
    (setq end (point))
    (backward-char 1)
    (while (text-property-any (point) (+ (point) 1) 'face 'font-lock-string-face)
      (backward-char 1)
      )
    (forward-char 1)
    (setq start (point))
    (goto-char (+ start 1))
    (push-mark (- end 1))
    (setq mark-active t)
    )
)
