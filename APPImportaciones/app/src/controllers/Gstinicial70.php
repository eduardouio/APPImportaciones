<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * Modulo encargado de manejar los proveedores, CRUD y validaciones
 *
 * @package    CordovezApp
 * @author    Eduardo Villota <eduardouio7@gmail.com>
 * @copyright    Copyright (c) 2014,  Agencias y Representaciones Cordovez S.A.
 * @license    Derechos reservados Agencias y Representaciones Cordovez S.A.
 * @link    https://github.com/eduardouio/APPImportaciones
 * @since    Version 1.0.0
 * @filesource
 */
class Gstinicial70 extends MY_Controller {
	private $resultDb;
	private $controllerSPA = "gastos_iniciales_r70";
	private $responseHTTP = array("status" => "success");
	private $viewData;

	/**
	 * Constructor de la funcion
	 */
	public function __construct(){
		parent::__construct();
	}


	/**
	 * Lista los gastos inciales de acuerdo a tres criterios
	 * Por pedido $idPedido != 0
	 * Por Gasto inicial idGstInicial != 0
	 * Todos los registros si los dos valores no existe $idPedido &
   * $idGstInicial = 0
	 * @return array JSON
	 */
	public function listar($idPedido = 0, $idGstInicial = 0){
		#Listamos los gastos_iniciales_r70 de un pedido
			if($idPedido != 0 && $idGstInicial == 0){
        $this->db->where('nro_pedido', $idPedido);
				$this->resultDb = $this->db->get($this->controllerSPA);
			}elseif($idPedido == 0 && $idGstInicial != 0){
				$this->db->where('id_gastos_iniciales', $idGstInicial);
				$this->resultDb = $this->db->get($this->controllerSPA);

			}else{
        $this->resultDb = $this->db->get($this->controllerSPA);
      }

			if($this->resultDb->num_rows() > 0){
			$this->responseHTTP["data"] = $this->resultDb->result_array();
			$this->responseHTTP["message"] = "Se encontraron " .
								$this->resultDb->num_rows() . " registros";
			$this->responseHTTP["appst"] = 1100;
		}else{
			$this->responseHTTP["data"] = $this->resultDb->result_array();
			$this->responseHTTP["message"] = "No existen registros almacenados";
			$this->responseHTTP["appst"] = 2100;
		}
			$this->__responseHttp($this->responseHTTP, 200);

	}
	/**
	 	$this->responseHTTP["appst"] =*  Valida los datos recibidos por post 
	 	antes de crear o actualizar el registro, solo aceptan datos por post
	 * @return array JSON
	 */
	public function validar(){
		if($this->rest->_getRequestMethod()!= 'POST'){
			$this->_notAuthorized();
		}

		$request = json_decode(file_get_contents('php://input'), true);
		$gstIncial70 = $request['gastos_iniciales_r70'];
		#verificamos que el registro existe
		$this->db->where('nro_pedido',$gstIncial70['nro_pedido']);
		$this->db->where('concepto',$gstIncial70['concepto']);
		$this->resultDb = $this->db->get($this->controllerSPA);
		if($this->resultDb->num_rows() != null && 
											   $request['accion'] == 'create'){
			$this->responseHTTP['message'] = 'Ya existe un pedido'.
			 									  'con el mismo identificador';
			$this->responseHTTP["appst"] = 2300;
			$this->responseHTTP['data'] = $this->resultDb->result_array();
			$this->responseHTTP['lastInfo'] = $this->mymodel->lastInfo();
			$this->__responseHttp($this->responseHTTP, 200);
		}else{
		#validamos la informacion
			$status = $this->_validData($gstIncial70);
			if ($status['status']){
				if ($request['accion'] == 'create'){
					$this->db->insert($this->controllerSPA, $gstIncial70);
					$this->responseHTTP['message'] = 'Registro creado'.
					 										   'existosamente';
					$this->responseHTTP["appst"] =1200;
					$this->responseHTTP['lastInfo'] = 
													$this->mymodel->lastInfo();
					$this->__responseHttp($this->responseHTTP, 201);
				}else{
					$gstIncial70['last_update'] = date('Y-m-d H:i:s');
					$this->db->where('id_gastos_iniciales',
											  $request['id_gastos_iniciales']);
					$this->db->update($this->controllerSPA, $gstIncial70);
					$this->responseHTTP['message'] = 'Registro actualizado';
					$this->responseHTTP["appst"] = 1300;
					$this->__responseHttp($this->responseHTTP, 201);
				}
			}else{
				$this->responseHTTP['message'] = 'Uno de los datos ingresados'.
				 							'es incorrecto, vuelva a intentar';
				$this->responseHTTP["appst"] = 1400;
				$this->responseHTTP['data'] = $status;
				$this->__responseHttp($this->responseHTTP, 200);
			}
		}

	}

	/**
	 * Elimina un registro de la tabla
	 * dependencias
	 * @return array JSONPedidos
	 */
	public function eliminar($idGstInicial){
		$this->db->where('id_gastos_iniciales' , $idGstInicial);
		$this->resultDb = $this->db->get($this->controllerSPA);

		if  ($this->resultDb->num_rows() > 0){
			#comprobamos que no tenga dependencias
			$this->db->where('id_gastos_iniciales' , $idGstInicial);
			$this->resultDb = 
					  $this->db->get('factura_pagos_pedido_gasto_inicial_r70');

			if(!$this->resultDb->num_rows() > 0){
				$this->db->where('id_gastos_iniciales' , $idGstInicial);
				$this->db->delete($this->controllerSPA);
				$this->responseHTTP['message'] = 'Regitro eliminado'.
															   'correctamente';
				$this->responseHTTP["appst"] = 1500;
			}else{
				$this->responseHTTP['message'] = 'El Registro tiene'.
				 			             'dependencias no puede ser eliminado';
				$this->responseHTTP["appst"] = 2400;
			}
		}else{
			$this->responseHTTP['message'] = 'El registro que intenta'.
			 											  'eliminar no existe';
			$this->responseHTTP["appst"] = 2500;
		}

		$this->__responseHttp($this->responseHTTP, 200);
	}

	/**
	 * Se validan las columnas que debe tener la consulta para que no falle
	 * @return [array] | [bolean]
	 */
	private function _validData($data){
		$columnsLen = array(
        'nro_pedido' => 6,
        'concepto' => 1,
        'valor_provisionado' => 1,
        'id_user' => 1,
		);
		return $this->_checkColumnsData($columnsLen, $data);
	}
}
