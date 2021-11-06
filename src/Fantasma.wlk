import wollok.game.*
import configuraciones.*
import niveles.*
import jugador.*

object  fantasmas{
	var property fantasmas=  #{fantasma1,fantasma2,fantasma3,fantasma4} 
	
	const fantasma1 = new Fantasma( position = game.at(0, 0) )
    const fantasma2 = new Fantasma( position = game.at(game.width() - 1, 0) )
    const fantasma3 = new Fantasma( position = game.at(0, game.height() - 1) )
    const fantasma4 = new Fantasma( position = game.at(game.width() - 1, game.height() - 1))
    
    method estanVencidos(){
    	return fantasmas.size() == 0 
    }
    
   method removerFantasmasLiberados(){
   	 fantasmas =  fantasmas.filter({fantasma => fantasma.vida() > 0 })
   }
   
   method moverFantasmas(){
   	 fantasmas.forEach({fantasma => fantasma.seMueve()})
   } 
    
}


class Fantasma inherits Enemigo{
	var property vida = 4  
	var property position 
	method image() = "Fantasma.png"  // imagen temp
	
	override method seMueve(){
	   if(position.x() == jugador.position().x()){
	   	  self.position().arriba()
	   }else{
	   	 self.coordinarEjeX()
	   }	
	}
	
	method coordinarEjeX(){
		if(position.x() > jugador.position().x()){
			self.position().izquierda()
		}else{
			self.position().derecha()
		}
	}
	
	override method estaMuerto(){
		return vida == 0
	}
	
	override method seDetiene(){
		game.say(self,"Ya puedo descansar en Paz")  //sacar mensaje
		self.removerSe()
		//nivel2.removerEventos()
	}
	 
    method removerSe(){
    	game.removeVisual(self)
    }
    
    override method tomarPuntosDeDanio(poderGolpe){
    	vida -= 1
    	// poner sonido
    	const x = (coordenadas.x().anyOne()).truncate(0) 
		const y = (coordenadas.y().anyOne()).truncate(0) 
	    position = game.at(x,y)	  
    }
	
}
