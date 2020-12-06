class Minion{
	var tipo
	var property rol
	var property estamina
	var property fuerza
	
	
	method tieneEstamina(cant) = estamina >= cant
	method cantidadFuerza(){
		 fuerza = estamina/2 + 2 + rol.sumarFuerza()
	}
	method perderEstamina(cantidad){
		estamina -= cantidad
	}
	method realizarTarea(tarea){
		if(tarea.cumplirCondiciones(self)){
			tarea.realizarse(self)
		}else self.error("la tarea no puede realizarse ya que no cumple las condiciones necesarias")
	}
	method tieneTodasHerramientas(objeto){
		rol.cinturonHerramientas().contains()
	}
	method condicionPerderEstamina(){
		if(!rol == soldado){
			self.perderEstamina(estamina/2)
		}
	}
	method comerFruta(fruta){
		estamina += fruta.recuperar()
	}

}
object biclope inherits Minion{
	
	
}
object ciclope inherits Minion{
	var aciertoDelDisparo = 0.5	
	override method cantidadFuerza(){
		if(rol == obrero){
			fuerza = fuerza/2
		}else if(rol == soldado){
			fuerza = (fuerza + soldado.practica())/2
		}
	}
}
class Rol{
	var roles
	var cinturonHerramientas = []
	
	method tieneTodasHerramientas(herramientas) {
		return cinturonHerramientas.all({unaHerramienta => cinturonHerramientas.contains(unaHerramienta)})
		}
	
}
object soldado{
	var arma
	var property practica
	var danioArma
	method usarArma(){
		practica += 1
		danioArma +=2
	}
	method cambiarRol(){
		practica = 0
	}
	method sumarFuerza(){				
		return practica
	}
	
}
object mucama{
	const defenderSector = false
}
object obrero{
	var cinturonHerramientas = []
	
	
}
object cientifico{
	method ordenarRealizarTarea(minion,tarea){
		minion.realizarTarea(tarea)
	}
}
object candado{
	var property dificultad
	var property herramientasNecesarias
}
object reactorNuclear{
	var property dificultad
	var property herramientasNecesarias
}
object arreglarMaquina{
	var objeto
	method cumplirCondiciones(minion) = minion.estamina() == objeto.dificultad() and minion.tieneTodasHerramientas(objeto.herramientasNecesarias())
		
	method realizarse(minion){
		if(self.cumplirCondiciones(minion)){
			minion.perderEstamina(objeto.dificultad()*2) 
		}
	}
	
}
object defenderSector{
	var dificultad
	var gradoAmenaza
	method cumplirCondiciones(minion) {
		return !(minion.rol() == mucama) and minion.cantidadFuerza() >= gradoAmenaza
	}
			
			
	method realizarse(minion){
		if(self.cumplirCondiciones(minion)){
			minion.condicionPerderEstamina()
		}
	}
	method dificultadTarea(minion){
		if(minion.tipo() == biclope){
			dificultad = gradoAmenaza *2
		}else dificultad = gradoAmenaza
	}
}
object limipiarSector{
	var dificultad = 10
	var esGrande
	var requerida
	method cumplirCondiciones(minion){
		if(minion.rol() == mucama){
			self.realizarse(minion)
			}else self.condicionEstamina(minion)
		}
	method condicionEstamina(minion){
		if(esGrande){
			minion.tieneEstamina(4)
		}else minion.tieneEstamina(1)
	}
	method limpiarSector(minion){
		if(!minion.rol() == mucama){
			if(esGrande){
			minion.perderEstamina(4)
			}else minion.perderEstamina(1)
		}
		
	}
	method realizarse(minion){
		self.limpiarSector(minion)
	}
}

object banana{
	var property recuperar = 10
}
object manzana{
	var property recuperar = 5
}
object uva{
	var property recuperar = 1
}
