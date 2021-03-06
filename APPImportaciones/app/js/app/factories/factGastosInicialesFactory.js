/**
 * Factoria de facturas gastos iniciales Corresponde al controller de 
 * http://base_url/app/index.php/factgstinicial70/
 *
 * @package    cordovezApp JS
 * @author    Eduardo Villota <eduardouio7@gmail.com>
 * @copyright    Copyright (c) 2014,  Agencias y Representaciones Cordovez S.A.
 * @license    Todos los derechos reservados Agencias y Representaciones Cordovez S.A.
 * @link    https://github.com/eduardouio/APPImportaciones
 * @since    Version 1.0.0
 * @filesource
 */
cordovezApp.factory('factgstinicialesFactory' , ['$http', '$rootScope', '$q' ,
											 function($http, $rootScope, $q){

    console.log('[Debug] factgstinicialesFactory');
    var serviceBase = host + 'index.php/factgstinicial70/';
    
    //funciones comunes de login 
    function httpGet(url){
    	var deferred = $q.defer();
    	var promise = deferred.promise;

    	$http.get(serviceBase + url ).then(
    		function(response){
    			return deferred.resolve(response.data);
    		}, function(error){
    			return deferred.reject(error);
    		});
    	return promise;
    }

    //funcion estandar para Post
    function httpPost(url, data){
    	var deferred = $q.defer();
    	var promise = deferred.promise;

    	$http.post(serviceBase + url , data).then(
    		function (response){
    			return deferred.resolve(response.data);
    		}, function(error){
    			return deferred.reject(error);
    		});
    	return promise;
    }

	var service = {};

    //app/index.php/factgstinicial70/presentar/:idFactGastInicial
    service.getInvInitExpenses = function(idInvoice){
      console.log('[Debug] service.getInvInitExpenses');
      return httpGet('presentar/' + idInvoice);
    };


    //app/index.php/factgstinicial70/listar/
    service.listInvInitExpenses = function (){
      console.log('[Debug] service.listInvInitExpenses');
      return httpGet('listar');
    };

    //app/index.php/factgstinicial70/listar/:idGastosIniciales
    service.getIniExpensesByInitExpenses = function(idInvInitExpense){
      console.log('[Debug] service.getIniExpensesByInitExpenses');
      return httpGet('listar/' + idInvInitExpense)
    };

    //app/index.php/factgstinicial70/listar/0/:idFacPagosPedido
    service.getIniExpensesByInvExpenses = function(ifInvExpenses){
      console.log('[Debug] service.getIniExpensesByInvExpenses');
      return httpGet('listar/0/' + ifInvExpenses);
    };

    //app/index.php/factgstinicial70/validar => create & update
    service.piuInvInitExpense = function(invExpenses){
      console.log('[Debug] service.piuInvInitExpense');
      return httpPost('validad' , invExpenses);
    };

    //app/index.php/factgstinicial70/eliminar/:idInvInitExpense
    service.delInvInitExpense = function(idInvInitExpense){
      console.log('[Debug] service.delInvInitExpense');
      return httpGet('eliminar' + idInvInitExpense)
    };


    return service;

}]);