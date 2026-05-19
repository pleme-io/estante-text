;; battery: yaml — yq-powered conveniences.

(defalias :name "yq."  :value "yq .")
(defalias :name "yqr"  :value "yq -r")
(defalias :name "y2j"  :value "yq -o json .")        ; yaml → json
(defalias :name "j2y"  :value "yq -P -o yaml .")     ; json → yaml

;; yget PATH — `yget .metadata.name < deploy.yaml`.
(defun :name "yget"
       :body "yq -r \"${1:-.}\"")

;; yvalid — exit 0 iff stdin is valid YAML.
(defun :name "yvalid"
       :body "yq empty 2>/dev/null && return 0 || return 1")

;; ydiff A B — pretty diff two YAML files via yq normalization.
(defun :name "ydiff"
       :body "diff <(yq -P . \"$1\") <(yq -P . \"$2\")")
