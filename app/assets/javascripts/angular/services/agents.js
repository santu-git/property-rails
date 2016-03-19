(function(){

  var AgentsFactory = function($http){

    var factory = {};

    factory.getAgents = function() {
      return $http.get('/admin/agents/json');
    };

    return factory;

  };

  angular.module('everystreet').factory('agentsFactory', AgentsFactory);

}());