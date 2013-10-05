@LApp.directive 'phrase', ->
  restrict: 'E'
  template: '<div>
      <span ng-click="showDef()">{{phrase.name}}</span>
      <a ng-href="" ng-click="showDef()">(more)</a>
      <a ng-href="" ng-click="removePhrase()" data-phrase-id="{{phrase.id}}">x</a>
      <div class="hidden">
        <table class="table table-condensed">
          <tr>
            <td>translation:</td>
            <td>{{phrase.translation}}</td>
          </tr>
          <tr>
            <td colspan="2">definition</td>
          </tr>
          <tr>
            <td colspan="2"><span ng-repeat="definition in phrase.definition | limitTo:2">{{definition}}; </span></td>
          </tr>
          <tr>
            <td>examples:</td>
          </tr>
          <tr>
            <td colspan="2"><span ng-repeat="example in phrase.examples | limitTo:2">{{example}}; </span></td>
          </tr>
          <tr>
            <td>related:</td>
          </tr>
          <tr>
            <td colspan="2"><span ng-repeat="word in phrase.words">{{word}}; </span></td>
          </tr>
        </table>
      </div>
    </div>'

  replace: true
  link: (scope, element, attrs) ->
    attrs.$observe 'phrase', (phrase) ->
      scope.phrase = phrase

    scope.showDef = ->
      $(element).find('div').toggleClass('hidden')

