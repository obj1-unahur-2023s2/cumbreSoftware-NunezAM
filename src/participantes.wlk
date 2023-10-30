import conocimientos.*
import cumbre.*
import actividades.*
import empresa.*

class Participante {
	const property pais
	const property conocimientos = #{}
	var commits
	
	method commits() = commits
	method esCapo()
	method cantDeConocimientos() = conocimientos.size()
	method puedeParticipar() = conocimientos.contains(programacionBasica) && self.condicionAdicional()
	method condicionAdicional()
	method hacerActividad(actividad) {
		conocimientos.add(actividad.tema())
		commits += actividad.tema().commitsPorHora() * actividad.horas()
	}
}

class Programador inherits Participante {
	var horasDeCapacitacion = 0
	
	override method esCapo() = commits > 500
	override method condicionAdicional() = commits > cumbre.commitsNecesarios()
	override method hacerActividad(actividad) {
		super(actividad)
		horasDeCapacitacion += actividad.horas()
	} 
}
class Especialista inherits Participante {
	
	override method esCapo() = self.cantDeConocimientos() > 2
	override method condicionAdicional() = commits > (cumbre.commitsNecesarios() - 100) && conocimientos.contains(objetos)
}

class Gerente inherits Participante {
	const empresa
	
	override method esCapo() = empresa.esMultinacional()
	override method condicionAdicional() = conocimientos.contains(manejoDeGrupos)
}
















