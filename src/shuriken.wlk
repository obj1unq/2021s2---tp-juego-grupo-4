import configuraciones.*
import ninja.*
import wollok.game.*

object shuriken {
	
	var property position= game.at(9,9)
	method image() = "Shuriken .png"
	
	method moverse(){
		position = position.right(1)
	}
	
	method aparecerEn(posicion){
		position = posicion
	}
	method recibirDanio(cantidad){
		//solo para el polimorfismo de la shuriken por ahora
	}
	
}

object shuriken2 {
	
	var property position= game.at(9,9)
	method image() = "Shuriken .png"
	
	method moverse(){
		position = position.down(1)
	}
	
	method aparecerEn(posicion){
		position = posicion
	}
	method recibirDanio(cantidad){
		//solo para el polimorfismo de la shuriken por ahora
	}
	
}

object shuriken3 {
	
	var property position= game.at(9,9)
	method image() = "Shuriken .png"
	
	method moverse(){
		position = position.left(1)
	}
	
	method aparecerEn(posicion){
		position = posicion
	}
	
	method recibirDanio(cantidad){
		//solo para el polimorfismo de la shuriken por ahora
	}
	
}
