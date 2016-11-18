(function () {

    // Accedemos al módulo cafApp
    var app = angular.module("cafApp");
    // Servicio RestApi
    // Le inyectamos el servicio $resource
    app.controller("tipoUserController", ["$scope", "tipoUserService", function ($scope, tipoUserService) {
        // Obtener la lista del user
        $scope.selectedTipoUser = null;
        $scope.tipoUsers = tipoUserService.query();       
        
    }]);
})();


