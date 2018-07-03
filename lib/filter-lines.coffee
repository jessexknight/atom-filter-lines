{CompositeDisposable} = require 'atom'
# exports
module.exports =
  subscriptions: null

  # activation stuff with state
  activate: ->
    @toggle = false
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'filter-lines:toggle': => @main(@toggle)

  # standard deactivation stuff
  deactivate: ->
    @subscriptions.dispose()

  # main function
  main: (@toggle) ->

    # get the editor and current selection
    editor    = atom.workspace.getActiveTextEditor()
    selection = editor.getSelectedText().replace /[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&"

    # if we are not yet toggled on && we have selected something
    if !@toggle && !!selection

      # toggle on
      @toggle = true

      # scan the buffer for the selection (including multi-line)
      keep = []
      editor.scan new RegExp(selection,'g'), (m) ->
        keep.push.apply(keep,[m.range.start.row..m.range.end.row])

      # create binary vector of lines to fold
      tofold  = [0..editor.getLineCount()].map (x) => (keep.indexOf(x) == -1)

      # create fold blocks [[start,stop],[start,stop],...]
      folding = false
      blocks  = []
      for foldline,row in tofold
        if foldline
          if !folding                             # start new fold block
            start = row
            folding = true
          else if row == editor.getLineCount()-1  # end this fold block [eof]
            blocks.push([start,row])
        else
          if folding                              # end this fold block [new match]
            blocks.push([start,row-1])
            folding = false

      # apply folding
      for block in blocks
        editor.foldBufferRange([[block[0],0], [block[1],999]])

    # unfold everything
    else

      # toggle off
      @toggle = false
      editor.unfoldAll()
