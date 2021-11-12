import wollok.game.*
import configuraciones.*
import niveles.*
import jugador.*


object  fantasmas {
	var property fantasmas  // =  #{fantasma1,fantasma2,fantasma3,fantasma4} 
	const property position = game.center() // ver 
/*	
	const fantasma1 = new Fantasma( position = game.at(0, 0) )
    const fantasma2 = new Fantasma( position = game.at(game.width() - 1, 0) )
    const fantasma3 = new Fantasma( position = game.at(0, game.height() - 1) )
    const fantasma4 = new Fantasma( position = game.at(game.width() - 1, game.height() - 1))
*/  
    method estanVencidos(){
    	return fantasmas.size() == 0 
    }
    
     method tomarPuntosDeDanio(poderGolpe){
    	self.removerFantasmasLiberados()
    }
    
   method removerFantasmasLiberados(){
   	 fantasmas =  fantasmas.filter({fantasma => fantasma.vida() > 0 })
   }
   
   method moverFantasmas(){
   	 fantasmas.forEach({fantasma => fantasma.seMueve()})
   }
   
   method aparecerFantasmas(){
   	 fantasmas.forEach({fantasma => fantasma.aparecer()})
   } 
    
}


class Fantasma inherits Enemigo{
	var property vida = 4  
	var property position = game.at(-1,-1)
	method image() = "Fantasma .png" //"Fantasma.png"  // imagen temp
	
	override method seMueve(){
	   if(self.estaEnLaMismaFilaQueELJugador() ){
	   	  self.acercarseHaciaElJugador()  
	   }else{
	   	 self.coordinarEjeX()
	   }	
	}
	
	method estaEnLaMismaFilaQueELJugador(){return position.x() == jugador.position().x()}
	
	method acercarseHaciaElJugador(){
		if(position.y() > jugador.position().y()){
		    self.moverHacia(abajo)   
		}else{
		    self.moverHacia(arriba)   
		}
	}
	
	method coordinarEjeX(){
		if(position.x() > jugador.position().x()){
		   self.moverHacia(izquierda)  
		}else{
		   self.moverHacia(derecha)  
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
    	if (game.hasVisual(self)){
			game.removeVisual(self)
		}
    }
    
    override method tomarPuntosDeDanio(poderGolpe){
    	vida -= 1
    	if(not self.estaMuerto()){
    	   // poner sonido
    	   const x = (coordenadas.x().anyOne()).truncate(0) 
		   const y = (coordenadas.y().anyOne()).truncate(0) 
	       position = game.at(x,y)
    	}else{
    	   self.removerSe()
    	}
    		  
    }
    
  override  method daniar(objeto){
		objeto.recibirDanio(20)
	}
	
  method aparecer(){
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}	 	 
    
	method moverHacia(dir){
		//if(not self.hayFantasmaEn(dir)){} falta hacer 
			position = dir.siguiente(position)  
		}	 


}
