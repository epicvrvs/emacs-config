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