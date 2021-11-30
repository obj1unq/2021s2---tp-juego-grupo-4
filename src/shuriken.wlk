import configuraciones.*
import ninja.*
import wollok.game.*

class  Shuriken inherits ObjetoEnPantalla{
	
	var property  position  = game.center()
	const  direccion
		
	method image() = "Shuriken .png" 
	
	
	method moverse(){
		position = direccion.siguiente(position)
	}

	method aparecer(){
		position = ninja.position()
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}
	
	override method daniar(objeto){
		objeto.recibirDanio(10)
		self.desaparecer()
	}	
	
	method desaparecer(){
		if (game.hasVisual(self)){
			game.removeVisual(self)
		}
	}
	
}
