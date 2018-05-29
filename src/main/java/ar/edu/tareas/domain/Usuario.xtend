package ar.edu.tareas.domain

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity

@JsonIgnoreProperties(ignoreUnknown = true)
@Accessors
class Usuario extends Entity {
	
	String nombre

	new() {}	
	
	new(String nombre) {
		this.nombre = nombre
	}
	
}