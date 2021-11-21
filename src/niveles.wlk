import wollok.game.*
import configuraciones.*
import jugador.*
import ninja.*
import shuriken.*
import Fantasma.*


//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL                                                            |
//+--------------------------------------------------------------------------------------------------+

class Nivel {  // => hacer herencia para todos los niveles 
	
	method iniciar()
	method agregarEventos()
	method removerEventos()
	method nivelGanado()
	method pasarAlsiguienteNivel()
	
	method terminarNivelSiCorresponde(){
		if(self.nivelGanado()){
		   self.pasarAlsiguienteNivel()	
		}
	}
	
	
		
}



//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL 1                                                          |
//+--------------------------------------------------------------------------------------------------+
object nivel1 inherits Nivel {
	
	override method nivelGanado(){
		return ninja.estaMuerto()
	}
	
	override method iniciar(){
	game.boardGround("Dojo.jpg")
	game.addVisual(jugador)
	game.addVisual(ninja)
 	game.addVisual(areaDeAtaque)
	game.addVisual(cartel)
	
	
	config.configurarTeclas()
	game.showAttributes(jugador)
		
	self.agregarEventos()

	game.onCollideDo(jugador, {elemento => elemento.daniar(jugador)})
	
	}
	
	
	override method agregarEventos(){
			game.onTick(2000,"movimientoNinja",{ninja.seMueve()})
			game.onTick(6000,"lanzarShurikens",{ninja.lanzarShurikens()})	
			game.onTick(500,"movimientoShurikens",{ ninja.desplazarShurikens()})
		
			game.onTick(1000,"ganarEnergiaJugador",{ jugador.ganarEnergia(1)})
	}
	
	override method removerEventos(){  
		game.removeTickEvent("movimientoNinja")
		game.removeTickEvent("lanzarShurikens")
		game.removeTickEvent("movimientoShurikens")
	}
	
	override method pasarAlsiguienteNivel(){
		ninja.seDetiene()
		game.removeVisual(ninja)
	 	game.say(jugador, "El ninja fue vencido")
	 	game.clear()
	 	
	 	game.schedule(1000, { nivel2.iniciar() })
	 	
	
	}
		
}

//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL 2                                                          |
//+--------------------------------------------------------------------------------------------------+

  object nivel2 inherits Nivel {
  	
  override method iniciar(){
  	
  	const fantasma1 = new Fantasma( position = game.at(0, 0) )
    const fantasma2 = new Fantasma( position = game.at(game.width() - 1, 0) )
    const fantasma3 = new Fantasma( position = game.at(0, game.height() - 1) )
    const fantasma4 = new Fantasma( position = game.at(game.width() - 1, game.height() - 1))
  	fantasmas.fantasmas(#{fantasma1,fantasma2,fantasma3,fantasma4} )
  	fantasmas.fantasmasRestantes(4)
  	
  	game.boardGround("Cementerio.jpg")
	game.addVisual(jugador)
	game.addVisual(areaDeAtaque)
	game.addVisual(fantasmas)                                   
	game.addVisual(cartel)
		
	fantasmas.aparecerFantasmas()	
	game.showAttributes(fantasmas)
		
	config.configurarTeclas()
	game.showAttributes(jugador)
		
	self.agregarEventos()
	game.onCollideDo(jugador, {elemento => elemento.daniar(jugador)})
	
  }
  
  
	override method agregarEventos(){
		game.onTick(1000,"movimientoFantasmas",{fantasmas.moverFantasmas()})
		game.onTick(1000,"ganarEnergiaJugador",{ jugador.ganarEnergia(1)})
	}
	
	override method removerEventos(){
		game.removeTickEvent("movimientoFantasmas")
		game.removeTickEvent("ganarEnergiaJugador")
	}
	
	override method nivelGanado(){
		return fantasmas.estanVencidos()
	}
	
	override method pasarAlsiguienteNivel(){
		self.removerEventos()
	 	game.say(jugador, "los fantasmas fueron vencidos")
	 	game.clear()
	 	
	 	game.schedule(1000, { nivel1.iniciar() })
	}
  	
  }


  
	 





	

