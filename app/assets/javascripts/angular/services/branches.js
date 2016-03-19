(function(){

  var BranchesFactory = function($http){

    var factory = {};

    factory.getBranches = function(id) {
      return $http.get('/admin/branches/json?id=' + id);
    };

    return factory;

  };

  angular.module('everystreet').factory('branchesFactory', BranchesFactory);

}());
