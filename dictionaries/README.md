# SKK dictionary

`SKK-JISYO.L` is a bundled, unmodified copy of the SKK Development Team's large dictionary, downloaded directly from the upstream distribution.

- Upstream: https://skk-dev.github.io/dict/
- Source: https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L
- Downloaded: 2026-10-06
- SHA-256: `c791f578d1b4040fce282db29bc22b2cc7ea46f83e269fab2e0fa779e2967e40`
- Encoding: EUC-JP (automatically detected by skkeleton)
- License: GNU GPL version 2 or later; see `COPYING` and the dictionary header.

The dictionary is tracked in Git so cloning this configuration also supplies the conversion dictionary. Personal learned entries remain in skkeleton's user dictionary and are not bundled here.

Upstream includes public proper nouns such as names and places. Private vocabulary belongs in an external dictionary configured with `vim.g.skk_dictionary_path`, or in skkeleton's external user dictionary. Do not add personal dictionaries to this directory.
