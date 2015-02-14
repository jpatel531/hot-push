HotPushView = require './hot-push-view'
{CompositeDisposable} = require 'atom'

pusher = require '../config/pusher'

module.exports = HotPush =
  hotPushView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @hotPushView = new HotPushView(state.hotPushViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @hotPushView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'hot-push:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @hotPushView.destroy()

  serialize: ->
    hotPushViewState: @hotPushView.serialize()

  toggle: ->
    @editor = atom.workspace.getActiveEditor()
    @editor.onDidSave =>
      text = @editor.getText()
      pusher.trigger 'hot_channel', 'css',
        "css": text
