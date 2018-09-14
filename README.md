# Filter Lines Package

Filter lines based on the current text selection (including multi-line selections)

| Original | Default | Cozy |
| -------- | ------- | ---- |
|![original](https://github.com/jessexknight/atom-filter-lines/blob/master/docs/img/original.png?raw=true)|![default](https://github.com/jessexknight/atom-filter-lines/blob/master/docs/img/default.png?raw=true)|![cozy](https://github.com/jessexknight/atom-filter-lines/blob/master/docs/img/cozy.png?raw=true)

## Keybinding:

<kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>f</kbd>: Toggles line filtering

## Settings:

| Setting | default | Description                                          |
| ------- | ------- | ---------------------------------------------------- | 
| Cozy    | `false` | No gaps between filtered lines (default is one line) |

## To Do:

- `[ ]` Find-and-Replace like panel with:
  - `[ ]` RegExp support
  - `[ ]` Case support
- `[x]` Option to fold to zero lines instead of one (with `...`)
- `[ ]` Option to expand children of all filtered lines (e.g. for editing a list of json objects)
- `[ ]` Preserve pre-filter folding after toggle off using hidden state
- `[x]` hidden **Toggle** state

## Thanks

This package was inspired by:
- [hide-lines](https://atom.io/packages/hide-lines)
- [highlight-selected](https://atom.io/packages/highlight-selected)
