#!/usr/bin/env bash
emacs --batch --eval "
(progn (find-file \"$1\")
    (if (string-equal \"darwin\" (symbol-name system-type))
        (setq erlang-root-dir (car (file-expand-wildcards \"/usr/local/Cellar/erlang/R*\")))
        (setq erlang-root-dir \"/usr/lib/erlang/\"))
    (setq load-path (cons (car (file-expand-wildcards (concat erlang-root-dir \"/lib/erlang/lib/tools-*/emacs\"))) load-path))
    (require 'erlang-start)
    (erlang-mode)
    (untabify (point-min) (point-max))
    (delete-trailing-whitespace)
    (erlang-indent-current-buffer)
    (save-buffer)
    (save-buffers-kill-emacs))" > /dev/null 2>&1




