(defun add-load-path (path)
  (add-to-list 'load-path (concat "~/.emacs.d/" path "/")))

(defun enable-site ()
  (add-load-path "site-lisp"))

(defun enable-line-numbers ()
  (require 'linum)
  (global-linum-mode))

(defun set-colour-theme ()
  (require 'color-theme)
  (color-theme-initialize)
  (color-theme-hober))

(defun fix-whitespace ()
  (require 'whitespace)
  (global-whitespace-mode)
  (setq whitespace-style '(face trailing space-before-tab newline empty space-after-tab tab-mark)))

(defun setup-auto-complete-mode ()
  (add-load-path "auto-complete")
  (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
  (ac-config-default))

(defun setup-tabbar ()
  (require 'tabbar)
  (setq tabbar-buffer-groups-function (quote customised-tabbar-buffer-groups))
  (setq tabbar-cycling-scope (quote tabs))
  (custom-set-faces
   '(tabbar-selected-face ((t (:inherit tabbar-default-face :foreground "red" :box (:line-width 2 :color "white" :style pressed-button)))))
   '(tabbar-unselected-face ((t (:inherit tabbar-default-face :foreground "black" :box (:line-width 2 :color "white" :style released-button))))))
  (tabbar-mode t))

 (defun customised-tabbar-buffer-groups (buffer)
   "Return the list of group names BUFFER belongs to.
 Return only one group for each buffer."
   (with-current-buffer (get-buffer buffer)
     (cond
      ((string-equal "*" (substring (buffer-name) 0 1))
       '("emacs"))
      (t
       '("Code"))
      )))

(defun ruby-enter ()
  (interactive)
  (let
      ((line (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
    (newline-and-indent)
    (cond
     ((string-match "^ *\\(class \\|def \\|if \\|while \\|begin\\)\\|^.*do\\( |.*|\\)?$" line)
      (newline-and-indent)
      (insert "end")
      (ruby-indent-command)
      (forward-line -1)
      (ruby-indent-command)))))

(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (turn-on-font-lock)
  (local-set-key (kbd "RET") 'ruby-enter))

(defun setup-ruby-mode ()
  (add-load-path "ruby-mode")
  (require 'ruby-mode)
  (autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files")
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
  (autoload 'run-ruby "inf-ruby""Run an inferior Ruby process")
  (autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
  (add-hook 'ruby-mode-hook 'ruby-mode-hooks)
  (setq ruby-indent-tabs-mode nil))

(defun haskell-mode-tab ()
  (interactive)
  (back-to-indentation)
  (indent-for-tab-command))

(defun haskell-mode-hooks ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indentation)
  (local-set-key (kbd "TAB") 'haskell-mode-tab))

(defun setup-haskell-mode ()
  (add-load-path "haskell-mode")
  (require 'haskell-mode)
  (autoload 'haskell-mode' "haskell-mode" "Mode for editing Haskell source code")
  (add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
  (add-hook 'haskell-mode-hook 'haskell-mode-hooks))

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
  (prefer-coding-system 'utf-8))

(defun bind-keys ()
  (global-set-key (kbd "<f1>") 'copy-whole-buffer)
  (global-set-key (kbd "<f2>") 'delete-other-windows)
  (global-set-key (kbd "<f3>") 'fix-formatting)
  (global-set-key (kbd "<f5>") 'save-buffer)
  (global-set-key (kbd "<f9>") 'reload-file)
  (global-set-key (kbd "<f12>") 'reload-configuration)
  (global-set-key (kbd "RET") 'newline-and-indent)
  (global-set-key (kbd "<C-return>") 'newline)
  (global-set-key (kbd "C-k") 'kill-whole-line)
  (global-set-key (kbd "C-l") 'copy-current-line)
  (global-set-key (kbd "C-q") 'yank))

(defun reload-file ()
  (interactive)
  (revert-buffer t t))

(defun reload-configuration ()
  (interactive)
  (load "~/.emacs")
  (load custom-file))

(defun copy-whole-buffer ()
  (interactive)
  (kill-ring-save (point-min) (point-max)))

(defun fix-formatting ()
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

(defun copy-current-line ()
  (interactive)
  (kill-ring-save
   (line-beginning-position)
   (line-end-position)))

(defun fi-fix (&optional count)
  (interactive)
  (insert "[\"")
  (yank)
  (insert "\", \"")
  (when (null count)
    (setf count 1))
  (dotimes (i count)
    (insert "FI;\\n"))
  (yank)
  (insert "\"],"))

(defun perform-file-indentation (path)
  (message "Processing %s" path)
  (switch-to-buffer (find-file-noselect path))
  (fix-formatting)
  (save-buffer)
  (kill-buffer (current-buffer)))

(defun run-server ()
  (defvar server-is-running nil)
  (when (null server-is-running)
    (setq server-is-running t)
    (server-start))
  (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function))

(defun project-indentation (directory source-file-regex)
  (interactive)
  (dolist
      (entry (directory-files-and-attributes directory))
    (let
        ((name (car entry)))
      (when (not (member name '("." "..")))
        (let ((path (format "%s/%s" directory name))
              (is-directory (nth 1 entry)))
          (cond
           (is-directory
            (project-indentation path source-file-regex))
           (t
            (when (string-match source-file-regex path)
              (perform-file-indentation path)))))))))

(defun save-buffers-kill-emacs (&optional arg)
  "Offer to save each buffer, then kill this Emacs process. With prefix arg, silently save all file-visiting buffers, then kill."
  (interactive "P")
  (save-some-buffers arg t)
  (and
   (or
    (not
     (memq t
           (mapcar
            (function
             (lambda (buf)
               (and (buffer-file-name buf)
                    (buffer-modified-p buf))))
            (buffer-list))))
    t)
   (or (not (fboundp 'process-list))
       ;; process-list is not defined on VMS.
       (let ((processes (process-list))
             active)
         (while processes
           (and (memq (process-status (car processes)) '(run stop open listen))
                (process-query-on-exit-flag (car processes))
                (setq active t))
           (setq processes (cdr processes)))
         (or (not active)
             (list-processes t)
             (yes-or-no-p "Active processes exist; kill them and exit anyway? "))))
   ;; Query the user for other things, perhaps.
   (run-hook-with-args-until-failure 'kill-emacs-query-functions)
   (or (null confirm-kill-emacs)
       (funcall confirm-kill-emacs "Really exit Emacs? "))
   (kill-emacs)))

(enable-site)
(enable-line-numbers)
(set-colour-theme)
(fix-whitespace)

;(setup-auto-complete-mode)
(setup-ruby-mode)
(setup-haskell-mode)

(set-font)
(fix-scrolling)
(miscellaneous)
(setup-tabbar)
(bind-keys)
(run-server)