@LApp.directive 'phrase', ->
  restrict: 'E'
  template: '<div>
      <span ng-click="showDef()">{{phrase.name}}</span>
      <a ng-href="" ng-click="showDef()">(more)</a>
      <a ng-href="" ng-click="removePhrase()" data-phrase-id="{{phrase.id}}">x</a>
      <p class="hidden">{{phrase.translation}}</p>
      <p class="hidden">{{phrase.definition}}</p>
      <p class="hidden">{{phrase.examples}}</p>
      <p class="hidden">{{phrase.related}}</p>
    </div>'

  replace: true
  link: (scope, element, attrs) ->
    attrs.$observe 'phrase', (phrase) ->
      scope.phrase = phrase

    scope.showDef = ->
      $(element).find('p').toggleClass('hidden')

