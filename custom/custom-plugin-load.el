(add-to-list 'load-path
	     "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;;make copy text able to used for other application
(setq x-select-enable-clipboard t)


;;load yas snippet
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")


(add-to-list 'load-path "~/.emacs.d/vendor")
;(require 'sws-mode)
;(require 'jade-mode)    
;(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
;(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(setq coffee-tab-width 4)


(provide 'custom-plugin-load)

(global-auto-revert-mode t)
