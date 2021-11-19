import jugador.*
import wollok.game.*
import ninja.*



// if de ataque al jugador, eliminar todo lo que corresponde a los enemigos del jugador

// crear enemigo tipo dementor que persiga al jugador que desaparezca frente a un ataque del jugador
// y se vuelva a invocar. (ontick variable) puede aparecer mas de uno a la vez. Sacan poca vida (5)

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
}

object derecha {
	method siguiente(posicion) {return posicion.right(1)}
}

object arriba {
	method siguiente(posicion) {return posicion.up(1)}
}

object abajo {
	method siguiente(posicion) {return posicion.down(1)}
}


// DIAGONALES
object diagonalIzq {
   method siguiente(posicion) {return posicion.left(1).up(1)}
}

object diagonalDer {
   method siguiente(posicion) {return posicion.right(1).up(1)}
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

//ver en donde poner el objeto gameOver()
object gameOver{
	
	method iniciar(){
		game.say(jugador, "perdí")
   		cartel.text("presione ENTER para salir")
   		keyboard.enter().onPressDo({game.stop()})
	}
}

//+--------------------------------------------------------------------------------------------------+
//|                                 Herencias / Plantillas                                           |
//+--------------------------------------------------------------------------------------------------+

class ObjetoEnPantalla {
	
	method tomarPuntosDeDanio(poderGolpe){}
	method daniar(objeto){} 
		
}

class Enemigo inherits ObjetoEnPantalla { // usar Herencias 
	
	method estaMuerto()
	method seMueve()
	method seDetiene()
	
	
}



