(defun int-test (params)
  "test function"
  (interactive 
   (let ((content (read-string "give me five")))
     (list content)
     ))
  (progn
    (message params)
    )
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
      ))
  )

