(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)S
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(setq load-path (cons "~/.emacs.d/elpa" load-path))

;;日本語フォントの設定
(set-fontset-font t 'japanese-jisx0208 "TakaoPGothic")



;;powerllinesce
(require 'powerline)
 
(defun powerline-my-theme ()
  "Setup the my mode-line."
  (interactive)
  (setq powerline-current-separator 'utf-8)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'mode-line-1-fg 'mode-line-2-fg))
                          (face2 (if active 'mode-line-1-arrow 'mode-line-2-arrow))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          (powerline-current-separator)
                                                          (car powerline-default-separator-dir))))
                          (lhs (list (powerline-raw " " face1)
                                     (powerline-major-mode face1)
                                     (powerline-raw " " face1)
                                     (funcall separator-left face1 face2)
                                     (powerline-buffer-id nil )
                                     (powerline-raw " [ ")
                                     (powerline-raw mode-line-mule-info nil)
                                     (powerline-raw "%*")
                                     (powerline-raw " |")
                                     (powerline-process nil)
                                     (powerline-vc)
                                     (powerline-raw " ]")
                                     ))
                          (rhs (list (powerline-raw "%4l")
                                     (powerline-raw ":")
                                     (powerline-raw "%2c")
                                     (powerline-raw " | ")                                  
                                     (powerline-raw "%6p")
                                     (powerline-raw " ")
                                     )))
                     (concat (powerline-render lhs)
                             (powerline-fill nil (powerline-width rhs)) 
                             (powerline-render rhs)))))))

(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
                      :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "#282C34" "#EF8300" 'bold)
(make/set-face 'mode-line-2-fg "#AAAAAA" "#2F343D" 'bold)
(make/set-face 'mode-line-1-arrow  "#AAAAAA" "#3E4451" 'bold)
(make/set-face 'mode-line-2-arrow  "#AAAAAA" "#3E4451" 'bold)

(powerline-my-theme)

;;anzu
(global-anzu-mode +1)

;;rainbow-deiminaters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)


;;bash-completion
(require 'bash-completion)
(bash-completion-setup)


;; メニューバーを消
;;(menu-bar-mode -1)

;; ツールバーを消す
(tool-bar-mode -1)

;; 列数を表示する
(column-number-mode t)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

;; 行数を表示する
(global-linum-mode t)

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; 対応する括弧を光らせる
(show-paren-mode t)
(set-face-background 'show-paren-match nil)
(set-face-attribute 'show-paren-match nil
                    :inherit 'highlight)

;; シフト＋矢印で範囲選択
(setq pc-select-selection-keys-only t)

;; C-kで行全体を削除する
(setq kill-whole-line t)
(put 'upcase-region 'disabled nil)

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'maximized)

;; 画面の移動をalt+矢印キーで行く
(global-set-key (kbd "<M-left>")  'windmove-left)
(global-set-key (kbd "<M-down>")  'windmove-down)
(global-set-key (kbd "<M-up>")    'windmove-up)
(global-set-key (kbd "<M-right>") 'windmove-right)

(global-set-key "\C-h" 'backward-delete-char)

;;矩形選択の先頭に文字列を挿入
(global-set-key (kbd "C-x a") 'string-rectangle)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; euslime
;; (add-to-list 'load-path "/home/ykawamura/euslime_dir/slime")
;; (add-to-list 'load-path "/home/ykawamura/euslime_dir/euslime")
;; (add-to-list 'load-path "/home/ykawamura/euslime_dir/slime-repl-ansi-color")
;; (require 'slime-autoloads)
;; (require 'euslime)
;; (setq inferior-lisp-program "sbcl")
;; (setq inferior-euslisp-program "roseus")
;; (setq slime-contribs '(slime-fancy slime-repl-ansi-color))
