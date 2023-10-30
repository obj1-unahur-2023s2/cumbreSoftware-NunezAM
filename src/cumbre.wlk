import pais.*
import participantes.*
import actividades.*

object cumbre {
	const auspiciantes = #{}
	const participantes = #{}
	const property ingresos = #{}
	const actividades = #{}
	var property commitsNecesarios = 300
	
	method registrarIngreso(participante) {
		participantes.add(participante)
	}
	method esConflictivo(pais) = auspiciantes.any({p => p.paisesConConflicto().contains(pais)})
	method paisesDeLosParticipantes() = participantes.map({p => p.pais()}).asSet()
	method cantDeParticipantesDe(pais) = participantes.count({p => p.pais() == pais})
	method paisConMasParticipantes() = self.paisesDeLosParticipantes().max({p => self.cantDeParticipantesDe(p)})
	method participantesExtranjeros() = self.paisesDeLosParticipantes().difference(auspiciantes)
	method esRelevante() = participantes.all({p => p.esCapo()})
	method registrarAuspiciante(pais) = auspiciantes.add(pais)
	method tieneRestringidoElAcceso(participante) = self.esDePaisConflictivo(participante.pais()) && self.noHayCupoParaElPais(participante.pais())
	method esDePaisConflictivo(pais) = !pais.paisesConConflicto().isEmpty()
	method noHayCupoParaElPais(pais) = !auspiciantes.contains(pais) && self.cantDeParticipantesDe(pais) > 2
	method puedeIngresar(participante) = participante.puedeParticipar() && !self.tieneRestringidoElAcceso(participante)
	
	method darIngreso(participante) {
		if(!self.puedeIngresar(participante)) { 
			self.error("No cumple con los requisitos para ingresar")
		}
		ingresos.add(participante)
	}
	
	method esSegura() = participantes.all({p => self.puedeIngresar(p)})
	method agregarActividad(actividad) {
		actividades.add(actividad)
		self.hacerActividad(actividad)
	}
	
	method hacerActividad(actividad) {
		participantes.forEach({p => p.hacerActividad(actividad)})	
	}
	
	method horasRealizadas() = actividades.sum({a => a.horas()})
}
