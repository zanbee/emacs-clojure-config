;; javascript / html
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
;; (add-hook 'js-mode-hook 'subword-mode)
;; (add-hook 'html-mode-hook 'subword-mode)
;; (setq js-indent-level 2)


;; ;; coffeescript
;; (add-to-list 'auto-mode-alist '("\\.coffee.erb$" . coffee-mode))
;; (add-hook 'coffee-mode-hook 'subword-mode)
;; (add-hook 'coffee-mode-hook 'highlight-indentation-current-column-mode)
;; (add-hook 'coffee-mode-hook
;;           (defun coffee-mode-newline-and-indent ()
;;             (define-key coffee-mode-map "\C-j" 'coffee-newline-and-indent)
;;             (setq coffee-cleanup-whitespace nil)))
;; (custom-set-variables
;;  '(coffee-tab-width 2))


;; '(js3-auto-indent-p t)         ; it's nice for commas to right themselves.
;; '(js3-enter-indents-newline t) ; don't need to push tab before typing
;; '(js3-indent-on-enter-key t)   ; fix indenting before moving on
(custom-set-variables
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(js3-lazy-commas t)
 '(js3-lazy-operators t)
 '(js3-lazy-dots t)
 '(js3-lazy-semicolons t)
 '(js3-indent-dots t)
 '(js3-expr-indent-offset 2)
 '(js3-paren-indent-offset 2)
 '(js3-square-indent-offset 2)
 '(js3-curly-indent-offset 2))

(require 'nodejs-repl)

(add-hook 'js3-mode-hook 'tern-mode)

;; Add company-tern to allowed company-mode backends list
(add-to-list 'company-backends 'company-tern)

;; If you don't like circles after object's own properties consider less annoying marker for that purpose.
(setq company-tern-property-marker "")

;; You can trim too long function signatures to the frame width.
(setq company-tern-meta-as-single-line t)

;; If you doesn't like inline argument annotations appear with corresponding identifiers, then you can to set up the company align option.
(setq company-tooltip-align-annotations t)


;; sass-mode
(setq exec-path (cons (expand-file-name "/Library/Ruby/Gems/2.0.0/gems/sass-3.4.19/bin") exec-path))
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

;; handlebar mode
(add-to-list 'auto-mode-alist '("\\.hbs$" . handlebars-mode))
