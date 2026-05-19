;; battery: json — jq-powered conveniences.

(defalias :name "jq."  :value "jq .")               ; pretty-print stdin
(defalias :name "jqr"  :value "jq -r")              ; raw (no quotes)
(defalias :name "jqc"  :value "jq -c")              ; compact one-per-line
(defalias :name "jql"  :value "jq 'length'")        ; length of input
(defalias :name "jqk"  :value "jq 'keys'")          ; keys of object
(defalias :name "jqv"  :value "jq '.[]'")           ; values of object / array

;; jget PATH — extract one value: `jget .foo.bar < file`. Empty path
;; → `.` (pretty-print the whole thing).
(defun :name "jget"
       :body "jq -r \"${1:-.}\"")

;; jvalid — exit 0 iff stdin is valid JSON.
(defun :name "jvalid"
       :body "jq empty 2>/dev/null && return 0 || return 1")

;; jcount — count top-level array elements (or keys for an object).
(defun :name "jcount"
       :body "jq 'if type == \"array\" then length elif type == \"object\" then (keys | length) else 1 end'")
