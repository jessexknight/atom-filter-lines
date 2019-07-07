# Filter Lines Package

Filter lines based on the current text selection (including multi-line selections)

## Keybindings:

| Original | Filter | Filter & Select |
| -------- | ------ | --------------- |
|          | <kbd>ctrl</kbd>+<kbd>cmd</kbd>+<kbd>f</kbd> | <kbd>ctrl</kbd>+<kbd>cmd</kbd>+<kbd>alt</kbd>+<kbd>f</kbd> |
|![original](https://github.com/jessexknight/atom-filter-lines/blob/master/docs/img/original.png?raw=true)|![filter](https://github.com/jessexknight/atom-filter-lines/blob/master/docs/img/filter.png?raw=true)|![filter-and-select](https://github.com/jessexknight/atom-filter-lines/blob/master/docs/img/filter-and-select.png?raw=true)

## To Do:

- `[ ]` Find-and-Replace like panel with:
  - `[ ]` RegExp support
  - `[ ]` Case support
- `[x]` Option to fold to zero lines instead of one (with `...`)
- `[ ]` Option to expand children of all filtered lines (e.g. for editing a list of json objects)
- `[ ]` Preserve pre-filter folding after toggle off using hidden state
- `[x]` hidden *Toggle* state
- `[x]` flexible number of lines to keep before / after match
- `[x]` option to select result

## Thanks:

This package was inspired by:
- [hide-lines](https://atom.io/packages/hide-lines)
- [highlight-selected](https://atom.io/packages/highlight-selected)
