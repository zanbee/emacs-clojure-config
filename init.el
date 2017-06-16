;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/"))

;;(add-to-list 'package-archives
;;             '("melpa-stable" . "http://stable.melpa.org/packages/") t)


;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    ;; paredit

    ;; Minor mode for Emacs that deals with parens pairs and tries to be smart about it.
    smartparens

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-ubiquitous

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    ;; tagedit

    ;; auto complete
    company

    ;; browse like explorer
    neotree

    ;; C ack for search
    ag

    ;; minor clojure mode for clojure script
    ;; inf-clojure

    ;; emoji auto-completion
    company-emoji

    ;; clojure UT
    midje-mode

    ;; js mode
    nodejs-repl
    tern
    company-tern
    js3-mode
    scss-mode

    ;; python
    anaconda-mode
    company-anaconda
    pyenv-mode

    ;; git integration
    magit

    ;; ruby on rails
    ;; rinari
    projectile-rails
    inf-ruby
    robe

    ))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "CURRENCY_LAYER_API_KEY") ;; for ulab's hotspot
  )

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;;
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
;; (add-to-list 'load-path "~/.emacs.d/vendor")
;; (require 'handlebars-mode)

;;;;
;; Customization
;;;;

;; global paren mode
(smartparens-global-mode t)

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; org mode
(load "org-mode.el")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")

;; hot-reload for markdown
(load "livedown.el")

;; config markdown
(load "markdown.el")

(global-set-key (kbd "C-x g") 'magit-status)


(add-to-list 'load-path "~/.emacs.d/vendor")
(load "rbenv.el")
;; python
;; (pyenv-mode)
;; (add-hook 'python-mode-hook 'anaconda-mode)
;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
;; (eval-after-load "company"
;;   '(add-to-list 'company-backends 'company-anaconda))
;; (add-hook 'python-mode-hook 'company-mode)
;; (defun projectile-pyenv-mode-set ()
;;   "Set pyenv version matching project name."
;;   (let ((project (projectile-project-name)))
;;     (if (member project (pyenv-mode-versions))
;;         (pyenv-mode-set project)
;;       (pyenv-mode-unset))))
;; (add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)



;;ruby on rails
;; (projectile-rails-global-mode)
;; (require 'slim-mode) ;; from vendor
;; (eval-after-load 'company
;;  '(push 'company-robe company-backends))

;; (require 'rbenv) ;; from vendor
;; (global-rbenv-mode)
;; (add-hook 'ruby-mode-hook 'robe-mode)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-/") 'comment-region)
(global-set-key (kbd "C-x M-/") 'uncomment-region)
