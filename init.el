(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(when (< emacs-major-version 24)S
  ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(when (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)
     )
(package-initialize) ;; You might already have this line

(setq load-path (cons "~/.emacs.d/elpa" load-path))

;;日本語フォントの設定
(set-fontset-font t 'japanese-jisx0208 "TakaoPGothic")

(load-theme 'tango-dark t)

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
;; irony-mode
(eval-after-load "irony"
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-hook 'c-mode-common-hook 'irony-mode)))
;;elpy
(elpy-enable)
(when (require 'flycheck nil t)
  (remove-hook 'elpy-modules 'elpy-module-flymake)
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode 1)))

;; (el-get-bundle! python-mode)
;; (setq auto-mode-alist (cons '("\\.py\\'" . python-mode) auto-mode-alist))

;; (el-get-bundle! elpy
;; 		(elpy-enable)
;; 		(setq elpy-rpc-backend "jedi")
;; 		(add-hook 'elpy-mode-hook
;; 			  '(lambda ()
;; 			     (auto-complete-mode -1)
;; 			     (define-key company-active-map (kbd "C-n") 'company-select-next)
;; 			     (define-key company-active-map (kbd "C-p") 'company-select-previous)
;; 			     (define-key company-active-map (kbd "<tab>") 'company-complete))))

;;company
(with-eval-after-load 'company
  (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
  ;; C-n, C-pで補完候補を次/前の候補を選択
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
  (define-key company-active-map (kbd "C-h") nil) ;; C-hはバックスペース割当のため無効化
  (define-key company-active-map (kbd "C-S-h") 'company-show-doc-buffer) ;; ドキュメント表示はC-Shift-h
  ;; スクロールバー
  (set-face-attribute 'company-scrollbar-fg nil
		      :background "#4cd0c1")
  ;; スクロールバー背景
  (set-face-attribute 'company-scrollbar-bg nil
		      :background "#002b37")
  )

(global-company-mode) ; 全バッファで有効にする

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


;; バッファ切り替え色々
;; (global-set-key (kbd "M-[") 'switch-to-prev-buffer)
;; (global-set-key (kbd "M-]") 'switch-to-next-buffer)


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

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
;;矩形選択の先頭に文字列を挿入
(global-set-key (kbd "C-x a") 'string-rectangle)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bf5bdab33a008333648512df0d2b9d9710bdfba12f6a768c7d2c438e1092b633" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" default)))
 '(inhibit-startup-screen t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;ehistにbackupを保存
 (setq backup-directory-alist '((".*" . "~/.ehist")))

;; rosemacs
(add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
;; or whatever your install space is + "/share/emacs/site-lisp"
(require 'rosemacs-config)

;;minimap
(require 'minimap)

;;roseamcs
(add-to-list 'load-path "/opt/ros/kinetic/share/emacs/site-lisp")
(require 'rosemacs-config)

;; jks standard
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-xL" 'goto-line)

;;; time
(load "time" t t)
(display-time)

;; euslime
(add-to-list 'load-path "/home/y-kawamura/euslime_dir/slime")
(add-to-list 'load-path "/home/y-kawamura/euslime_dir/euslime")
(add-to-list 'load-path "/home/y-kawamura/euslime_dir/slime-repl-ansi-color")
(require 'slime-autoloads)
(require 'euslime)
(setq inferior-lisp-program "sbcl")
(setq inferior-euslisp-program "roseus")
(setq slime-contribs '(slime-fancy slime-repl-ansi-color slime-banner))

(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
    (set-frame-parameter nil 'alpha (cons alpha-num '(90))))

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)


;;
;; whitespace
;;
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
;;                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

(global-whitespace-mode 1)

;;
;; saveする前に行末のwhite space を消す
;;
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)


;; markdown mode
;; (use-package markdown-mode
;;              :ensure t
;;              :commands (markdown-mode gfm-mode)
;;              :mode (("README\\.md\\'" . gfm-mode)
;;                     ("\\.md\\'" . markdown-mode)
;;                     ("\\.markdown\\'" . markdown-mode))
;;              :init (setq markdown-command "multimarkdown"))


;; カーソルを固定したままスクロール
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-down 1)))

;; spell check
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;;
(global-set-key (kbd "C-M-$") 'ispell-complete-word)
