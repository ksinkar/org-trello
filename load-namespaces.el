;; Not designed to be used from shell - helper to load the splitted namespaces from src/ and still be able to browse source code from emacs

(defvar *org-trello-namespaces-files* (expand-file-name "./namespaces.el") "Expand file so that we could use it directly with interactive command to reload code.")

(defun org-trello/load-ns (current-ns-file) "Load the current namespace file."
  (message "org-trello file: '%s' loading..." current-ns-file)
  (with-temp-file current-ns-file
    (insert-file-contents current-ns-file)
    (eval-buffer nil nil current-ns-file t t)
    (message "org-trello file: '%s' loaded!" current-ns-file)))

(defun org-trello/load-namespaces (splitted-files) "Load the src files."
  (message "org-trello files: %s" splitted-files)
  (mapc 'org-trello/load-ns splitted-files))

(defun org-trello/dev-load-namespaces ()
  "Load the namespace with interactive command"
  (interactive)
  (load-file *org-trello-namespaces-files*)
  (org-trello/load-namespaces *ORG-TRELLO-FILES*))

(org-trello/dev-load-namespaces)

(require 'org-trello-namespaces)

(org-trello/load-namespaces *ORG-TRELLO-FILES*)
