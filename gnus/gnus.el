;; don't go with a news group for now as i have no idea how to sync
;; stuff

;; (setq gnus-select-method '(nntp "news.gmane.org"))

;; exiting gnus
(defun exit-gnus-on-exit ()
  (if (and (fboundp 'gnus-group-exit)
           (gnus-alive-p))
      (with-current-buffer (get-buffer "*Group*")
        (let (gnus-interactive-exit)
          (gnus-group-exit)))))

(add-hook 'kill-emacs-hook 'exit-gnus-on-exit)


;; mail servers
(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
(setq gnus-secondary-select-methods '((nnimap "gmail"
                                              (nnimap-address "imap.gmail.com")
                                              (nnimap-server-port 993)
                                              (nnimap-stream ssl))
                                      (nnimap "geometry"
                                              (nnimap-address "ssl0.ovh.net")
                                              (nnimap-server-port 993)
                                              (nnimap-stream ssl))
                                      ))

;; html mails
(require 'w3m)
(setq mm-inline-text-html-renderer 'mm-inline-text-html-render-with-w3m
      w3m-display-inline-image t
      gnus-article-wash-function 'gnus-article-wash-html-with-w3m)