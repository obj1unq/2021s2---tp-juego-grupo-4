import wollok.game.*
import configuraciones.*

object ninja{
	var property vida = 100
	var property position = game.at(3,0)
	
	
	method image(){
		return "ninja.png"
	}	
	
	method seMueve(){
		position = game.at(coordenadas.coordenadasX().anyOne(), coordenadas.coordenadasY().anyOne())
	}
	
	method recibirDanio(cantidad){
		//solo para el polimorfismo de la shuriken por ahora
	}
	
}
	

