import wollok.game.*
import configuraciones.*
import niveles.*
import jugador.*


object  fantasmas {
	var property fantasmas = [] 
	const property position = game.center() 
	var property fantasmasRestantes   
  
  	method agregarFantasma(fantasma){
  		fantasmas.add(fantasma)	
  	}
  	
    method estanVencidos(){
    	return fantasmasRestantes == 0 
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
   
   method daniar(cantidad){} 
   
   method mejorar(objeto){}
   
   method fantasmaEsLiberado(){
   	 fantasmasRestantes -=   1 
   }
    
}


class Fantasma inherits Enemigo{
	var property vida = 4  
	var property position = game.at(-1,-1)
	method image() = "Fantasma2.png" 
	
	override method seMueve(){
		if(not jugador.estaMuerto()){
			self.hacerMovimiento()
		}
	}
	  
	
	method hacerMovimiento(){
	   if(self.estaEnLaMismaFilaQueELJugador()){
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
		game.say(self,"Ya puedo descansar en Paz")  
		self.removerSe()
		
	}
	 
    method removerSe(){
    	if (game.hasVisual(self)){
			game.removeVisual(self)
		}
    }
    
    override method tomarPuntosDeDanio(poderGolpe){
    	vida -= 1
    	if(not self.estaMuerto()){
    	   musica.activarSonido("ghost_damage.mp3") 
    	   const x = (coordenadas.x().anyOne()).truncate(0) 
		   const y = (coordenadas.y().anyOne()).truncate(0) 
	       position = game.at(x,y)
    	}else{
    	  musica.activarSonido("ghost_dead.mp3") 
    	  fantasmas.fantasmaEsLiberado() 
    	  self.seDetiene()	
    	  nivel2.terminarNivelSiCorresponde()
    	}
    		  
    }
    
  override  method daniar(objeto){
		objeto.recibirDanio(20)
	}
	
	 method recibirDanio(cant){}
	
  method aparecer(){
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}	 	 
 
     
	method moverHacia(dir){
		if(self.celdaValidaParaMover(dir)){}
			position = dir.siguiente(position)  
		}
		
//ver		
	method 	celdaValidaParaMover(dir){
		return   game.getObjectsIn(dir.siguiente(position)).isEmpty() or self.esLaCasillaDelJugador(dir.siguiente(position))    
	}
//ver	
	method esLaCasillaDelJugador(celda){
		return jugador.position() == celda
	}
			 


}
