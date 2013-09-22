LApp.factory 'Key', ()->
  key = {}

  keyUp = 38
  keyDown = 40
  backspace = 8
  tab = 9

  key.isSpecial = (keyCode)->
    [keyUp, keyDown, backspace, tab].indexOf(keyCode) != -1

  key.isTab = (keyCode) ->
    tab == keyCode

  key.isBackspace = (keyCode) ->
    backspace == keyCode

  key.isKeyUp = (keyCode) ->
    keyUp == keyCode

  key.isKeyDown = (keyCode) ->
    keyDown == keyCode

  key
