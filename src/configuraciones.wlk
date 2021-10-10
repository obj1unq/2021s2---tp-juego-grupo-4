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
