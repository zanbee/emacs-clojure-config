;; (define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-cb" 'org-iswitchb)
(setq org-hide-leading-stars t)

(setq org-log-done t)
(setq org-agenda-files (list "~/Dropbox/org/work.org"
                             "~/Dropbox/org/au.org"
                             "~/Dropbox/org/home.org"))

;; set the default tags & shortcuts
(setq org-tag-alist '(("URGENT" . ?u)
                      ("ERRANDS" . ?e)))

;; set custom shortcut for agenda
(setq org-agenda-custom-commands
      '(("P" "Project List"
         ( (tags "PROJECT")
           )
         )
        ("O" "Office"
         ( (agenda)
           (tags-todo "OFFICE")
           )
         )
        ("W" "Weekly Plan"
         ( (agenda)
           (todo "TODO")
           (tags "PROJECT")
           )
         )
        ("H" "Home NA Lists"
         ( (agenda)
           (tags-todo "HOME")
           (tags-todo "COMPUTER")
           )
         )
        )
      )

;; Reporting time by days
(defun org-dblock-write:rangereport (params)
  "Display day-by-day time reports."
  (let* ((ts (plist-get params :tstart))
         (te (plist-get params :tend))
         (start (time-to-seconds
                 (apply 'encode-time (org-parse-time-string ts))))
         (end (time-to-seconds
               (apply 'encode-time (org-parse-time-string te))))
         day-numbers)
    (setq params (plist-put params :tstart nil))
    (setq params (plist-put params :end nil))
    (while (<= start end)
      (save-excursion
        (insert "\n\n"
                (format-time-string (car org-time-stamp-formats)
                                    (seconds-to-time start))
                "----------------\n")
        (org-dblock-write:clocktable
         (plist-put
          (plist-put
           params
           :tstart
           (format-time-string (car org-time-stamp-formats)
                               (seconds-to-time start)))
          :tend
          (format-time-string (car org-time-stamp-formats)
                              (seconds-to-time end))))
        (setq start (+ 86400 start))))))
