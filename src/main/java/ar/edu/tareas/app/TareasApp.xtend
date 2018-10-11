package ar.edu.tareas.app

import ar.edu.tareas.controller.TareasController
import ar.edu.tareas.controller.UsuariosController
import org.uqbar.xtrest.api.XTRest

class TareasApp {

	def static void main(String[] args) {
		XTRest.start(9000, UsuariosController, TareasController)
	}
	
}
