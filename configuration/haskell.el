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
