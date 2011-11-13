;; don't go with a news group for now as i have no idea how to sync
;; stuff

;; (setq gnus-select-method '(nntp "news.gmane.org"))

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


(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "bootsarehax@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; (setq send-mail-function 'smtpmail-send-it
;;       message-send-mail-function 'smtpmail-send-it
;;       mail-from-style nil user-full-name "Philipp Möller"
;;       smtpmail-debug-info t smtpmail-debug-verb t)

;; (setq mm-discouraged-alternatives '("text/html" "text/richtext"))

;; (defvar smtp-accounts
;;   '((ssl "bootsarehax@gmail.com" "smtp.gmail.com"
;; 	 587 "bootsarehax@gmail.com")
;;     (ssl "philipp.moeller@geometryfactory.com" "mail.geometryfactory.com"
;;          587 "philipp.moeller@geometryfactory.com")
;;     ))


;; ;; Available SMTP accounts. The format is
;; ;; type of connection - account in the from field - smtp server -
;; ;; port - login name - password. You can leave the password field
;; ;; as NIL and emacs will ask every time

;; (defun set-smtp (mech server port user password)
;;   "Set related SMTP variables for supplied parameters."
;;   (setq smtpmail-smtp-server server smtpmail-smtp-service port
;;         smtpmail-auth-credentials (list (list server port user
;;                                               password)) smtpmail-auth-supported (list mech)
;;                                               smtpmail-starttls-credentials nil)
;;   (message "Setting SMTP server to `%s:%s' for user `%s'."
;;            server port user))

;; (defun set-smtp-ssl (server port user password &optional key
;;                             cert)
;;   "Set related SMTP and SSL variables for supplied parameters."
;;   (setq starttls-use-gnutls t
;;         starttls-gnutls-program "gnutls-cli"
;;         starttls-extra-arguments nil smtpmail-smtp-server server
;;         smtpmail-smtp-service port
;;         smtpmail-auth-credentials (list (list server port user
;;                                               password)) smtpmail-starttls-credentials (list (list
;;                                                                                               server port key cert)))
;;   (message "Setting SMTP server to `%s:%s' for user `%s'. (SSLenabled.)" server port user))

;; (defun change-smtp ()
;;   "Change the SMTP server according to the current from line."
;;   (save-excursion
;;     (loop with from = (save-restriction
;;                         (message-narrow-to-headers)
;;                         (message-fetch-field "from"))
;;           for (auth-mech address . auth-spec) in smtp-accounts
;;           when (string-match address from) do (cond
;;                                                ((memq auth-mech '(cram-md5 plain login))
;;                                                 (return (apply 'set-smtp (cons auth-mech auth-spec))))
;;                                                ((eql auth-mech 'ssl)
;;                                                 (return (apply 'set-smtp-ssl auth-spec)))
;;                                                (t (error "Unrecognized SMTP auth. mechanism:`%s'." auth-mech))) finally (error "Cannot infer SMTP information."))))

;; ;; The previous function will complain if you fill the from field with
;; ;; an account not present in smtp-accounts.

;; (defvar %smtpmail-via-smtp (symbol-function 'smtpmail-via-smtp))

;; (defun smtpmail-via-smtp (recipient smtpmail-text-buffer)
;;   (with-current-buffer smtpmail-text-buffer
;;     (change-smtp))
;;   (funcall (symbol-value '%smtpmail-via-smtp) recipient
;;            smtpmail-text-buffer))