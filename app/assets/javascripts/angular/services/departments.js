(function(){

  var DepartmentsFactory = function($http){

    var factory = {};

    factory.getDepartments = function() {
      return $http.get('/admin/departments/json');
    };

    return factory;

  };

  angular.module('everystreet').factory('departmentsFactory', DepartmentsFactory);

}());