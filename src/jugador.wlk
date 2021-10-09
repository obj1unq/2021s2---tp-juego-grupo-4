import wollok.game.*


object jugador {
		
    var property vida = 100
	var property position = game.at(3,1)
	const poder = 20 // daño del jugador

  method image() = "pepita.png"

method mover(_direccion) {
	self.irASiPuede(_direccion.siguiente(self.position()))
 }

 method irASiPuede(nuevaPosicion) {
    if(self.esValida(nuevaPosicion)){
         position = nuevaPosicion
        }else{
           game.say(self,"Hay una pared bloqueando mi paso")	// Eliminar desp
        }
	
	}

 method esValida(posicion){
  return self.esValidoEje("x",posicion.x() ) and 
         self.esValidoEje("y",posicion.y() )
}


method esValidoEje(eje,num){
 if(eje == "x"){
   return num.between(0,game.width()-1) // Cominza en x=0 
 }else{
   return num.between(0,game.height()-1)// Cominza en y=0  
     }
 }

 method recibirDanio(cant){ // Nombre temp
 	vida -= cant 
 }

}


object izquierda {
   method siguiente(posicion) {
		return posicion.left(1)
	}
}

object derecha {
	method siguiente(posicion) {
		return posicion.right(1)
	}	
}

object arriba {
	method siguiente(posicion) {
		return posicion.up(1)
	}	
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)
	}	
}