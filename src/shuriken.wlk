import configuraciones.*
import ninja.*
import wollok.game.*



class  Shuriken {
	
	var property  position  = game.center()
	var property  direccion = izquierda
		
	method image() = "Shuriken .png" 
	
	
	method moverse(){
		position = direccion.siguiente(position)
	}

	method aparecer(){
		position = ninja.position()
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}
	
	method daniar(objeto){
		objeto.recibirDanio(10)
		self.desaparecer()
	}	
	
	method desaparecer(){
		if (game.hasVisual(self)){
			game.removeVisual(self)
		}
	}
	
}
