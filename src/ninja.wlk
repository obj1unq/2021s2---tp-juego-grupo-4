import wollok.game.*
import configuraciones.*
import shuriken.*

object ninja{
	var   property vida = 100
    var   property position = game.center()
    const property shurikens =[shuriken1,shuriken2,shuriken3] 

	
	method image(){
		return "ninja.png"
	}	
	
	method seMueve(){
		const x = 0.randomUpTo(game.width()).truncate(0) 
		const y = 0.randomUpTo(game.height()).truncate(0)
		position = game.at(x,y)
	}
	
	method lanzarShurikens(){
		shurikens.forEach{shuriken => shuriken.aparecer()}
	}
		 	
}
	

