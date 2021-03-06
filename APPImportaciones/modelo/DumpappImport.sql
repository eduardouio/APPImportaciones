-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: appImport
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.17.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ci_sessions`
--

DROP TABLE IF EXISTS `ci_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `detalle_pedido_factura`
--

DROP TABLE IF EXISTS `detalle_pedido_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_pedido_factura` (
  `detalle_pedido_factura` mediumint(9) NOT NULL AUTO_INCREMENT,
  `id_pedido_factura` mediumint(9) NOT NULL,
  `cod_contable` char(20) NOT NULL COMMENT 'REFERENCIA A PRODUCTOS',
  `nro_cajas` smallint(6) NOT NULL COMMENT 'CAJAS QUE CONFORMAN EL PEDIDO, DE UN SOLO PRODUCTO',
  `costo_und` decimal(6,3) NOT NULL COMMENT 'COSTO POR BOTELLA DE PRODUCTO',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`id_pedido_factura`,`cod_contable`),
  UNIQUE KEY `detalle_pedido_factura` (`detalle_pedido_factura`),
  KEY `FK_DETALLE_PEDIDO_FACTURA_PRODUCTO` (`cod_contable`),
  CONSTRAINT `FK_DETALLE_PEDIDO_FACTURA_PEDIDO_FACTURA` FOREIGN KEY (`id_pedido_factura`) REFERENCES `pedido_factura` (`id_pedido_factura`) ON UPDATE CASCADE,
  CONSTRAINT `FK_DETALLE_PEDIDO_FACTURA_PRODUCTO` FOREIGN KEY (`cod_contable`) REFERENCES `producto` (`cod_contable`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Deatalle de los productos que trae un pedido, se registran los detalles de las facturas de compra de producto';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura_gastos_nacionalizacion`
--

DROP TABLE IF EXISTS `factura_gastos_nacionalizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_gastos_nacionalizacion` (
  `id_factura_gastos_nacionalizacion` smallint(6) NOT NULL AUTO_INCREMENT,
  `id_gastos_nacionalizacion` mediumint(9) NOT NULL,
  `id_factura_pagos` smallint(6) NOT NULL,
  `valor` decimal(6,3) NOT NULL DEFAULT '0.000',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL,
  PRIMARY KEY (`id_gastos_nacionalizacion`,`id_factura_pagos`),
  UNIQUE KEY `id_factura_pagos_pedido_gasto_nacionalizacion` (`id_factura_gastos_nacionalizacion`),
  CONSTRAINT `fk_factura_pagos_pedido_gasto_nacionalizacion_1` FOREIGN KEY (`id_gastos_nacionalizacion`) REFERENCES `gastos_nacionalizacion` (`id_gastos_nacionalizacion`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura_informativa`
--

DROP TABLE IF EXISTS `factura_informativa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_informativa` (
  `id_factura_informativa` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nro_factura_informativa` char(8) NOT NULL COMMENT '00000000  EL NUMERO DE LA FACTURA PUEDE TENER HASTA 8 DIGITOS',
  `nro_pedido` char(6) NOT NULL COMMENT '000/00 FORMATO NRO DE PEDIDO Y DOS DIGITO ANIO',
  `identificacion_proveedor` varchar(16) NOT NULL COMMENT 'IDENTIFICADOR DE PROVEEDOR ENTREGADO POR VINESA PARA MENORES PONER CEROS ANTES',
  `fele_aduana` decimal(6,3) NOT NULL COMMENT 'ES CALCULADA POR FORMULA',
  `seguro_aduana` decimal(6,3) NOT NULL COMMENT 'ES CALCULADA POR FORMULA',
  `moneda` varchar(45) NOT NULL COMMENT 'MONEDA CON LA QUE SE HIZO LA COMPRA, EL TIPO DE CAMBIO SOLO AFECTA AL CALCULO DE LOS IMPUESTOS, EL TIPO DE CAMBIO INICIAL ES EL FOB A LIQUIDAR',
  `tipo_cambio` decimal(4,3) NOT NULL DEFAULT '1.000' COMMENT 'TIPO DE CAMBIO DE LA MONEDA EN LA EMISION DE LA FACTURA INFORMATIVA',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`nro_factura_informativa`,`nro_pedido`),
  UNIQUE KEY `id_factura_informativa` (`id_factura_informativa`),
  KEY `FK_FACTURA_INFORMATIVA_PEDIDO` (`nro_pedido`),
  KEY `FK_FACTURA_INFORMATIVA_PROVEEDOR` (`identificacion_proveedor`),
  CONSTRAINT `FK_FACTURA_INFORMATIVA_PEDIDO` FOREIGN KEY (`nro_pedido`) REFERENCES `pedido` (`nro_pedido`) ON UPDATE CASCADE,
  CONSTRAINT `FK_FACTURA_INFORMATIVA_PROVEEDOR` FOREIGN KEY (`identificacion_proveedor`) REFERENCES `proveedor` (`identificacion_proveedor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Se registran los valores de los productos que se va a nacionalizar, aqui se registra\r\nla factura informativa de la bodega publica';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura_informativa_detalle`
--

DROP TABLE IF EXISTS `factura_informativa_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_informativa_detalle` (
  `id_factura_informativa_detalle` mediumint(9) NOT NULL AUTO_INCREMENT,
  `id_factura_informativa` mediumint(9) NOT NULL,
  `cod_contable` char(20) NOT NULL COMMENT 'REFERENCIA A PRODUCTOS',
  `nro_cajas` smallint(6) NOT NULL COMMENT 'CANTIDAD DE CAJAS A DESADUANIZAR DE UN PRODUCTO',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`id_factura_informativa`,`cod_contable`),
  UNIQUE KEY `factura_informativa_detalle` (`id_factura_informativa_detalle`),
  KEY `FK_FAC_INFO_DETALLE_PRODUCTO` (`cod_contable`),
  CONSTRAINT `FK_FACTURA_INFO_DETALLE_FAC_INFORMATIVA` FOREIGN KEY (`id_factura_informativa`) REFERENCES `factura_informativa` (`id_factura_informativa`) ON UPDATE CASCADE,
  CONSTRAINT `FK_FAC_INFO_DETALLE_PRODUCTO` FOREIGN KEY (`cod_contable`) REFERENCES `producto` (`cod_contable`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Se registran los valores de los productos que se va a nacionalizar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura_pagos`
--

DROP TABLE IF EXISTS `factura_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_pagos` (
  `id_factura_pagos` smallint(6) NOT NULL AUTO_INCREMENT,
  `identificacion_proveedor` varchar(16) NOT NULL,
  `nro_factura` char(10) NOT NULL,
  `fecha_emision` date NOT NULL,
  `valor` decimal(6,3) NOT NULL,
  `saldo` decimal(6,0) NOT NULL,
  `comentarios` varchar(250) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL,
  PRIMARY KEY (`identificacion_proveedor`,`nro_factura`),
  UNIQUE KEY `id_factura_pagos` (`id_factura_pagos`),
  CONSTRAINT `FK_FACTURA_PAGOS_PROVEEDOR` FOREIGN KEY (`identificacion_proveedor`) REFERENCES `proveedor` (`identificacion_proveedor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura_pagos_pedido`
--

DROP TABLE IF EXISTS `factura_pagos_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_pagos_pedido` (
  `id_factura_pagos_pedido` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nro_pedido` char(6) NOT NULL,
  `id_factura_pagos` smallint(6) NOT NULL,
  `valor` decimal(6,3) NOT NULL,
  `concepto` varchar(50) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL,
  PRIMARY KEY (`nro_pedido`,`id_factura_pagos`,`concepto`),
  UNIQUE KEY `id_factura_pagos_pedido_UNIQUE` (`id_factura_pagos_pedido`),
  KEY `fk_factura_pagos_pedido_1_idx` (`id_factura_pagos`),
  CONSTRAINT `FK_FACTURA_PAGOS_PEDIDO_FACTUpAGOS` FOREIGN KEY (`id_factura_pagos`) REFERENCES `factura_pagos` (`id_factura_pagos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_FACT_PAGOS_PEDIDO_PEDIDO` FOREIGN KEY (`nro_pedido`) REFERENCES `pedido` (`nro_pedido`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura_pagos_pedido_gasto_inicial_r70`
--

DROP TABLE IF EXISTS `factura_pagos_pedido_gasto_inicial_r70`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura_pagos_pedido_gasto_inicial_r70` (
  `id_factura_pagos_pedido_gasto_inicial` smallint(6) NOT NULL AUTO_INCREMENT,
  `id_gastos_iniciales` mediumint(9) NOT NULL,
  `id_factura_pagos` smallint(6) NOT NULL,
  `valor` decimal(6,3) NOT NULL DEFAULT '0.000',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL,
  PRIMARY KEY (`id_gastos_iniciales`,`id_factura_pagos`),
  UNIQUE KEY `id_factura_pagos_pedido_gasto_inicial` (`id_factura_pagos_pedido_gasto_inicial`),
  CONSTRAINT `FK_PAGOS_PEDIDO_FACTURAG_INI_GASTOS_R70` FOREIGN KEY (`id_gastos_iniciales`) REFERENCES `gastos_iniciales_r70` (`id_gastos_iniciales`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT "";
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gastos_iniciales_r70`
--

DROP TABLE IF EXISTS `gastos_iniciales_r70`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gastos_iniciales_r70` (
  `id_gastos_iniciales` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nro_pedido` char(6) NOT NULL,
  `concepto` varchar(45) NOT NULL,
  `valor_provisionado` decimal(6,3) NOT NULL,
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`nro_pedido`,`concepto`),
  UNIQUE KEY `id_gastos_iniciales` (`id_gastos_iniciales`),
  KEY `FK_GASTOS_INICIALES_PEDIDO` (`nro_pedido`),
  CONSTRAINT `FK_GASTOS_INICIALES_PEDIDO` FOREIGN KEY (`nro_pedido`) REFERENCES `pedido` (`nro_pedido`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='LISTADO DE FACTURAS RECIBIDAS POR SERVICIOS DE IMPORTACION TANTO LOS GASTOS INICIALES COMO LOS \r\nPARCIALES';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gastos_nacionalizacion`
--

DROP TABLE IF EXISTS `gastos_nacionalizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gastos_nacionalizacion` (
  `id_gastos_nacionalizacion` mediumint(9) NOT NULL AUTO_INCREMENT,
  `id_nacionalizacion` smallint(6) NOT NULL,
  `concepto` varchar(45) NOT NULL,
  `valor_provisionado` decimal(6,3) NOT NULL,
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`id_nacionalizacion`,`concepto`),
  UNIQUE KEY `id_gastos_nacionalizacion` (`id_gastos_nacionalizacion`),
  KEY `FK_GASTOS_NACIONALIZACION_NACIONNALIZACION` (`id_nacionalizacion`),
  CONSTRAINT `FK_GASTOS_NACIONALIZACION_NACIONALIZACION` FOREIGN KEY (`id_nacionalizacion`) REFERENCES `nacionalizacion` (`id_nacionalizacion`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='LISTADO DE FACTURAS RECIBIDAS POR SERVICIOS DE IMPORTACION TANTO LOS GASTOS INICIALES COMO LOS \r\nPARCIALES';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `impuestos_nacionalizacion`
--

DROP TABLE IF EXISTS `impuestos_nacionalizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impuestos_nacionalizacion` (
  `id_impuestos` smallint(6) NOT NULL AUTO_INCREMENT,
  `id_nacionalizacion` smallint(6) NOT NULL,
  `concepto` varchar(45) NOT NULL,
  `valor_provisionado` decimal(9,3) NOT NULL,
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`id_nacionalizacion`,`concepto`),
  UNIQUE KEY `id_impuestos` (`id_impuestos`),
  CONSTRAINT `FK_IMPUESTOS_NACIONALIZACION` FOREIGN KEY (`id_nacionalizacion`) REFERENCES `nacionalizacion` (`id_nacionalizacion`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Se registran todos los impuestos que existen en una nacionalizacion, solo impuestos de la SENAE';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incoterm_provicion_internacional`
--

DROP TABLE IF EXISTS `incoterm_provicion_internacional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incoterm_provicion_internacional` (
  `id_incoterm` mediumint(9) NOT NULL AUTO_INCREMENT,
  `tipo` enum('GASTO','FLETE') NOT NULL COMMENT 'TIPO DE TARIFA GASTO SE USA PARA GASTOS EN ORIGEN Y FLETE PARA COSTO DE TRANSPORTE INTERNACIONAL',
  `pais` varchar(45) NOT NULL,
  `incoterms` enum('EXW','FCA','FOB','CFR') NOT NULL COMMENT 'TIPO DE INCOTERM QUE SE APLICA',
  `ciudad` varchar(45) NOT NULL,
  `tarifa` float NOT NULL COMMENT 'COSTO DE LAS TARIFAS EN DOLARES',
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`pais`,`ciudad`,`incoterms`,`tipo`),
  UNIQUE KEY `id_incoterm` (`id_incoterm`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='tabla de tarifas de incoterms negociaciones en el exterior';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liquidacion_impuestos`
--

DROP TABLE IF EXISTS `liquidacion_impuestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquidacion_impuestos` (
  `id_liquidacion_impuestos` smallint(6) NOT NULL AUTO_INCREMENT,
  `id_impuestos` smallint(6) NOT NULL,
  `nro_documento` varchar(18) NOT NULL,
  `valor` decimal(6,3) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL,
  PRIMARY KEY (`id_impuestos`,`nro_documento`),
  UNIQUE KEY `liquidacion_impuestos` (`id_liquidacion_impuestos`),
  CONSTRAINT `FK_LIQUIDACION_IMPUESTOS_IMPUESTOS_NACIO` FOREIGN KEY (`id_impuestos`) REFERENCES `impuestos_nacionalizacion` (`id_impuestos`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nacionalizacion`
--

DROP TABLE IF EXISTS `nacionalizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nacionalizacion` (
  `id_nacionalizacion` smallint(6) NOT NULL AUTO_INCREMENT,
  `nro_pedido` char(6) NOT NULL COMMENT 'REFERENCIA A PEDIDO',
  `nro_factura_informativa` char(8) NOT NULL COMMENT '00000000  02014403 el numero es en un solo formato',
  `moneda` varchar(45) NOT NULL COMMENT 'ESTE CAMPO SOLO SE USA EN EL REGISTRO DE REGIMEN 10 YA QUE EL 70 LO TRAE EN LA FACTURA INFORMATIVA',
  `tipo_cambio` decimal(4,3) NOT NULL DEFAULT '1.000' COMMENT '	ESTE CAMPO SOLO SE USA EN EL REGISTRO DE REGIMEN 10 YA QUE EL 70 LO TRAE EN LA FACTURA INFORMATIVA',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`nro_pedido`,`nro_factura_informativa`),
  UNIQUE KEY `id_nacionalizacion` (`id_nacionalizacion`),
  KEY `FK_NACIONALIZACION_FACTURA_INFORMATIVA` (`nro_factura_informativa`),
  CONSTRAINT `FK_NACIONALIZACION_FACTURA_INFORMATIVA` FOREIGN KEY (`nro_factura_informativa`) REFERENCES `factura_informativa` (`nro_factura_informativa`) ON UPDATE CASCADE,
  CONSTRAINT `FK_NACIONALIZACION_PEDIDO` FOREIGN KEY (`nro_pedido`) REFERENCES `pedido` (`nro_pedido`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='detalle de las facturas o pedidos a nacionalizar, se crea un registro en cero en cada \r\ntabla padre para que hacer el cruce cuando se haga un regimen 10 o 70 ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `id_pedido` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nro_pedido` char(6) NOT NULL COMMENT '000/00 FORMATO NRO DE PEDIDO Y DOS DIGITO ANIO',
  `regimen` enum('70','10') NOT NULL COMMENT 'REGIMENES DE IMPORTACION R10 NO TIENEN GASTOS INICIALES R70 SI LOS TIENE SOL LOS GASTOS GENERADOS DE PASAR LA MERCADERIA DEL PUERTO A LA AMACENERA TEMPORAL "ALMAGRO"',
  `id_incoterm` mediumint(9) NOT NULL,
  `flete_aduana` decimal(6,3) NOT NULL DEFAULT '0.000' COMMENT 'VALOR CALCULADO POR FORMULA DEBE PODERSE EDITAR',
  `seguro_aduana` decimal(6,3) NOT NULL DEFAULT '0.000' COMMENT 'VALOR CALCULADO POR FORMULA DEBE PODERSE EDITAR',
  `estado_pedido` enum('ABIERTO','CERRADO') DEFAULT 'ABIERTO' COMMENT 'INDICA DI EL PEDIDO ESTA CERRADO O NO',
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`nro_pedido`),
  UNIQUE KEY `id_pedido` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Tabla que registra un pedido usando las tablas de \nfactura\nproveedor\ntarifa\nincoterms\nproducto\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedido_factura`
--

DROP TABLE IF EXISTS `pedido_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_factura` (
  `id_pedido_factura` mediumint(9) NOT NULL AUTO_INCREMENT,
  `nro_pedido` char(6) NOT NULL,
  `id_factura_proveedor` char(8) NOT NULL COMMENT 'REFERENCIA A PROVEEDOR',
  `identificacion_proveedor` varchar(16) NOT NULL COMMENT 'IDENTIFICADOR DE PROVEEDOR ENTREGADO POR VINESA PARA MENORES PONER CEROS ANTES',
  `fecha_emision` date NOT NULL COMMENT 'FECHA DE EMISION DE LA FACTURA DE PROVEEDOR',
  `valor` decimal(6,3) DEFAULT '0.000' COMMENT 'NO SE INGRESA SE LO VERIFICA SUMANDO DETALLE FACTURA',
  `moneda` varchar(45) NOT NULL COMMENT 'MONEDA CON LA QUE SE HIZO LA COMPRA, EL TIPO DE CAMBIO SE CONJELA HASTA LIQUIDAR EL FOB',
  `tipo_cambio` decimal(4,3) NOT NULL DEFAULT '1.000' COMMENT 'EL TIPO DE CAMBIO SE CONGELA HASTA LIQUIDAR EL FOB EN DOLARES',
  `vencimiento_pago` date DEFAULT NULL COMMENT 'PLAZO PARA EL PAGO DE LA FACTURA AL PRIVEEDOR INTERNAICONAL',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`identificacion_proveedor`,`id_factura_proveedor`),
  UNIQUE KEY `id_pedido_factura` (`id_pedido_factura`),
  KEY `FK_PEDIDO_FACTURA_PEDIDO` (`nro_pedido`),
  CONSTRAINT `FK_PEDIDO_FACTURA_PEDIDO` FOREIGN KEY (`nro_pedido`) REFERENCES `pedido` (`nro_pedido`) ON UPDATE CASCADE,
  CONSTRAINT `FK_PEDIDO_FACTURA_PROVEEDOR` FOREIGN KEY (`identificacion_proveedor`) REFERENCES `proveedor` (`identificacion_proveedor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='listado de facturas de producto que se importa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `id_producto` mediumint(9) NOT NULL AUTO_INCREMENT,
  `cod_contable` char(20) NOT NULL COMMENT 'CODIDO CONTABLEENTREGADO POR SAP 00000000000000000000 20 DIGITOS SOLO NUMEROS',
  `identificacion_proveedor` varchar(16) NOT NULL COMMENT 'IDENTIFICADOR DE PROVEEDOR ENTREGADO POR VINESA PARA MENORES PONER CEROS ANTES',
  `cod_ice` char(39) NOT NULL COMMENT 'ejemplo 3031-53-001982-013-000750-66-101-000029',
  `nombre` varchar(70) NOT NULL,
  `capacidad_ml` smallint(6) NOT NULL COMMENT 'CONTENIDO EN ML DE CADA UNIDAD',
  `cantidad_x_caja` smallint(6) NOT NULL COMMENT 'ES EL NUMERO DE UNIDADES QUE TRAE LA CAJA',
  `grado_alcoholico` float NOT NULL,
  `costo_unidad` decimal(6,3) NOT NULL DEFAULT '0.000' COMMENT 'COSTO DEL PRODUCTO, PARA QUE SIRVA DE REFERENCIA EN LAS TABLAS DE PEDIDOS DERTALLES',
  `estado` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'EL ESTADO INDICA SI SE IMPORTA O NO EL PRODUCTO 1 = SI 0 = NO ',
  `custodia_doble` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'si se importa o ya se ha dejado de importar\n',
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`cod_contable`),
  UNIQUE KEY `id_producto` (`id_producto`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_PRODUCTO_PROVEEDOR` (`identificacion_proveedor`),
  CONSTRAINT `FK_PRODUCTO_PROVEEDOR` FOREIGN KEY (`identificacion_proveedor`) REFERENCES `proveedor` (`identificacion_proveedor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='listado de productos que  se compran en los pedidos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `tipo_provedor` enum('NACIONAL','INTERNACIONAL') NOT NULL COMMENT 'SE REFIERE A NACIONAL O INTERNACIONAL',
  `categoria` varchar(60) NOT NULL,
  `identificacion_proveedor` varchar(16) NOT NULL COMMENT 'ES UNA IDENTIFICADOR INTERNACIONALES',
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`identificacion_proveedor`),
  UNIQUE KEY `id_proveedor` (`id_proveedor`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Listado de los proveedores, nacionales e internacionales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seguimiento`
--

DROP TABLE IF EXISTS `seguimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seguimiento` (
  `id_seguimiento` mediumint(9) NOT NULL AUTO_INCREMENT,
  `tabla` varchar(45) NOT NULL,
  `accion` enum('UPDATE','DELETE') NOT NULL DEFAULT 'UPDATE' COMMENT 'INDICA CUANDO SE REALIZA EL REGISTRO SI AL BORRAR O EDITAR UN REGISTR',
  `datos` varchar(1000) DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_seguimiento`),
  UNIQUE KEY `id_seguimiento` (`id_seguimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Se registran los cambios en las tablas solo las columnas que cambian';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarifa_provicion_nacional`
--

DROP TABLE IF EXISTS `tarifa_provicion_nacional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarifa_provicion_nacional` (
  `id_tarifa` mediumint(9) NOT NULL AUTO_INCREMENT,
  `identificacion_proveedor` varchar(16) NOT NULL COMMENT 'IDENTIFICADOR DE PROVEEDOR ENTREGADO POR VINESA PARA MENORES PONER CEROS ANTES',
  `regimen` enum('R70','R10','TODOS') NOT NULL,
  `tipo_provicion` enum('GASTO INICIAL','GASTO NACIONALIZACION') NOT NULL COMMENT 'DEFINE A QUE TIPO DE GASTO SE APLICA LA TARIFA DEL GASTO PROVICIONADO',
  `concepto` varchar(45) NOT NULL COMMENT 'flete_internacional, flete_internacional, ECT',
  `valor` decimal(6,3) NOT NULL COMMENT 'VALOR DEL SERVICIO',
  `porcentaje` decimal(3,2) NOT NULL DEFAULT '0.00',
  `comentarios` varchar(250) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  PRIMARY KEY (`identificacion_proveedor`,`concepto`),
  UNIQUE KEY `id_tarifa` (`id_tarifa`),
  CONSTRAINT `FK_TARIFAS_PROVEEDOR` FOREIGN KEY (`identificacion_proveedor`) REFERENCES `proveedor` (`identificacion_proveedor`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Se registran todas las tarifas y costos acordados con los proveedores nacionales';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarifas_impuestos`
--

DROP TABLE IF EXISTS `tarifas_impuestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarifas_impuestos` (
  `id_tarifas_impuestos` smallint(6) NOT NULL AUTO_INCREMENT,
  `concepto` varchar(45) NOT NULL,
  `regimen` enum('R10','R70','TODOS') NOT NULL,
  `porcentaje` decimal(9,3) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  `estado` enum('ACTIVO','INACTIVO') NOT NULL DEFAULT 'ACTIVO',
  `comentarios` varchar(250) DEFAULT NULL,
  `id_user` smallint(6) NOT NULL COMMENT 'NOMBRE APP USER QUE GUARDA EL REGISTRO',
  `valor` decimal(4,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id_tarifas_impuestos`),
  UNIQUE KEY `id_tarifas_impuestos` (`id_tarifas_impuestos`),
  UNIQUE KEY `concepto` (`concepto`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Se registran los porcentajes y los impuestos que existen  o se pagan';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id_user` smallint(6) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `cargo` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(120) NOT NULL,
  `usertype` enum('L1','L2','L3') NOT NULL COMMENT 'L1 Administrador; L2 Ingreso Data; L3 Visualizacion',
  `last_login` datetime DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` datetime DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `id_user` (`id_user`),
  UNIQUE KEY `nombres` (`nombres`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COMMENT='Se registran todos los impuestos que existen en una nacionalizacion, solo impuestos de la SENAE';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-17 11:04:26
