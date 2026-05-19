# estante-text

Four batteries for structured-data + plaintext wrangling.

| Battery | Helpers |
|---|---|
| `json` | `jq.`/`jqr`/`jqc`/`jql`/`jqk`/`jqv` aliases + `jget PATH`, `jvalid`, `jcount` |
| `yaml` | `yq.`/`yqr`/`y2j`/`j2y` + `yget`, `yvalid`, `ydiff A B` |
| `csv` | `cprev`, `ccols`, `cwc`, `cselect COLS FILE` — qsv → xsv → coreutils fallback |
| `text` | `lc`/`uc`/`ud` aliases + `lines`, `tail-fln`, `trim`, `cols N`, `len` |

## Install

```bash
estante add github:pleme-io/estante-text@v0.1.0
estante lock && estante install
```

`(defload :pkg "estante-text")` or `. .../store/estante-text/init.bash`.
