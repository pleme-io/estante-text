;; battery: csv — qsv / xsv with column-name conveniences.

;; cprev FILE — preview the first 10 rows as a table.
(defun :name "cprev"
       :body "if command -v qsv >/dev/null 2>&1; then qsv slice -e 10 \"$1\" | qsv table; elif command -v xsv >/dev/null 2>&1; then xsv slice -e 10 \"$1\" | xsv table; else head -n 11 \"$1\" | column -ts,; fi")

;; ccols FILE — print column names.
(defun :name "ccols"
       :body "if command -v qsv >/dev/null 2>&1; then qsv headers \"$1\"; elif command -v xsv >/dev/null 2>&1; then xsv headers \"$1\"; else head -n 1 \"$1\" | tr ',' '\\n'; fi")

;; cwc FILE — row count (excluding header).
(defun :name "cwc"
       :body "if command -v qsv >/dev/null 2>&1; then qsv count \"$1\"; else echo $(( $(wc -l < \"$1\") - 1 )); fi")

;; cselect COLS FILE — select columns by name, comma-separated.
(defun :name "cselect"
       :body "if command -v qsv >/dev/null 2>&1; then qsv select \"$1\" \"$2\"; elif command -v xsv >/dev/null 2>&1; then xsv select \"$1\" \"$2\"; else die 'cselect requires qsv or xsv'; fi")
