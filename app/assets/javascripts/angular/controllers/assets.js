(function(){

  var AssetsController = function($scope, $http, assetsFactory){

    $scope.assets = []

    assetsFactory.getAssets().then(
      function(response){
        $scope.assets = response.data;
      }
    );

  };

  AssetsController.$inject = ['$scope', '$http', 'assetsFactory'];

  angular.module('everystreet')
    .controller('AssetsController', AssetsController);

}());
