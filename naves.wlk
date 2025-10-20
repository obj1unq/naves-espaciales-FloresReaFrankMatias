class Nave {
  	var  property velocidad = 0 
	const propulsion = 20000
	method recibirAmenaza() {
	  
	}

	method propulsar() {
		const velocidadAlPropulsar = velocidad + propulsion
		if( velocidadAlPropulsar < 300000 ){ 
			velocidad += propulsion
		}else{
			velocidad = velocidadAlPropulsar.min(300000)
		}
		 
	}
	method prepararViaje() {
	  const velocidadAlPreparar = velocidad + 15000 
	  if( velocidadAlPreparar < 300000 ){ 
			velocidad += 15000
		}else{
			velocidad = velocidadAlPreparar.min(300000)
		}
		 
	}
	method encontrarseConEnemigo() {
	  self.recibirAmenaza()
	  self.propulsar()
	}
}

//--------------------------------------------------------------------

class NaveDeCarga inherits Nave  {

	//const  velocidad = 0
	var property carga = 0
	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}
	

}

class NaveDeCargaDeResiduos inherits NaveDeCarga{
  	var property sellado = false

	method esSellado(){
		sellado = true
	}
	
	override method recibirAmenaza(){
		self.entregarNave()
	}
	method entregarNave() {
	  velocidad = 0
	}
	override method prepararViaje() {
		super()
	  self.esSellado()
	}

}



//--------------------------------------------------------------------
class NaveDePasajeros  inherits Nave  {

	// var velocidad = 0
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
	
}
//--------------------------------------------------------------------
class NaveDeCombate inherits Nave {
	//var property velocidad = 0
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
	override method prepararViaje() {
		super()	
	 	modo.prepararViaje(self)
	}
}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
	method prepararViaje(nave) {
	  nave.emitirMensaje("Saliendo En mision")
	}
}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}
	method prepararViaje(nave) {
	  nave.emitirMensaje("Volviendo a la Base")
	}
}
//--------------------------------------------------------------------