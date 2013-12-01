@LApp.directive 'pline', ->
  restrict: 'E'
  template: '
    <p data-line-id={{line.htmlId()}} class="{{heighlight()}}">
      <span class="word" ng-click="addPhrase(this)" ng-repeat="word in line.words()">
        <span class="raw-word" title="Add to pharsebook" ng-bind-html-unsafe="word">&nbsp;</span>
      </span>
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

    # THOSE COMMENTS ARE for future reference, so maybe I'll implement blinking :-)
    # scope.$watch 'currentLine', ->
    # attrs.$observe 'word', (word) ->
      #if scope.line.id == scope.currentLine.id
        #if word.match /•/
        #scope.wib =  word.replace(/•{1}/, '<blink>•</blink>')
        #console.log 'foo'
