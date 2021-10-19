import configuraciones.*
import ninja.*
import wollok.game.*


//Armar Clase para Shurikens
class  Shuriken {
	
	var property position= game.center()
	var dir = izquierda
	
	method image() = "Shuriken .png" 
	
	method moverse(){
		position = dir.siguiente(position)
	}

	method aparecer(){
		position = ninja.position()
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}
	
	method daniar(objeto){
		objeto.recibirDanio(2)
		self.desaparecer()
		
	}	
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
}

/*
 
 object shuriken1 {
	
	var property position= game.center()
	method image() = "Shuriken .png"
	
	method moverse(){
		position = position.right(1)
	}
	
	method aparecer(){
		position = ninja.position()
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}
	
	method daniar(objeto){
		objeto.recibirDanio(2)
		self.desaparecer()
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
}

object shuriken2 {
	
	var property position= game.center()
	method image() = "Shuriken .png"
	
	method moverse(){
		position = position.down(1)
	}
	
	method aparecer(){
		position = ninja.position()
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}
	
	method daniar(objeto){
		objeto.recibirDanio(2)
		self.desaparecer()
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
}

object shuriken3 {
	
	var property position= game.center()
	method image() = "Shuriken .png"
	
	method moverse(){
		position = position.left(1)
	}

	method aparecer(){
		position = ninja.position()
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}
	
	method daniar(objeto){
		objeto.recibirDanio(2)
		self.desaparecer()
	}
	
	method desaparecer(){
		game.removeVisual(self)
	}
	
}
*/