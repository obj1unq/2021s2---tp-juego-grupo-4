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


	method estaMuerto(){ return vida <= 0}
		

	method image() = if(self.estaMuerto()){   
     "caballero con espada muerto.jpg"
      }else{
      "caballero  con espada.png"
      }

		
	method mover(_direccion) {
		self.validarMovimiento()
		self.irASiPuede(_direccion.siguiente(position))
	 }

 	method irASiPuede(nuevaPosicion) {
		if (coordenadas.posicionValida(nuevaPosicion)){
       	  position = nuevaPosicion
        }else{
//lanzar error en lugar de game.say
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


 /*
 method atacar(){	
 	 areaDeAtaque.atacar()
 	}
*/
  method atacar(dir){
  	 game.sound("sword-sound-2.mp3").play()  // sonidito de espada 	
 	 areaDeAtaque.atacarHacia(dir)
 	
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
/*
	method atacar(){
		const dirrecionesAAtacar = #{izquierda,diagonalIzq,arriba,diagonalDer,derecha}
   		game.sound("sword-sound-2.mp3").play()  // sonidito de espada 
   		dirrecionesAAtacar.forEach({ dir => self.atacarHacia(dir) })	 	
	}
*/

	method atacarHacia(dir){
 		self.desplazarseA(dir.siguiente(jugador.position())) 
    	self.hacerAtaque()   
   }
	
 	method hacerAtaque(){
 		game.whenCollideDo(self, { elemento => elemento.tomarPuntosDeDanio(poderGolpe)}) 																		
  	}
}





