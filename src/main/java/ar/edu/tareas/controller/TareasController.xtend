package ar.edu.tareas.controller

import ar.edu.tareas.domain.Tarea
import ar.edu.tareas.repos.RepoTareas
import ar.edu.tareas.repos.RepoUsuarios
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils

@Controller
class TareasController {

	extension JSONUtils = new JSONUtils

	@Get("/tareas")
	def Result tareas() {
		try {
			if (1 == 1) throw new RuntimeException("Kaboom!")
			val tareas = RepoTareas.instance.allInstances //tareasPendientes
			ok(tareas.toJson)
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}

	@Get('/tareas/:id')
	def Result tarea() {
		val iId = Integer.valueOf(id)
		try {
			ok(RepoTareas.instance.searchById(iId).toJson)
		} catch (UserException e) {
			notFound("No existe la tarea con id " + id + "")
		}
	}

	// Ojo con el parámetro, debe decir exactamente descripcion
	@Get('/tareas/search')
	def Result buscar(String descripcion) {
		val tareaBusqueda = new Tarea
		tareaBusqueda.descripcion = descripcion
		ok(RepoTareas.instance.searchByExample(tareaBusqueda).toJson)
	}

	@Put('/tareas/:id')
	def Result actualizar(@Body String body) {
		try {
			//if (true) throw new RuntimeException("ACHALAY")
			val actualizado = body.fromJson(Tarea)

			actualizado.asignarFecha(body.getPropertyValue("fecha"))
			
			val asignadoA = body.getPropertyValue("asignadoA")
			if (!asignadoA.equals("")) {
				val asignatario = RepoUsuarios.instance.getAsignatario(asignadoA)
				actualizado.asignarA(asignatario)
			}

			if (Integer.parseInt(id) != actualizado.id) {
				return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
			}

			RepoTareas.instance.update(actualizado)
			ok('{ "status" : "OK" }');
		} catch (Exception e) {
			badRequest(e.message)
		}
	}

}
