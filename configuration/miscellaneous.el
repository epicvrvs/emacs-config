(defun add-load-path (path)
  (add-to-list 'load-path (get-config-path (format "%s/" path))))

(defun enable-site ()
  (add-load-path "site-lisp"))

(defun set-font ()
  (set-default-font
   (if (eq system-type 'windows-nt)
       "-outline-Lucida Console-normal-r-normal-normal-16-120-96-96-c-*-iso8859-1"
     "-outline-Terminus-medium-r-normal-normal-16-120-96-96-c-*-iso8859-")))

(defun fix-scrolling ()
  (require 'smooth-scrolling)
  (let ((line-count 5)) (setq mouse-wheel-scroll-amount `(,line-count ((shift) . ,line-count))))
  (setq mouse-wheel-progressive-speed nil)
  (setq mouse-wheel-follow-mouse 't)
  (setq scroll-step 3))

(defun fundamental-mode-check ()
  (if (equal major-mode 'fundamental-mode)
      (local-set-key (kbd "<tab>") 'tab-to-tab-stop)
    (setq indent-tabs-mode nil)))

(defun miscellaneous ()
  (setq transient-mark-mode t)
  (setq custom-file "~/.emacs-custom.el")
  (load custom-file)
  (setq inhibit-startup-screen t)
  (setq ring-bell-function (lambda ()))
  (setq backup-inhibited t)
  (setq auto-save-default nil)
  (setq buffer-offer-save nil)
  (setq-default indent-tabs-mode t)
  (add-hook 'after-change-major-mode-hook 'fundamental-mode-check)
  (setq kill-whole-line t)
  (setq delete-selection-mode t)
  (prefer-coding-system 'utf-8)
  (setq column-number-mode t))