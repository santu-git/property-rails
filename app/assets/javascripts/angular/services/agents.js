(function(){

  var AgentsFactory = function($http){

    var factory = {};

    factory.getAgents = function() {
      return $http.get('/admin/agents/json');
    };

    return factory;

  };
  
  AgentsFactory.$inject = ['$http'];

  angular.module('everystreet').factory('agentsFactory', AgentsFactory);

}());