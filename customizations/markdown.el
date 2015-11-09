(require 'livedown)
(custom-set-variables
 '(livedown:autostart nil) ; automatically open preview when opening markdown files 
 '(livedown:open t)        ; automatically open the browser window
 '(livedown:port 1337))    ; port for livedown server

;; not yet touch js files
;; (load "setup-js.el")

(require 'company-emoji)
(add-to-list 'company-backends 'company-emoji)
(defun --set-emoji-font (frame)
  "Adjust the font settings of FRAME so Emacs can display emoji properly."
  (if (eq system-type 'darwin)
      ;; For NS/Cocoa
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
    ;; For Linux
    (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))

;; For when Emacs is started in GUI mode:
(--set-emoji-font nil)
;; Hook for when a frame is created with emacsclient
;; see https://www.gnu.org/software/emacs/manual/html_node/elisp/Creating-Frames.html
(add-hook 'after-make-frame-functions '--set-emoji-font)
