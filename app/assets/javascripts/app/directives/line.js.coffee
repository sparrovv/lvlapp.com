@LApp.directive 'pline', ->
  restrict: 'E'
  template: '
    <p class="{{heighlight()}}">
      <span
        class="word {{isMissingWord(word)}}"
        ng-click="addPhrase(this)"
        ng-bind-html-unsafe="word + \' \'"
        ng-repeat="word in line.words()"></span>
    </p>
  '
  scope: { line:'=line', addToPhrasebook: '&', currentLine: '=currentLine' }
  replace: true

  link: (scope, element, attrs) ->
    scope.addPhrase = (thiz) ->
      scope.addToPhrasebook {phrasedata:{word: thiz.word, sentence: scope.line.text}}

    scope.heighlight = ->
      if scope.line.index == scope.currentLine.index
        'highlight'

    scope.isMissingWord = (word)->
      if word.indexOf('_') != -1
        'missing-word'
