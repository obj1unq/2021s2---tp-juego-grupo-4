import wollok.game.*
import configuraciones.*
import ninja.*



//opción de estamina

//+--------------------------------------------------------------------------------------------------+
//|                                 JUGADOR                                                          |
//+--------------------------------------------------------------------------------------------------+
object jugador {
		
    var   property  vida          = 100
	var   property  position      = game.at(3,1)
	const property  poder         = 20 // daño del jugador
	var   property  enemigosNivel = #{}


	method estaMuerto(){ return vida <= 0}
		

	method image() = if(self.estaMuerto()){   
     "caballero con espada muerto.jpg"
      }else{
      "caballero  con espada.png"
      }

	method esEnemigo(elemento){
		return enemigosNivel.contains(elemento)
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
 // METODO CREADO MOMENTANEAMENTE PARA VER LA MUERTE DEL NINJA
 	method atacar(){
 		const elemento = game.colliders(self).head()
 		
		game.sound("sword-sound-2.mp3").play()		
// arreglar este if para que desaparezca y hay polimorfismo		
//				elemento => self.daniar(elemento)
 		if(self.esEnemigo(elemento)){elemento.tomarPuntosDeDanio(40)}
 																													
 	}
 	
 }
 
//+--------------------------------------------------------------------------------------------------+
//|                                 AREA DE ATAQUE                                                   |
//+--------------------------------------------------------------------------------------------------+

object areaDeAtaque{
  var property  position   = game.at(0, 0)
  var property  poderGolpe = jugador.poder()

	method desplazarseA(dir){
		position = dir
	}

	method atacar(){
		const dirrecionesAAtacar = #{izquierda,diagonalIzq,arriba,diagonalDer,derecha}
  		//podría tener esta constante el area de ataque??? method direccionesDeAtaque()
   		game.sound("sword-sound-2.mp3").play()  // sonidito de espada 
   		dirrecionesAAtacar.forEach({ dir => self.atacarHacia(dir) })	 	
	}

	method atacarHacia(dir){
 		self.desplazarseA(dir.siguiente(self.position())) 
    	self.hacerAtaque()   // areaDeAtaque esta en el archivo jugador
   }
	
 	method hacerAtaque(){
 		game.whenCollideDo(self, { elemento => if (jugador.enemigosNivel().contains(elemento)){
 														elemento.tomarPuntosDeDanio(poderGolpe)}}) 																		
  	}
}





