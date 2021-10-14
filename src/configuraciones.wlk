import jugador.*
import wollok.game.*



object config {

	method configurarTeclas() {
		
		keyboard.left().onPressDo( { jugador.mover(izquierda) } )
		keyboard.right().onPressDo({ jugador.mover(derecha) })
		keyboard.up().onPressDo({ jugador.mover(arriba) })
		keyboard.down().onPressDo({ jugador.mover(abajo) })
		keyboard.x().onPressDo({ jugador.atacar() })
		
	 }	 
}

object coordenadas {
	
	 	const x = new Range(start=0,end= game.width() )
	 	const y = new Range(start=0,end= game.height() )
	 	
	 	method coordenadasX(){
	 		return x
	 	}
	 	
	 	method coordenadasY(){
	 		return y
	 	}
}


object izquierda {
   method siguiente(posicion) {
		return posicion.left(1)
	}
}

object derecha {
	method siguiente(posicion) {
		return posicion.right(1)
	}	
}

object arriba {
	method siguiente(posicion) {
		return posicion.up(1)
	}	
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)
	}	
}

// diagonales hacia arriba

object diagonalIzq {
   method siguiente(posicion) {
		return posicion.left(1).up(1)
	}
}

object diagonalDer {
   method siguiente(posicion) {
		return posicion.right(1).up(1)
	}
}


object cartel {
	var property position = game.center()
	var property text = ""
	method textColor() { 
		return "ff0000ff"
	}
}