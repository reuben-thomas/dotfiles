;;
;; vim
;;
(use-package evil
  :ensure t
  :config (evil-mode 1))

;;
;; editor
;;
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-current-absolute t)
(global-display-line-numbers-mode 1)
(unless (display-graphic-p) (xterm-mouse-mode 1))

;;
;; theme
;;
(set-face-attribute 'default nil :height 90)
(setq xterm-extra-capabilities '(reportBackground))
(setq xterm-tmux-extra-capabilities '(modifyOtherKeys reportBackground))
(defun my/xterm-set-background-mode (r g b)
  (set-terminal-parameter nil 'background-mode
			  (if (< (+ r g b) (* .6 3 65535)) 'dark 'light))
  t)
(with-eval-after-load 'term/xterm
  (advice-add 'xterm-maybe-set-dark-background-mode
	      :override #'my/xterm-set-background-mode))
