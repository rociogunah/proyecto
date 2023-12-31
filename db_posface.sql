-- MySQL Script generated by MySQL Workbench
-- Tue Oct  3 00:40:27 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema posface
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `posface` ;

-- -----------------------------------------------------
-- Schema posface
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `posface` DEFAULT CHARACTER SET utf8 ;
USE `posface` ;

-- -----------------------------------------------------
-- Table `posface`.`tbl_estado_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_estado_usuario` (
  `cod_estado_usuario` INT NOT NULL AUTO_INCREMENT,
  `estado_usuario` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_estado_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_rol` (
  `cod_rol` INT NOT NULL AUTO_INCREMENT,
  `rol` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`cod_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_genero` (
  `cod_genero` INT NOT NULL AUTO_INCREMENT,
  `tipo_genero` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_genero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_persona` (
  `cod_persona` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `identidad` VARCHAR(50) NOT NULL,
  `telefono_cel` VARCHAR(50) NOT NULL,
  `telefono_fijo` VARCHAR(50) NOT NULL,
  `correo_personal` VARCHAR(100) NOT NULL,
  `correo_institucional` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_genero` INT NOT NULL,
  `foto_perfil` BLOB NOT NULL,
  `usuario_creado` TINYINT NOT NULL,
  PRIMARY KEY (`cod_persona`),
  CONSTRAINT `fk_tbl_persona_tbl_genero`
    FOREIGN KEY (`fk_cod_genero`)
    REFERENCES `posface`.`tbl_genero` (`cod_genero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_persona_tbl_genero_idx` ON `posface`.`tbl_persona` (`fk_cod_genero` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_usuario` (
  `cod_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(60) NOT NULL,
  `contrasena` VARCHAR(200) NOT NULL,
  `primer_ingreso` VARCHAR(30) NOT NULL,
  `fecha_vencimiento` DATE NOT NULL,
  `correo_electronico` VARCHAR(300) NOT NULL,
  `creado_por` VARCHAR(50) NOT NULL,
  `modificado_por` VARCHAR(200) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `fecha_modificacion` DATE NOT NULL,
  `fk_cod_persona` INT NOT NULL,
  `fk_cod_estado_usuario` INT NOT NULL,
  `fk_cod_rol` INT NOT NULL,
  PRIMARY KEY (`cod_usuario`),
  CONSTRAINT `fk_tbl_usuario_tbl_estado_usuario`
    FOREIGN KEY (`fk_cod_estado_usuario`)
    REFERENCES `posface`.`tbl_estado_usuario` (`cod_estado_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_usuario_tbl_rol`
    FOREIGN KEY (`fk_cod_rol`)
    REFERENCES `posface`.`tbl_rol` (`cod_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_usuario_tbl_persona`
    FOREIGN KEY (`fk_cod_persona`)
    REFERENCES `posface`.`tbl_persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_usuario_tbl_estado_usuario_idx` ON `posface`.`tbl_usuario` (`fk_cod_estado_usuario` ASC) VISIBLE;

CREATE INDEX `fk_tbl_usuario_tbl_rol_idx` ON `posface`.`tbl_usuario` (`fk_cod_rol` ASC) VISIBLE;

CREATE INDEX `fk_tbl_usuario_tbl_persona_idx` ON `posface`.`tbl_usuario` (`fk_cod_persona` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `posface`.`tbl_token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_token` (
  `cod_token` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(20) NOT NULL,
  `fecha_expiracion` DATE NOT NULL,
  `fk_cod_usuario` INT NOT NULL,
  PRIMARY KEY (`cod_token`),
  CONSTRAINT `tbl_token_tbl_usuario`
    FOREIGN KEY (`fk_cod_usuario`)
    REFERENCES `posface`.`tbl_usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `tbl_token_tbl_usuario_idx` ON `posface`.`tbl_token` (`fk_cod_usuario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `posface`.`tbl_historial_contrasena`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_historial_contrasena` (
  `cod_historial_contrasena` INT NOT NULL AUTO_INCREMENT,
  `contrasena` VARCHAR(10) NOT NULL,
  `fk_cod_usuario` INT NOT NULL,
  PRIMARY KEY (`cod_historial_contrasena`),
  CONSTRAINT `fk_tbl_historial_contrasena_tbl_usuario`
    FOREIGN KEY (`fk_cod_usuario`)
    REFERENCES `posface`.`tbl_usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_historial_contrasena_tbl_usuario_idx` ON `posface`.`tbl_historial_contrasena` (`fk_cod_usuario` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_pregunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_pregunta` (
  `cod_pregunta` INT NOT NULL AUTO_INCREMENT,
  `pregunta` VARCHAR(200) NOT NULL,
  `respuesta` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`cod_pregunta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_pregunta_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_pregunta_usuario` (
  `fk_cod_usuario` INT NOT NULL,
  `fk_cod_pregunta` INT NOT NULL,
  CONSTRAINT `fk_tbl_pregunta_usuario_tbl_usuario`
    FOREIGN KEY (`fk_cod_usuario`)
    REFERENCES `posface`.`tbl_usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_pregunta_usuario_tbl_pregunta`
    FOREIGN KEY (`fk_cod_pregunta`)
    REFERENCES `posface`.`tbl_pregunta` (`cod_pregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_pregunta_usuario_tbl_usuario_idx` ON `posface`.`tbl_pregunta_usuario` (`fk_cod_usuario` ASC);

CREATE INDEX `fk_tbl_pregunta_usuario_tbl_pregunta_idx` ON `posface`.`tbl_pregunta_usuario` (`fk_cod_pregunta` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_objeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_objeto` (
  `cod_objeto` INT NOT NULL AUTO_INCREMENT,
  `objeto` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `tipo_objeto` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_objeto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_bitacora` (
  `cod_bitacora` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `accion` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `fk_cod_objeto` INT NOT NULL,
  `fk_cod_usuario` INT NOT NULL,
  PRIMARY KEY (`cod_bitacora`),
  CONSTRAINT `fk_tbl_bitacora_tbl_usuario`
    FOREIGN KEY (`fk_cod_usuario`)
    REFERENCES `posface`.`tbl_usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_bitacora_tbl_objeto`
    FOREIGN KEY (`fk_cod_objeto`)
    REFERENCES `posface`.`tbl_objeto` (`cod_objeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `tbl_bitacora_tbl_usuario_idx` ON `posface`.`tbl_bitacora` (`fk_cod_usuario` ASC) ;

CREATE INDEX `fk_tbl_bitacora_tbl_objeto_idx` ON `posface`.`tbl_bitacora` (`fk_cod_objeto` ASC) ;


-- -----------------------------------------------------
-- Table `posface`.`tbl_error`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_error` (
  `cod_error` INT NOT NULL AUTO_INCREMENT,
  `error` VARCHAR(50) NOT NULL,
  `mensaje` VARCHAR(300) NOT NULL,
  `codigo` INT NOT NULL,
  `fk_cod_bitacora` INT NOT NULL,
  PRIMARY KEY (`cod_error`),
  CONSTRAINT `fk_tbl_error_tbl_bitacora`
    FOREIGN KEY (`fk_cod_bitacora`)
    REFERENCES `posface`.`tbl_bitacora` (`cod_bitacora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_error_tbl_bitacora_idx` ON `posface`.`tbl_error` (`fk_cod_bitacora` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_permiso` (
  `cod_permiso` INT NOT NULL AUTO_INCREMENT,
  `permiso_insercion` TINYINT NOT NULL,
  `permiso_eliminacion` TINYINT NOT NULL,
  `permiso_actualizacion` TINYINT NOT NULL,
  `permiso_consultar` TINYINT NOT NULL,
  `fk_cod_rol` INT NOT NULL,
  `fk_cod_objeto` INT NOT NULL,
  PRIMARY KEY (`cod_permiso`),
  CONSTRAINT `fk_tbl_permiso_tbl_rol`
    FOREIGN KEY (`fk_cod_rol`)
    REFERENCES `posface`.`tbl_rol` (`cod_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_permiso_tbl_objeto`
    FOREIGN KEY (`fk_cod_objeto`)
    REFERENCES `posface`.`tbl_objeto` (`cod_objeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_permiso_tbl_rol_idx` ON `posface`.`tbl_permiso` (`fk_cod_rol` ASC);

CREATE INDEX `fk_tbl_permiso_tbl_objeto_idx` ON `posface`.`tbl_permiso` (`fk_cod_objeto` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_estado_cargo_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_estado_cargo_persona` (
  `cod_estado_persona` INT NOT NULL AUTO_INCREMENT,
  `estado_cargo_persona` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_estado_persona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_carrera` (
  `cod_carrera` INT NOT NULL AUTO_INCREMENT,
  `nombre_carrera` VARCHAR(50) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`cod_carrera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_cargo_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_cargo_persona` (
  `cod_cargo_persona` INT NOT NULL AUTO_INCREMENT,
  `cargo_persona` VARCHAR(100) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_estado_cargo_persona` INT NOT NULL,
  `fk_cod_persona` INT NOT NULL,
  `fk_cod_carrera` INT NOT NULL,
  PRIMARY KEY (`cod_cargo_persona`),
  CONSTRAINT `fk_tbl_cargo_persona_tbl_persona`
    FOREIGN KEY (`fk_cod_persona`)
    REFERENCES `posface`.`tbl_persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_cargo_personsa_tbl_estado_cargo_persona`
    FOREIGN KEY (`fk_cod_estado_cargo_persona`)
    REFERENCES `posface`.`tbl_estado_cargo_persona` (`cod_estado_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_cargo_persona_tbl_carrera`
    FOREIGN KEY (`fk_cod_carrera`)
    REFERENCES `posface`.`tbl_carrera` (`cod_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_cargo_persona_tbl_persona_idx` ON `posface`.`tbl_cargo_persona` (`fk_cod_persona` ASC);

CREATE INDEX `fk_tbl_cargo_personsa_tbl_estado_cargo_persona_idx` ON `posface`.`tbl_cargo_persona` (`fk_cod_estado_cargo_persona` ASC);

CREATE INDEX `fk_tbl_cargo_persona_tbl_carrera_idx` ON `posface`.`tbl_cargo_persona` (`fk_cod_carrera` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_estado_actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_estado_actividad` (
  `cod_estado_actividad` INT NOT NULL AUTO_INCREMENT,
  `estado_actividad` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_estado_actividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_actividad` (
  `cod_actividad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `fecha_hora_inicio` DATE NOT NULL,
  `fecha_hora_limite` DATE NOT NULL,
  `fecha_hora_final` DATE NOT NULL,
  `fecha_recordatorio` DATE NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  `fk_cod_estado_actividad` INT NOT NULL,
  PRIMARY KEY (`cod_actividad`),
  CONSTRAINT `fk_tbl_actividad_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_actividad_tbl_estado_actividad`
    FOREIGN KEY (`fk_cod_estado_actividad`)
    REFERENCES `posface`.`tbl_estado_actividad` (`cod_estado_actividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_actividad_tbl_cargo_persona_idx` ON `posface`.`tbl_actividad` (`fk_cod_cargo_persona` ASC);

CREATE INDEX `fk_tbl_actividad_tbl_estado_actividad_idx` ON `posface`.`tbl_actividad` (`fk_cod_estado_actividad` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_tipo_profesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_tipo_profesion` (
  `cod_tipo_profesion` INT NOT NULL AUTO_INCREMENT,
  `tipo_profesion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_tipo_profesion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_profesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_profesion` (
  `cod_profesion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_tipo_profesion` INT NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  PRIMARY KEY (`cod_profesion`),
  CONSTRAINT `fk_tbl_profesion_tbl_tipo_profesion`
    FOREIGN KEY (`fk_cod_tipo_profesion`)
    REFERENCES `posface`.`tbl_tipo_profesion` (`cod_tipo_profesion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_profesion_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_profesion_tbl_tipo_profesion_idx` ON `posface`.`tbl_profesion` (`fk_cod_tipo_profesion` ASC);

CREATE INDEX `fk_tbl_profesion_tbl_cargo_persona_idx` ON `posface`.`tbl_profesion` (`fk_cod_cargo_persona` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_tipo_experiencia_docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_tipo_experiencia_docente` (
  `cod_tipo_experiencia_docente` INT NOT NULL AUTO_INCREMENT,
  `tipo_experiencia` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_tipo_experiencia_docente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_experiencia_docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_experiencia_docente` (
  `cod_experiencia_docente` INT NOT NULL AUTO_INCREMENT,
  `empresa` VARCHAR(50) NOT NULL,
  `anios_experiencia` INT NOT NULL,
  `fecha_inicial` DATE NOT NULL,
  `fecha_final` DATE NOT NULL,
  `funcion_cargo` VARCHAR(50) NOT NULL,
  `fecha_evaluacion` DATE NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_tipo_experiencia_docente` INT NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  PRIMARY KEY (`cod_experiencia_docente`),
  CONSTRAINT `fk_tbl_experiencia_docente_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_experiencia_docente_tbl_tipo_experiencia_docente`
    FOREIGN KEY (`fk_cod_tipo_experiencia_docente`)
    REFERENCES `posface`.`tbl_tipo_experiencia_docente` (`cod_tipo_experiencia_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_experiencia_docente_tbl_cargo_persona_idx` ON `posface`.`tbl_experiencia_docente` (`fk_cod_cargo_persona` ASC);

CREATE INDEX `fk_tbl_experiencia_docente_tbl_tipo_experiencia_docente_idx` ON `posface`.`tbl_experiencia_docente` (`fk_cod_tipo_experiencia_docente` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_horas_voae`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_horas_voae` (
  `cod_horas_voae` INT NOT NULL AUTO_INCREMENT,
  `ambito` VARCHAR(50) NOT NULL,
  `cantidad_horas` INT NOT NULL,
  `fecha_inicial_entrega` DATE NOT NULL,
  `fecha_final_entrega` DATE NOT NULL,
  `constancia` BLOB(100) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  PRIMARY KEY (`cod_horas_voae`),
  CONSTRAINT `fk_tbl_horas_voae_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_horas_voae_tbl_cargo_persona_idx` ON `posface`.`tbl_horas_voae` (`fk_cod_cargo_persona` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_cargo_miembro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_cargo_miembro` (
  `cod_cargo_miembro_tesis` INT NOT NULL AUTO_INCREMENT,
  `tipo_miembro` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_cargo_miembro_tesis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_modalidad_defensa_tesis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_modalidad_defensa_tesis` (
  `cod_modalidad_defensa_tesis` INT NOT NULL AUTO_INCREMENT,
  `tipo_modalidad` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_modalidad_defensa_tesis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_mencion_honorifica_tesis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_mencion_honorifica_tesis` (
  `cod_mencion_honorifica_tesis` INT NOT NULL AUTO_INCREMENT,
  `observacion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`cod_mencion_honorifica_tesis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_estado_tesis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_estado_tesis` (
  `cod_estado_tesis` INT NOT NULL AUTO_INCREMENT,
  `estado_tesis` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_estado_tesis`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_tesis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_tesis` (
  `cod_tesis` INT NOT NULL AUTO_INCREMENT,
  `tema_tesis` VARCHAR(100) NOT NULL,
  `autor` DATE NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_final` DATE NOT NULL,
  `ubicacion` VARCHAR(100) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  `fk_cod_estado_tesis` INT NOT NULL,
  PRIMARY KEY (`cod_tesis`),
  CONSTRAINT `fk_tbl_tesis_tbl_estado_tesis`
    FOREIGN KEY (`fk_cod_estado_tesis`)
    REFERENCES `posface`.`tbl_estado_tesis` (`cod_estado_tesis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_tesis_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_tesis_tbl_estado_tesis_idx` ON `posface`.`tbl_tesis` (`fk_cod_estado_tesis` ASC);

CREATE INDEX `fk_tbl_tesis_tbl_cargo_persona_idx` ON `posface`.`tbl_tesis` (`fk_cod_cargo_persona` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_defensa_tesis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_defensa_tesis` (
  `cod_defensa_tesis` INT NOT NULL AUTO_INCREMENT,
  `fecha_asignacion` DATE NOT NULL,
  `evaluacion_defensa_tesis` INT NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_tesis` INT NOT NULL,
  `fk_cod_mencion_honorifica_tesis` INT NOT NULL,
  `fk_cod_modalidad_defensa_tesis` INT NOT NULL,
  PRIMARY KEY (`cod_defensa_tesis`),
  CONSTRAINT `fk_tbl_defensa_tesis_tbl_modalidad_defensa_tesis`
    FOREIGN KEY (`fk_cod_modalidad_defensa_tesis`)
    REFERENCES `posface`.`tbl_modalidad_defensa_tesis` (`cod_modalidad_defensa_tesis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_defensa_tesis_tbl_mencion_honorifica_tesis`
    FOREIGN KEY (`fk_cod_mencion_honorifica_tesis`)
    REFERENCES `posface`.`tbl_mencion_honorifica_tesis` (`cod_mencion_honorifica_tesis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_defensa_tesis_tbl_tesis`
    FOREIGN KEY (`fk_cod_tesis`)
    REFERENCES `posface`.`tbl_tesis` (`cod_tesis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_defensa_tesis_tbl_modalidad_defensa_tesis_idx` ON `posface`.`tbl_defensa_tesis` (`fk_cod_modalidad_defensa_tesis` ASC);

CREATE INDEX `fk_tbl_defensa_tesis_tbl_mencion_honorifica_tesis_idx` ON `posface`.`tbl_defensa_tesis` (`fk_cod_mencion_honorifica_tesis` ASC);

CREATE INDEX `fk_tbl_defensa_tesis_tbl_tesis_idx` ON `posface`.`tbl_defensa_tesis` (`fk_cod_tesis` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_miembro_defensa_tesis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_miembro_defensa_tesis` (
  `cod_miembro_tesis` INT NOT NULL AUTO_INCREMENT,
  `fk_cod_cargo_persona` INT NOT NULL,
  `fk_cod_cargo_miembro_tesis` INT NOT NULL,
  `fk_cod_defensa_tesis` INT NOT NULL,
  PRIMARY KEY (`cod_miembro_tesis`),
  CONSTRAINT `fk_tbl_miembro_defensa_tesis`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_miembro_defensa_tesis_tbl_cargo_miembro`
    FOREIGN KEY (`fk_cod_cargo_miembro_tesis`)
    REFERENCES `posface`.`tbl_cargo_miembro` (`cod_cargo_miembro_tesis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_miembro_defensa_tesis_tbl_defensa_tesis`
    FOREIGN KEY (`fk_cod_defensa_tesis`)
    REFERENCES `posface`.`tbl_defensa_tesis` (`cod_defensa_tesis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_miembro_defensa_tesis_idx` ON `posface`.`tbl_miembro_defensa_tesis` (`fk_cod_cargo_persona` ASC);

CREATE INDEX `fk_tbl_miembro_defensa_tesis_tbl_cargo_miembro_idx` ON `posface`.`tbl_miembro_defensa_tesis` (`fk_cod_cargo_miembro_tesis` ASC);

CREATE INDEX `fk_tbl_miembro_defensa_tesis_tbl_defensa_tesis_idx` ON `posface`.`tbl_miembro_defensa_tesis` (`fk_cod_defensa_tesis` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_tipo_documentacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_tipo_documentacion` (
  `cod_tipo_documentacion` INT NOT NULL AUTO_INCREMENT,
  `archivo_ubicacion` VARCHAR(60) NOT NULL,
  `tipo_documento` BLOB(100) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_tesis` INT NOT NULL,
  PRIMARY KEY (`cod_tipo_documentacion`),
  CONSTRAINT `fk_tbl_tipo_documentacion_tbl_tesis`
    FOREIGN KEY (`fk_cod_tesis`)
    REFERENCES `posface`.`tbl_tesis` (`cod_tesis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_tipo_documentacion_tbl_tesis_idx` ON `posface`.`tbl_tipo_documentacion` (`fk_cod_tesis` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_tipo_evaluacion_docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_tipo_evaluacion_docente` (
  `cod_tipo_evaluacion_docente` INT NOT NULL AUTO_INCREMENT,
  `tipo_evaluacion_docente` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_tipo_evaluacion_docente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_periodo` (
  `cod_periodo` INT NOT NULL AUTO_INCREMENT,
  `nombre_periodo` VARCHAR(50) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `anio` INT NOT NULL,
  PRIMARY KEY (`cod_periodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_evaluacion_docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_evaluacion_docente` (
  `cod_evaluacion_docente` INT NOT NULL AUTO_INCREMENT,
  `evaluacion` INT NOT NULL,
  `fecha_evaluacion_docente` DATE NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_periodo` INT NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  `fk_cod_tipo_evaluacion_docente` INT NOT NULL,
  PRIMARY KEY (`cod_evaluacion_docente`),
  CONSTRAINT `fk_tbl_evaluacion_docente_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_evaluacion_docente_tbl_tipo_evaluacion_docente`
    FOREIGN KEY (`fk_cod_tipo_evaluacion_docente`)
    REFERENCES `posface`.`tbl_tipo_evaluacion_docente` (`cod_tipo_evaluacion_docente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_evaluacion_docente_tbl_periodo`
    FOREIGN KEY (`fk_cod_periodo`)
    REFERENCES `posface`.`tbl_periodo` (`cod_periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_evaluacion_docente_tbl_cargo_persona_idx` ON `posface`.`tbl_evaluacion_docente` (`fk_cod_cargo_persona` ASC);

CREATE INDEX `fk_tbl_evaluacion_docente_tbl_tipo_evaluacion_docente_idx` ON `posface`.`tbl_evaluacion_docente` (`fk_cod_tipo_evaluacion_docente` ASC);

CREATE INDEX `fk_tbl_evaluacion_docente_tbl_periodo_idx` ON `posface`.`tbl_evaluacion_docente` (`fk_cod_periodo` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_estado_promocion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_estado_promocion` (
  `cod_estado_promocion` INT NOT NULL AUTO_INCREMENT,
  `estado_promocion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_estado_promocion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_promocion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_promocion` (
  `n_promocion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NOT NULL,
  `fecha` DATE NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  `fk_cod_estado_promocion` INT NOT NULL,
  PRIMARY KEY (`n_promocion`),
  CONSTRAINT `fk_tbl_promocion_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_promocion_tbl_estado_promocion`
    FOREIGN KEY (`fk_cod_estado_promocion`)
    REFERENCES `posface`.`tbl_estado_promocion` (`cod_estado_promocion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_promocion_tbl_cargo_persona_idx` ON `posface`.`tbl_promocion` (`fk_cod_cargo_persona` ASC);

CREATE INDEX `fk_tbl_promocion_tbl_estado_promocion_idx` ON `posface`.`tbl_promocion` (`fk_cod_estado_promocion` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_eficiencia_terminal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_eficiencia_terminal` (
  `cod_eficiencia_terminal` INT NOT NULL AUTO_INCREMENT,
  `porcentaje_eficiencia` DECIMAL(100) NOT NULL,
  `fecha` DATE NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  PRIMARY KEY (`cod_eficiencia_terminal`),
  CONSTRAINT `fk_tbl_eficiencia_terminal_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_eficiencia_terminal_tbl_cargo_persona_idx` ON `posface`.`tbl_eficiencia_terminal` (`fk_cod_cargo_persona` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_mencion_honorifica_clase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_mencion_honorifica_clase` (
  `cod_mencion_honorifica_clase` INT NOT NULL AUTO_INCREMENT,
  `rango` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`cod_mencion_honorifica_clase`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_graduacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_graduacion` (
  `cod_acta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `fk_n_promocion` INT NOT NULL,
  `fk_cod_mencion_honorifica_clase` INT NOT NULL,
  PRIMARY KEY (`cod_acta`),
  CONSTRAINT `fk_tbl_graduacion_tbl_promocion`
    FOREIGN KEY (`fk_n_promocion`)
    REFERENCES `posface`.`tbl_promocion` (`n_promocion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_graduacion_tmbl_mencion_honorifica_clase`
    FOREIGN KEY (`fk_cod_mencion_honorifica_clase`)
    REFERENCES `posface`.`tbl_mencion_honorifica_clase` (`cod_mencion_honorifica_clase`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_promocion_tbl_promocion_idx` ON `posface`.`tbl_graduacion` (`fk_n_promocion` ASC);

CREATE INDEX `fk_tbl_graduacion_tmbl_mencion_honorifica_clase_idx` ON `posface`.`tbl_graduacion` (`fk_cod_mencion_honorifica_clase` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_modalidad_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_modalidad_asignatura` (
  `cod_modalidad_asignatura` INT NOT NULL AUTO_INCREMENT,
  `tipo_modalidad` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_modalidad_asignatura`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_asignatura` (
  `cod_asignatura` INT NOT NULL AUTO_INCREMENT,
  `nombre_asignatura` VARCHAR(60) NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_modalidad_asignatura` INT NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  PRIMARY KEY (`cod_asignatura`),
  CONSTRAINT `fk_tbl_asignatura_tbl_modalidad_asignatura`
    FOREIGN KEY (`fk_cod_modalidad_asignatura`)
    REFERENCES `posface`.`tbl_modalidad_asignatura` (`cod_modalidad_asignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_asignatura_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_asignatura_tbl_modalidad_asignatura_idx` ON `posface`.`tbl_asignatura` (`fk_cod_modalidad_asignatura` ASC);

CREATE INDEX `fk_tbl_asignatura_tbl_cargo_persona_idx` ON `posface`.`tbl_asignatura` (`fk_cod_cargo_persona` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_edificio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_edificio` (
  `cod_edificio` INT NOT NULL AUTO_INCREMENT,
  `nombre_edificio` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cod_edificio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_aula` (
  `cod_aula` INT NOT NULL AUTO_INCREMENT,
  `capacidad` INT NOT NULL,
  `fk_cod_edificio` INT NOT NULL,
  PRIMARY KEY (`cod_aula`),
  CONSTRAINT `fk_tbl_aula_tbl_edificio`
    FOREIGN KEY (`fk_cod_edificio`)
    REFERENCES `posface`.`tbl_edificio` (`cod_edificio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tbl_aula_tbl_edificio_idx` ON `posface`.`tbl_aula` (`fk_cod_edificio` ASC);


-- -----------------------------------------------------
-- Table `posface`.`tbl_detalle_matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_detalle_matricula` (
  `cod_detalle_matricula` INT NOT NULL AUTO_INCREMENT,
  `evaluacion_estudiante` INT NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`cod_detalle_matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `posface`.`tbl_matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `posface`.`tbl_matricula` (
  `cod_matricula` INT NOT NULL AUTO_INCREMENT,
  `anio` INT NOT NULL,
  `horario_inicio` TIME NOT NULL,
  `horario_final` TIME NOT NULL,
  `dia_clase` VARCHAR(10) NOT NULL,
  `seccion` INT NOT NULL,
  `observacion` VARCHAR(300) NOT NULL,
  `fk_cod_asignatura` INT NOT NULL,
  `fk_cod_periodo` INT NOT NULL,
  `fk_cod_cargo_persona` INT NOT NULL,
  `fk_cod_aula` INT NOT NULL,
  `fk_cod_detalle_matricula` INT NOT NULL,
  PRIMARY KEY (`cod_matricula`),
  CONSTRAINT `fk_tbl_matricula_tbl_cargo_persona`
    FOREIGN KEY (`fk_cod_cargo_persona`)
    REFERENCES `posface`.`tbl_cargo_persona` (`cod_cargo_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_matricula_tbl_aula`
    FOREIGN KEY (`fk_cod_aula`)
    REFERENCES `posface`.`tbl_aula` (`cod_aula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_matricula_tbl_detalle_matricula`
    FOREIGN KEY (`fk_cod_detalle_matricula`)
    REFERENCES `posface`.`tbl_detalle_matricula` (`cod_detalle_matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_matricula_tbl_periodo`
    FOREIGN KEY (`fk_cod_periodo`)
    REFERENCES `posface`.`tbl_periodo` (`cod_periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_matricula_tbl_asignatura`
    FOREIGN KEY (`fk_cod_asignatura`)
    REFERENCES `posface`.`tbl_asignatura` (`cod_asignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


