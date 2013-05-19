(add-to-list 'load-path "~/.emacs.d")
(add-hook 'go-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode t)
	    (setq tab-width 4)
	    (setq python-indent 4)))
(require 'custom-function)
(require 'custom-preference)
(require 'custom-plugin-load)
(require 'custom-hotkey)

(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
