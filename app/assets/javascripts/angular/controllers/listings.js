(function(){

  var ListingController = function($scope, $http, $location, departmentsFactory, agentsFactory, branchesFactory, listingsFactory){

    $scope.departments = [];
    $scope.agents = [];
    $scope.branches = [];

    $scope.changeDepartment = function(){
      toggleDeparmentContent();
    };

    $scope.changeAgent = function(){
      loadBranches();
    }

    function loadDepartments(){
      departmentsFactory.getDepartments().then(
        function(response){
          $scope.departments = response.data;
          if ($scope.listing){
            // Listing has loaded so its an editing job
            // Iterate through the loaded departments 
            for(i = 0; i < $scope.departments.length; i++){
              // Check if the department id chosen in the listing is the same
              // as the id of the department in the current iteration
              if ($scope.listing.department_id === $scope.departments[i].id){
                // It is, so set the $scope.department variable to the item in the
                // departments array
                $scope.department = $scope.departments[i];
                // Break the loop
                break;
              }
            }
          }else{
            // Listing has not loaded so its a new thing
            $scope.department = $scope.departments[0];
          }
          // Change the form based on department chosen
          toggleDeparmentContent();
        }
      );      
    } 

    function loadAgents(){
      // Load the agents
      agentsFactory.getAgents().then(function(response){
        // Set scope.agents to response data
        $scope.agents = response.data;
        // Check if the scope has the listing variable, indicating
        // that this is an edit
        if ($scope.listing){
          // Go through agents 
          for(i = 0; i < $scope.agents.length; i++){
            // If the agent id matches the agent_id set for the listing
            // then set the $scope.agent variable to match this one and
            // then kill the loop
            if ($scope.agents[i].id === $scope.listing.agent_id){
              $scope.agent = $scope.agents[i];
              break;
            }
          }
        }else{
          // Is not editing, so just select the first agent
          $scope.agent = $scope.agents[0];
        }
      });
    }

    // Watch the agents variable to only call function to load branches
    // only when the agents are loaded
    $scope.$watch('agents', function(oldVal, newVal){
      if (oldVal !== newVal){
        loadBranches();
      }
    });

    function loadBranches(){
      // Load the branches for currently selected agent
      branchesFactory.getBranches($scope.agent.id).then(function(response){
        // Set scope.branches to response data
        $scope.branches = response.data;
        // Check if the listing variable on scope is set. If it is then we
        // are going to set the branch to the value of this, otherwise, we 
        // are going to set the branch to the first branch
        if ($scope.listing){
          // Iterate through the branches we have for the selected agent
          for(i = 0; i < $scope.branches.length; i++){
            // Check if the id of the branch we are iterating through is
            // the same as that set for the listing. If it is set $scope.branch
            // to this 
            if ($scope.branches[i].id === $scope.listing.branch_id){
              $scope.branch = $scope.branches[i];
              break;
            }
          }
        }else{
          // Set the first item in branches array to selected branch
          $scope.branch = $scope.branches[0];        
        }
      });
    }

    function loadListing(){
      // Get the url and split by /
      var parts = $location.absUrl().split('/');
      // Get the final item in the array and check if
      // we are editing
      if (parts[parts.length - 1] === 'edit'){
        // Get the second from end of array item as this is the id
        // of the record being edited
        var id = parts[parts.length - 2];
        // Load the listing
        listingsFactory.getListing(id).then(function(response){
          // On response, set listing variable to response
          $scope.listing = response.data;
          // Load departments
          loadDepartments();
          // Load agents
          loadAgents();
        });
      }else{
        // Load departments
        loadDepartments();
        // Load agents
        loadAgents();
      }
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
      loadListing();
    }

    init();

  };

  ListingController.$inject = ['$scope', '$http', '$location', 'departmentsFactory', 'agentsFactory', 'branchesFactory', 'listingsFactory'];

  angular.module('everystreet')
    .controller('ListingController', ListingController);

}());
