(function(){

  var BranchesFactory = function($http){

    var factory = {};

    factory.getBranches = function(id) {
      return $http.get('/admin/branches/json?id=' + id);
    };

    return factory;

  };
  
  BranchesFactory.$inject = ['$http'];

  angular.module('everystreet').factory('branchesFactory', BranchesFactory);

}());
