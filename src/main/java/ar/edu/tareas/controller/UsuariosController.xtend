package ar.edu.tareas.controller

import ar.edu.tareas.repos.RepoUsuarios
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
class UsuariosController {

	extension JSONUtils = new JSONUtils
		
	@Get("/usuarios")
	def Result usuarios() {
		ok(RepoUsuarios.instance.allInstances.toJson)
	}
	
}