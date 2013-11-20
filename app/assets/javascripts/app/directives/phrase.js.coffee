@LApp.directive 'phrase', ->
  restrict: 'E'
  template: '<div class="{{phrase.loading}}">
      <span ng-click="showDef()" class="phrase-name">{{phrase.name}}</span>
      <span class="small-indicator"></span>
      <a ng-href="" class="remove-phrase" ng-click="removePhrase()" data-phrase-id="{{phrase.id}}">x</a>
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
            <td>sentence:</td>
          </tr>
          <tr>
            <td colspan="2"><span>{{phrase.sentence}}</span></td>
          </tr>
          <tr>
            <td>related:</td>
          </tr>
          <tr>
            <td colspan="2"><span ng-repeat="word in phrase.related">{{word}}; </span></td>
          </tr>
        </table>
      </div>
    </div>'

  replace: true
  link: (scope, element, attrs) ->
    attrs.$observe 'phrase', (phrase) ->
      scope.phrase = phrase
      $(element).find('.phrase-name').addClass('link')

    scope.showDef = ->
      $(element).find('div').toggleClass('hidden')

