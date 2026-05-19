;; battery: text — general plaintext utilities.

(defalias :name "lc"   :value "wc -l")
(defalias :name "uc"   :value "sort | uniq -c | sort -rn")  ; sorted freq
(defalias :name "ud"   :value "awk '!seen[$0]++'")          ; dedupe preserving order
(defalias :name "rev1" :value "rev")

;; lines [N] — print first N lines (default 10) without invoking `head`.
(defun :name "lines"
       :body "head -n \"${1:-10}\"")

;; tail-fln [N] — tail-follow N lines (default 50).
(defun :name "tail-fln"
       :body "tail -f -n \"${1:-50}\" \"${2:-/dev/stdin}\"")

;; trim — strip leading/trailing whitespace per line.
(defun :name "trim"
       :body "awk '{$1=$1; print}'")

;; cols N — print the Nth whitespace-delimited column.
(defun :name "cols"
       :body "awk -v n=\"$1\" '{print $n}'")

;; len — print byte+char+word counts of stdin.
(defun :name "len"
       :body "wc -c -m -w")
