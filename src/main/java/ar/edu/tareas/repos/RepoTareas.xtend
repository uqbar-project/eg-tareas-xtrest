package ar.edu.tareas.repos

import ar.edu.tareas.domain.Tarea
import java.time.LocalDate
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedRepo

class RepoTareas extends CollectionBasedRepo<Tarea> {

	RepoUsuarios repoUsuario

	/* Singleton */
	static RepoTareas repoTareas

	def static RepoTareas getInstance() {
		if (repoTareas === null) {
			repoTareas = new RepoTareas
		}
		repoTareas
	}

	private new() {
		repoUsuario = RepoUsuarios.instance
		this.crearTarea("Desarrollar componente de envio de mails", "Juan Contardo", LocalDate.now(), "Iteración 1", 0)
		this.crearTarea("Implementar single sign on desde la extranet", null, LocalDate.of(2018, 9, 9), "Iteración 1", 76)
		this.crearTarea("Cancelar pedidos que esten pendientes desde hace 2 meses", "Rodrigo Grisolia", LocalDate.of(2018, 6, 30),
			"Iteración 1", 22)
		this.crearTarea("Mostrar info del pedido cuando esta finalizado", null, LocalDate.of(2018, 8, 10), "Iteración 2", 90)
	}

	def crearTarea(String unaDescripcion, String responsable, LocalDate date, String unaIteracion, int cumplimiento) {
		new Tarea => [
			if (responsable !== null) {
				asignatario = repoUsuario.getAsignatario(responsable)
			}
			descripcion = unaDescripcion
			fecha = date ?: LocalDate.now
			iteracion = unaIteracion
			porcentajeCumplimiento = cumplimiento
			this.create(it)
		]
	}

	override protected Predicate<Tarea> getCriterio(Tarea example) {
		new Predicate<Tarea> {

			override evaluate(Tarea tarea) {
				example.descripcion === null || tarea?.descripcion.toUpperCase.contains(example.descripcion?.toUpperCase)
			}

		}
	}

	override createExample() {
		new Tarea
	}

	override getEntityType() {
		typeof(Tarea)
	}

	def tareasPendientes() {
		allInstances.filter [ it.estaPendiente ].toList
	}

}
