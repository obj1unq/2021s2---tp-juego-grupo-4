import wollok.game.*
import configuraciones.*
import jugador.*
import ninja.*
import shuriken.*


//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL                                                            |
//+--------------------------------------------------------------------------------------------------+

class Nivel {  // => hacer herencia para todos los niveles 
	
}


//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL 1                                                          |
//+--------------------------------------------------------------------------------------------------+
object nivel1 {  // inherits Nivel
	
	method nivelGanado(){
		return ninja.estaMuerto()
	}
	
	method iniciar(){
//	game.boardGround(image)
	game.addVisual(jugador)
	game.addVisual(ninja)
 	game.addVisual(areaDeAtaque)
	game.addVisual(cartel)
	
	
	config.configurarTeclas()
	game.showAttributes(jugador)
		
	self.agregarEventos()
//sacar ese if para meter el polimorfismo elemento => elemento.daniar(jugador)
	game.onCollideDo(jugador, {elemento => if (ninja.esUnShuriken(elemento)){elemento.daniar(jugador)}})
	
	}
	
	
	method agregarEventos(){
			game.onTick(2000,"movimientoNinja",{ninja.seMueve()})
			game.onTick(6000,"lanzarShurikens",{ninja.lanzarShurikens()})	
			game.onTick(500,"movimientoShurikens",{ ninja.desplazarShurikens()})
		
			game.onTick(500,"ganarEnergiaJugador",{ jugador.ganarEnergia(1)})
	}
	
	method removerEventos(){  
		game.removeTickEvent("movimientoNinja")
		game.removeTickEvent("lanzarShurikens")
		game.removeTickEvent("movimientoShurikens")
	}
	
	
  
 
	
}
	


  
	 


/*
 method nivelPerdido(){
  return jugador.estaMuerto()
 } 
	 
 method terminarNivel(){
   if(self.nivelGanado()){
     gameOver.ganarNivel(1)
   }else{
     gameOver.iniciar()
     }
 }	
	
	 
*/



	

