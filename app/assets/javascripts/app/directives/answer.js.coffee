@LApp.directive 'flashcardanswer', ->
  restrict: 'E'
  scope: { answer:'=answer' }
  template: '
        <table class="table table-condensed">
          <tr>
            <td>translation:</td>
            <td>{{answer.translation}}</td>
          </tr>
          <tr>
            <td>definition</td>
            <td ><div ng-repeat="definition in answer.definition">{{definition}}; </div></td>
          </tr>
          <tr>
            <td>examples:</td>
            <td><div ng-repeat="example in answer.examples | limitTo:3">{{example}}; </div></td>
          </tr>
          <tr>
            <td>related:</td>
            <td><span ng-repeat="word in answer.related">{{word}}; </span></td>
          </tr>
        </table>
        '
  replace: true
