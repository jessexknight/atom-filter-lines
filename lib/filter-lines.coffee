{CompositeDisposable} = require 'atom'
# exports
module.exports =
  subscriptions: null

  # activation stuff with state
  activate: ->
    @toggle = false
    @subscriptions = new CompositeDisposable
    @subscriptions.add(atom.commands.add('atom-text-editor',
      'filter-lines:filter': => @filter(@toggle,false)))
    @subscriptions.add(atom.commands.add('atom-text-editor',
      'filter-lines:filter-and-select': => @filter(@toggle,true)))
  # deactivation stuff
  deactivate: ->
    @subscriptions.dispose()

  # main function
  filter: (@toggle,select) ->

    # get the editor and current selection
    editor    = atom.workspace.getActiveTextEditor()
    selection = editor.getSelectedText()
    selection
    if selection.length < 32768
      selectionEscape = selection.replace /[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&"
    else
      atom.notifications.addWarning('Filter Lines', {
          'dismissable': true,
          'detail': 'Selection is too large'
        })
      return

    # if we are not yet toggled on && we have selected something
    # fold everything else
    if !@toggle && !!selection

      # toggle on
      @toggle = true

      # scan the buffer for the selection (including multi-line)
      matches = []
      editor.scan(new RegExp(selectionEscape,'g'), (m) =>
        matches.push.apply(matches,[m.range.start.row .. m.range.end.row]))

      # collect some variables
      N = editor.getLineCount()
      before = atom.config.get('filter-lines.before')
      after  = atom.config.get('filter-lines.after')

      # create a binary vector of lines to filter
      tokeep = (false for [0 .. N])
      mMin = matches.map((i) -> Math.min(N,Math.max(0, i - before)))
      mMax = matches.map((i) -> Math.min(N,Math.max(0, i + after)))
      for m,i in matches
        tokeep[mMin[i]..mMax[i]] = (true for [mMin[i]..mMax[i]])
        # if in "filter-and-select" mode: add selection for each range
        if select
          editor.addSelectionForBufferRange([[mMin[i],0],[mMax[i],999]])

      # create fold blocks [ [[row-start,col-start],[row-end,col-end]], ... ]
      folding = false
      blocks = []
      for keep,i in tokeep                          # start a new fold block
        if ((!folding) and (!keep))
          start = i
          folding = true
        if (( folding) and ( keep)) or (i == N-1)   # end this fold block
          end = i-1
          folding = false
          blocks.push([[start,0],[end,999]])

      # apply folding
      for block in blocks
        editor.foldBufferRange(block)

    # else: unfold all blocks
    else

      # toggle off
      @toggle = false
      editor.unfoldAll()
