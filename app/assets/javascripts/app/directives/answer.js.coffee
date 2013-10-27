@LApp.directive 'flashcardanswer', ->
  restrict: 'E'
  scope: { answer:'=answer' }
  template: '
        <div class="answer-content">
        <table class="table table-condensed">
          <tr>
            <td class="heading">sentence:</td>
            <td>{{answer.sentence}}</td>
          </tr>
          <tr>
            <td class="heading">definition</td>
            <td ><div ng-repeat="definition in answer.definition">{{definition}}; </div></td>
          </tr>
        </table>

        <p><a ng-click="showMore()">show more</a></p>

        <table class="table table-condensed more hidden">
          <tr>
            <td class="heading">translation:</td>
            <td>{{answer.translation}}</td>
          </tr>
          <tr>
            <td class="heading">examples:</td>
            <td><div ng-repeat="example in answer.examples | limitTo:3">{{example}}; </div></td>
          </tr>
          <tr>
            <td class="heading">related:</td>
            <td><span ng-repeat="word in answer.related">{{word}}; </span></td>
          </tr>
        </table>
        </div>
        '
  replace: true

  link: (scope, element, attrs) ->
    el = $(element).find('.more')

    scope.$watch 'answer', ->
      el.addClass('hidden')

    scope.showMore = (e)->
      el.toggleClass('hidden')


