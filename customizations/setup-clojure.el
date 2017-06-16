;;;;
;; Clojure
;;;;

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook #'subword-mode)

;; (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

;; auto complete hook into cider-mode
;; (global-company-mode)

;; A little more syntax highlighting
(require 'clojure-mode-extra-font-locking)

;; syntax hilighting for midje
;; (add-hook 'clojure-mode-hook
;;           (lambda ()
;;             (setq inferior-lisp-program "lein repl")
;;             (font-lock-add-keywords
;;              nil
;;              '(("(\\(facts?\\)"
;;                 (1 font-lock-keyword-face))
;;                ("(\\(background?\\)"
;;                 (1 font-lock-keyword-face))))
;;             (define-clojure-indent (fact 1))
;;             (define-clojure-indent (facts 1))))

(define-clojure-indent
  (-> 1)
  (->> 1)
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

;;;;
;; Cider
;;;;

;; provides minibuffer documentation for the code you're typing into the repl
(add-hook 'cider-mode-hook 'eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)

;; When there's a cider error, show its buffer and switch to it
(setq cider-show-error-buffer t)
(setq cider-auto-select-error-buffer t)

;; Where to store the cider history.
(setq cider-repl-history-file "~/.emacs.d/cider-history")

;; Wrap when navigating history.
(setq cider-repl-wrap-history t)

;; enable paredit in your REPL
;; (add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Use clojure mode for other extensions
;; (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
;; (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
;; (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
;; (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))


;; key bindings
;; these help me out with the way I usually develop web apps
;; (defun cider-start-http-server ()
;;   (interactive)
;;   (cider-load-current-buffer)
;;   (let ((ns (cider-current-ns)))
;;     (cider-repl-set-ns ns)
;;     (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
;;     (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


;; (defun cider-refresh ()
;;   (interactive)
;;   (cider-interactive-eval (format "(user/reset)")))

;; (defun cider-user-ns ()
;;   (interactive)
;;   (cider-repl-set-ns "user"))

;; (eval-after-load 'cider
;;   '(progn
;;      (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
;;      (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
;;      (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
;;      (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)))


;; unit test
;; (require 'midje-mode)
;; (require 'clojure-jump-to-file)
;; (add-hook 'clojure-mode-hook 'midje-mode)

;; (defun figwheel-repl ()
;;   (interactive)
;;   (run-clojure "lein figwheel"))

;; (add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)

;; Prevent C-c C-k from prompting to save the file corresponding to the buffer being loaded
;; save the file while reloading it
(setq cider-prompt-save-file-on-load 'always-save)

;; Change the result prefix for interactive evaluation (by default it's =>):
(setq cider-eval-result-prefix ";; => ")

;; CIDER can syntax highlight symbols that are known to be defined
(setq cider-font-lock-dynamically '(macro core function var))

(setq cider-cljs-lein-repl
      "(cond
  (and (resolve 'user/run) (resolve 'user/browser-repl)) ;; Chestnut projects
  (eval '(do (user/run)
             (user/browser-repl)))

  (try
    (require 'figwheel-sidecar.repl-api)
    (resolve 'figwheel-sidecar.repl-api/start-figwheel!)
    (catch Throwable _))
  (eval '(do (figwheel-sidecar.repl-api/start-figwheel!)
             (figwheel-sidecar.repl-api/cljs-repl)))

  (try
    (require 'cemerick.piggieback)
    (resolve 'cemerick.piggieback/cljs-repl)
    (catch Throwable _))
  (eval '(cemerick.piggieback/cljs-repl (cljs.repl.rhino/repl-env)))

  :else
  (throw (ex-info \"Failed to initialize CLJS repl. Add com.cemerick/piggieback and optionally figwheel-sidecar to your project.\" {})))")
