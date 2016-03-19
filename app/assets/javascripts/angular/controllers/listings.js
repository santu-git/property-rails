(function(){

  var ListingController = function($scope, $http, departmentsFactory, agentsFactory, branchesFactory){

    $scope.departments = [];
    $scope.agents = [];
    $scope.branches = [];

    $scope.changeDepartment = function(){
      toggleDeparmentContent();
    };

    $scope.changeAgent = function(){
      loadBranches();
    }

    $scope.$watch('agents',function(oldVal, newVal){
      if (oldVal !== newVal){
        loadBranches();
      }
    });

    function loadDepartments(){
      departmentsFactory.getDepartments().then(
        function(response){
          $scope.departments = response.data;
          $scope.department = $scope.departments[0];
          toggleDeparmentContent();
        }
      );      
    }

    function loadAgents(){
      agentsFactory.getAgents().then(
        function(response){
          $scope.agents = response.data;
          $scope.agent = $scope.agents[0];
        }
      );          
    }

    function loadBranches(){
      branchesFactory.getBranches($scope.agent.id).then(
        function(response){
          $scope.branches = response.data;
          $scope.branch = $scope.branches[0];
        }
      );           
    }    

    function toggleDeparmentContent(){
      switch($scope.department.id){
        case 1:
          angular.element('.to-let').hide();
          angular.element('.for-sale').show();
          break;
        case 2:
          angular.element('.to-let').show();
          angular.element('.for-sale').hide();
          break;
      }        
    }

    function init(){
      loadDepartments();
      loadAgents();
    }

    init();

  };

  ListingController.$inject = ['$scope', '$http', 'departmentsFactory', 'agentsFactory', 'branchesFactory'];

  angular.module('everystreet')
    .controller('ListingController', ListingController);

}());
