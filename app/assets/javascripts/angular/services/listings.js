(function(){

  var ListingsFactory = function($http){

    var factory = {};

    factory.getListing = function($id) {
      return $http.get('/admin/listings/' + $id + '/edit?format=json');
    };

    return factory;

  };
  
  ListingsFactory.$inject = ['$http'];

  angular.module('everystreet').factory('listingsFactory', ListingsFactory);

}());