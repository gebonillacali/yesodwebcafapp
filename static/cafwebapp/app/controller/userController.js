(function () {

    // Accedemos al módulo cafApp
    var app = angular.module("cafApp")
    // Servicio RestApi
    // Le inyectamos el servicio $resource
    app.controller("usersController", ["$scope", "userService", function ($scope, userService) {
        // Obtener la lista del user
        $scope.users = userService.query();
        $scope.date = new Date();
        // Declarar la variable edit en el controlador
        $scope.edit = {};
        // Añadir un contacto
        $scope.addUser = function (user) {
            // Ejecutar el método save para guardar el user
            userService.save(user)
                    // Al guardar el user correctamente
                    .$promise.then(
                            function (response) {
                                // Añadir los datos del contacto al array del user
                                $scope.users.push({
                                    id: response.id,
                                    nombre: response.nombre,
                                    fechaNacimiento: response.fechaNacimiento,
                                    genero: response.genero,
                                    identificacion: response.identificacion,
                                    email: response.email,
                                    tipoUsuario: response.tipoUsuario,
                                    rh: response.rh,
                                    fechaRegistro: response.date
                                });
                                // Reemplazar la variable contacto del scope
                                // por un objeto vacío para que el formulario
                                // quede limpio
                                $scope.user = {};
                            }

                    );
        };
        // Editar un user
        $scope.editUser = function (user) {
            // Llamar al método update (PUT)
            userService.update({ id: user.id }, user)
                    .$promise.then(
                            // Eliminar la variable respectiva al id del user del objeto edit
                                    function (response) {
                                        delete $scope.edit[user.id];
                                    }
                            );
        };
        // Eliminar user
        $scope.deleteUser = function (user) {
            userService.delete(user)
                    // Cuando se haya borrado correctamente el contacto del servidor
                    .$promise.then(
                            function () {
                                $scope.users.splice($scope.users.indexOf(user), 1);
                            }
                    );
        };
        // Mostrar la edición
        $scope.showEdition = function ($event, id) {

            // Asignar valor true la variable representada por el id del contacto
            // Esto provocará que se muestren los elementos respectivos a la edición
            // y se oculten los spans y el botón de eliminar contacto
            $scope.edit[id] = true;
            // Con $event.currentTarget accedemos al elemento que ha lanzado el evento
            // Guiándonos por este elemento accedemos mediante jQuery al input que está debajo del mismo
            var input = angular.element($event.currentTarget).parent().find("input")[0];
            // Después de 50 milisegundos hacemos que el input tome el foco
            // Y que el texto que contiene se seleccione
            setTimeout(function () {
                input.focus();
                input.select();
            }, 50);
        };
    }]);
})();


