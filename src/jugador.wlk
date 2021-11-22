import wollok.game.*
import configuraciones.*
import ninja.*



//opción de estamina

//+--------------------------------------------------------------------------------------------------+
//|                                 JUGADOR                                                          |
//+--------------------------------------------------------------------------------------------------+
object jugador inherits ObjetoEnPantalla{
		
    var   property  vida          = 100
	var   property  position      = game.at(3,1)
	const property  poder         = 20 // daño del jugador
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
//		game.sound("damage-hit-voice-vocal.mp3").play()  // sonidito de grito  
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
  
}
//+--------------------------------------------------------------------------------------------------+
//|                                 AREA DE ATAQUE                                                   |
//+--------------------------------------------------------------------------------------------------+

 object areaDeAtaque inherits ObjetoEnPantalla{
  var property  position   = game.at(0, 0)
  var property  poderGolpe = jugador.poder()

  method image() = "Shuriken.png"  // solo para testear

	method desplazarseA(dir){
		position = dir
	}

	method atacarHacia(dir){
 		self.desplazarseA(dir.siguiente(jugador.position())) 
    	self.hacerAtaque() 
    			  
   }
	
 	method hacerAtaque(){
 		game.whenCollideDo(self, { elemento => elemento.tomarPuntosDeDanio(poderGolpe)})										
  	}
}





