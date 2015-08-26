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
  (interactive
   (let ((pname (read-string "package name:")) (pvar-default "hehe"))
     (setq pvar-default (car (split-string (file-name-nondirectory pname) "\\.")))
     (message pvar-default)
     (let ((pvar (read-string (format "variable name (%s):" pvar-default) nil nil pvar-default)))
       (list pname pvar)
       )
    ))
  (progn
    (save-excursion
      (goto-char (point-min))
      (insert (concat var " = " "require(\"" name "\")\n"))
      ))
  )

(defun coffee-member-require (name var)
  """globally require the package"""
  (interactive
   (let ((pname (read-string "package name:")) (pvar-default "hehe"))
     (setq pvar-default (car (split-string (file-name-nondirectory pname) "\\.")))
     (message pvar-default)
     (let ((pvar (read-string "member name:")))
       (list pname pvar)
       )
    ))
  (progn
    (save-excursion
      (goto-char (point-min))
      (insert (concat (format "%s = require(\"%s\").%s\n" var name var)))
      (message (concat (format "%s = require(\"%s\").%s\n inserted" var name var)))
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

(defun set-coffee-tab-width (width)
  "set coffee tab width"
  (interactive
   (let ((default-width "4"))
     (list (read-string (format "set coffee tab width to(default %s):" default-width) nil nil default-width))
   ))
  
  (progn
     (custom-set-variables
      '(coffee-tab-width
        
        (if (stringp width)
            (string-to-number width)
          width
          )
        
        )))
    
  )

(require 'cl)
(defun parallel-replace (plist &optional start end)
  (interactive
   `(,(loop with input = (read-from-minibuffer "Replace: ")
            with limit = (length input)
            for (item . index) = (read-from-string input 0)
                            then (read-from-string input index)
            collect (prin1-to-string item t) until (<= limit index))
     ,@(if (use-region-p) `(,(region-beginning) ,(region-end)))))
  (let* ((alist (loop for (key val . tail) on plist by #'cddr
                      collect (cons key val)))
         (matcher (regexp-opt (mapcar #'car alist) 'words)))
    (save-excursion
      (goto-char (or start (point)))
      (while (re-search-forward matcher (or end (point-max)) t)
        (replace-match (cdr (assoc-string (match-string 0) alist)))))))


(defun toggle-camelcase-underscores ()
  "Toggle between camcelcase and underscore notation for the symbol at point."
  (interactive)
  (save-excursion
    (let* ((bounds (bounds-of-thing-at-point 'symbol))
           (start (car bounds))
           (end (cdr bounds))
           (currently-using-underscores-p (progn (goto-char start)
                                                 (re-search-forward "_" end t))))
      (if currently-using-underscores-p
          (progn
            (upcase-initials-region start end)
            (replace-string "_" "" nil start end)
            (downcase-region start (1+ start)))
        (replace-regexp "\\([A-Z]\\)" "_\\1" nil (1+ start) end)
        (downcase-region start end)))))
(defun toggle-camelcase-slug ()
  "Toggle between camcelcase and underscore notation for the symbol at point."
  (interactive)
  (save-excursion
    (let* ((bounds (bounds-of-thing-at-point 'symbol))
           (start (car bounds))
           (end (cdr bounds))
           (currently-using-underscores-p (progn (goto-char start)
                                                 (re-search-forward "-" end t))))
      (if currently-using-underscores-p
          (progn
            (upcase-initials-region start end)
            (replace-string "-" "" nil start end)
            (downcase-region start (1+ start)))
        (replace-regexp "\\([A-Z]\\)" "-\\1" nil (1+ start) end)
        (downcase-region start end)))))

(defun xah-toggle-letter-case (φp1 φp2)
  "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.

In lisp code, φp1 φp2 are region boundary.
URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2015-04-09"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (let ((ξbds (bounds-of-thing-at-point 'word)))
       (list (car ξbds) (cdr ξbds)))))
  (let ((deactivate-mark nil))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region φp1 φp2)
      (put this-command 'state 1))
     ((equal 1  (get this-command 'state))
      (upcase-region φp1 φp2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region φp1 φp2)
      (put this-command 'state 0)))))

