import wollok.game.*
import configuraciones.*
import niveles.*


object  fantasmas{
	const property fantasmas=  #{fantasma1,fantasma2,fantasma3,fantasma4} 
	
	const fantasma1 = new Fantasma( position = game.at(0, 0) )
    const fantasma2 = new Fantasma( position = game.at(game.width() - 1, 0) )
    const fantasma3 = new Fantasma( position = game.at(0, game.height() - 1) )
    const fantasma4 = new Fantasma( position = game.at(game.width() - 1, game.height() - 1)) 
}


class Fantasma inherits ObjetoEnPantalla{
	var property position 
	method image() = "Fantasma.png"  // imagen temp
	
	 
   
	
}
