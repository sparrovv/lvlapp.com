LApp.factory 'Key', ()->
  key = {}

  keyUp = 38
  keyDown = 40
  keyLeft = 37
  backspace = 8
  enter = 13
  tab = 9
  spacebar = 32

  key.isSpecial = (keyCode)->
    [keyUp, enter, keyDown, backspace, tab, spacebar].indexOf(keyCode) != -1

  key.isTab = (keyCode) ->
    tab == keyCode

  key.isBackspace = (keyCode) ->
    backspace == keyCode

  key.isKeyUp = (keyCode) ->
    keyUp == keyCode

  key.isKeyDown = (keyCode) ->
    keyDown == keyCode

  key.isEnter= (keyCode) ->
    enter == keyCode

  key.isKeyLeft= (keyCode) ->
    keyLeft == keyCode

  key.isSpacebar = (keyCode) ->
    spacebar == keyCode

  key
