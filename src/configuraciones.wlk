import jugador.*
import wollok.game.*
import ninja.*

//+--------------------------------------------------------------------------------------------------+
//|                                 TECLAS                                                           |
//+--------------------------------------------------------------------------------------------------+
object config {

	method configurarTeclas() {
		
		keyboard.left().onPressDo( { jugador.mover(izquierda) } )
		keyboard.right().onPressDo({ jugador.mover(derecha) })
		keyboard.up().onPressDo({ jugador.mover(arriba) })
		keyboard.down().onPressDo({ jugador.mover(abajo) })
		
		keyboard.z().onPressDo(	{ jugador.atacar(izquierda) })
		keyboard.x().onPressDo(	{ jugador.atacar(arriba) })
		keyboard.c().onPressDo(	{ jugador.atacar(derecha) })
	 }	 
}



//+--------------------------------------------------------------------------------------------------+
//|                                 COORDENADAS Y DIRECCIONES                                        |
//+--------------------------------------------------------------------------------------------------+

object izquierda {
   method siguiente(posicion) {return posicion.left(1)}
    method sufijo() {return "izquierda"}
    method opuesto() {return derecha}
}

object derecha {
	method siguiente(posicion) {return posicion.right(1)}
	method sufijo() {return "derecha"}
	method opuesto() {return izquierda}
}

object arriba {
	method siguiente(posicion) {return posicion.up(1)}
	method sufijo() {return "arriba"}
	method opuesto() {return abajo}
}

object abajo {
	method siguiente(posicion) {return posicion.down(1)}
	method sufijo() {return "abajo"}
	method opuesto() {return arriba}
}

//COORDENADAS

object coordenadas {
	
	 	const rangoX = new Range(start=0,end= game.width() - 1 )
	 	const rangoY = new Range(start=0,end= game.height()- 1 )
	 	
	 	method x(){ return rangoX }
	 	method y(){	return rangoY }
	 	
	 	method ejeYValido(coordenada){ return rangoY.contains(coordenada)}
	 	method ejeXValido(coordenada){ return rangoX.contains(coordenada)}
	 	
	 	method posicionValida(posicion){
	 		return self.ejeYValido(posicion.y()) and self.ejeXValido(posicion.x())
	 	}
}

//+--------------------------------------------------------------------------------------------------+
//|                                 CARTEL                                                           |
//+--------------------------------------------------------------------------------------------------+

object cartel inherits ObjetoEnPantalla{
	var property  position = game.center()
	var property  text     = ""
	
	method textColor() { 
		return "ff0000ff"
	}
}

//+--------------------------------------------------------------------------------------------------+
//|                                 GameOver                                                         |
//+--------------------------------------------------------------------------------------------------+

object gameOver{
	
	method iniciar(){
		game.say(jugador, "perdí")
   		cartel.text("presione ENTER para salir")
   		keyboard.enter().onPressDo({game.stop()})
	}
}

//+--------------------------------------------------------------------------------------------------+
//|                                 Telon                                                            |
//+--------------------------------------------------------------------------------------------------+

object telon inherits ObjetoEnPantalla{
	
	var property fondo = ""
	var  property  position = game.at(0,0)
	
	
	 method image() = fondo
	
}



//+--------------------------------------------------------------------------------------------------+
//|                                 Herencias / Plantillas                                           |
//+--------------------------------------------------------------------------------------------------+

class ObjetoEnPantalla {
	
	method tomarPuntosDeDanio(poderGolpe){}
	method daniar(objeto){} 
	method mejorar(objeto){}	
}

class Enemigo inherits ObjetoEnPantalla { 
	
	method estaMuerto()
	method seMueve()
	method seDetiene()
	
	
}



