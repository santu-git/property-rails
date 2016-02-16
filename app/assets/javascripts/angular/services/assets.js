(function(){

  var AssetsFactory = function($http){

    var factory = {};

    factory.getAssets = function() {
      return $http.get('/admin/assets/json');
    };

    return factory;

  };

  angular.module('everystreet').factory('assetsFactory', AssetsFactory);

}());
