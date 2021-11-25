import wollok.game.*
import configuraciones.*
import ninja.*
import pociones.*



//opción de estamina

//+--------------------------------------------------------------------------------------------------+
//|                                 JUGADOR                                                          |
//+--------------------------------------------------------------------------------------------------+
object jugador inherits ObjetoEnPantalla{
		
    var   property  vida          = 100
	var   property  position      = game.at(3,1)
	var   property  poder         = 20 // daño del jugador
	var   property  energia        =  4
	var dirrecion = arriba


	method estaMuerto(){ return vida <= 0}
	
	method image() = "heroe(" + self.sufijo() + ").png"	

	method sufijo() = if(self.estaMuerto()){"muerto"}
                      else{dirrecion.sufijo()}

		
	method mover(_direccion) {
		self.validarMovimiento()
		dirrecion = _direccion
		self.irASiPuede(_direccion.siguiente(position))
	 }

 	method irASiPuede(nuevaPosicion) {
		if (coordenadas.posicionValida(nuevaPosicion)){
       	  position = nuevaPosicion
        }else{
          game.say(self,"Hay una pared bloqueando mi paso")	// Eliminar desp  // Tirar exepcion ??
        }
	
	}

	method validarMovimiento(){
		if(self.estaMuerto()){
	 	  self.error("Estoy muerto")
		}
	}


	method recibirDanio(cant){ // Nombre temp
 		vida -= cant
 		game.say(self,"Vida: " + vida )
		//game.sound("damage-hit-voice-vocal.mp3").play()  // sonidito de grito  
 		if(self.estaMuerto()){
			gameOver.iniciar()
 		}
 	}

  method atacar(dir){
  	 if(self.tieneEnergia()){
  	 	 game.sound("sword-sound-2.mp3").play()  // sonidito de espada 	
 	     areaDeAtaque.atacarHacia(dir)
 	     energia -= 1
 	     }
  	 }
  	 
  method tieneEnergia(){
  	return energia > 0
  }	
  
  method ganarEnergia(cant){ //suponer que 4 es el max que puede tener 
  	if(energia + cant >= 4){
  		 energia = 4 
  	}else{
  		 energia = 0.max(energia + cant)
  	} 
  }
  
  method ganarVida(cant){ //igual que el de arriba pero 100 es el max
  	if(vida + cant >= 100){
  		 vida = 100 
  	}else{
  		 vida = 0.max(vida + cant)
  	} 
  }
  
  method ganarPoder(cant){ 
  	poder = poder + cant
  }
  
  method AumentarVidaYDesaparecer(pocion){
  		self.ganarVida(pocion.cantidadDeAumento())
  		generadorDePociones.remover(pocion)
  		game.say(self,"Vida: " + vida )
  }
  
  method AumentarEnergiaYDesaparecer(pocion){
  		self.ganarEnergia(pocion.cantidadDeAumento())
  		generadorDePociones.remover(pocion)
  }
  
  method AumentarAtaqueYDesaparecer(pocion){
  		self.ganarPoder(pocion.cantidadDeAumento())
  		generadorDePociones.remover(pocion)
  }
  
}
//+--------------------------------------------------------------------------------------------------+
//|                                 AREA DE ATAQUE                                                   |
//+--------------------------------------------------------------------------------------------------+

 object areaDeAtaque inherits ObjetoEnPantalla{
  var property  position   = game.at(-1, 0)
  var property  poderGolpe = jugador.poder()

  method image() = "slash.png"  // solo para testear

	method desplazarseA(dir){
		position = dir
	}

	method atacarHacia(dir){
 		self.desplazarseA(dir.siguiente(jugador.position())) 
    	self.hacerAtaque() 
    	game.schedule(500, {  position = game.at(-1, 0) })		  
   }
	
 	method hacerAtaque(){
 	   const objetivos = game.colliders(self)
       objetivos.forEach({objeto => objeto.tomarPuntosDeDanio(poderGolpe)})									
  	}
  
   
   /*
    method hacerAtaque(){
 		game.whenCollideDo(self, { 
  			elemento => elemento.tomarPuntosDeDanio(poderGolpe)})										
  	}
*/
	
  	
}





