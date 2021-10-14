import wollok.game.*
import configuraciones.*

//Solucionar que el jugador se mueva de dos en dos
//setear enemigo!
//opción de estamina

object jugador {
		
    var property vida = 100
	var property position = game.at(3,1)
	const property poder = 20 // daño del jugador
	var property enemigosNivel = #{}
	
method perdio(){ return vida <= 0}
 	 
method image() = if(self.perdio()){    // Temporal
     "caballero con espada muerto.jpg"
      }else{
      "caballero  con espada.png"
      }

method mover(_direccion) {
	self.validarMovimiento()
	self.irASiPuede(_direccion.siguiente(self.position()))
 }

 method irASiPuede(nuevaPosicion) {
    if(self.esValida(nuevaPosicion)){
         position = nuevaPosicion
        }else{
//lanzar error en lugar de game.say
           game.say(self,"Hay una pared bloqueando mi paso")	// Eliminar desp  // Tirar exepcion ??
        }
	
	}

method esValida(posicion){
  return self.esValidoEje("x",posicion.x() ) and 
         self.esValidoEje("y",posicion.y() )
}


// reveer metodo para pasarlo a configuraciones, crear objeto eje X {}
method esValidoEje(eje,num){
 if(eje == "x"){
   return num.between(0,game.width()-1) // Cominza en x=0 
 }else{
   return num.between(0,game.height()-1)// Cominza en y=0  
     }
 }

method validarMovimiento(){
	if(self.perdio()){
	   self.error("Estoy muerto")
	}
}

method recibirDanio(cant){ // Nombre temp
 	vida -= cant
 	// game.sound("damage-hit-voice-vocal.mp3").play()  // sonidito de grito  
 	if(self.perdio()){
 	   self.terminar("Perdi")
 	}
 }
 
method terminar(mensaje) {
   game.say(self, mensaje)
   cartel.text("presione ENTER para salir")
   keyboard.enter().onPressDo({game.stop()})
 }
 

 method atacar(){
   const dirrecionesAAtacar = #{izquierda,diagonalIzq,arriba,diagonalDer,derecha}
//podría tener esta constante el area de ataque??? method direccionesDeAtaque()
  
   game.sound("sword-sound-2.mp3").play()  // sonidito de espada 
   dirrecionesAAtacar.forEach({ dir => self.atacarHacia(dir) })	 	
  }

 method atacarHacia(dir){
 	areaDeAtaque.desplazarseA(dir.siguiente(self.position())) 
    areaDeAtaque.hacerAtaque()   // areaDeAtaque esta en el archivo jugador
   }
 
 }


object areaDeAtaque{
  var property position = game.at(0, 0)
  var property poderGolpe = jugador.poder()

method desplazarseA(dir){
	position = dir
}
	
 method hacerAtaque(){
 	game.whenCollideDo(self, { elemento => if (jugador.enemigosNivel().contains(elemento)){
 		elemento.tomarPuntosDeDanio(poderGolpe)
 	}  
 	  })
  }
  
 	
}





