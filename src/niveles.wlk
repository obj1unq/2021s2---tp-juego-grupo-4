import wollok.game.*
import configuraciones.*
import jugador.*
import ninja.*
import shuriken.*
import Fantasma.*
import pociones.*
import mago.*



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
	
	method fondoDelNivel()
		
}



//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL 1                                                          |
//+--------------------------------------------------------------------------------------------------+
object nivel1 inherits Nivel {
	
	override method nivelGanado(){
		return ninja.estaMuerto()
	}
	
	override method iniciar(){
	game.addVisual(telon)  //game.boardGround("Dojo.jpg")
	telon.fondo(self.fondoDelNivel())
	
	game.addVisual(jugador)
	game.addVisual(ninja)
 	game.addVisual(areaDeAtaque)
	game.addVisual(cartel)
	
	
	config.configurarTeclas()
	
		
	self.agregarEventos()

	game.onCollideDo(jugador, {elemento => elemento.daniar(jugador)})
	game.onCollideDo(jugador, {pocion => pocion.mejorar(jugador)})
	
	}
	
	
	override method agregarEventos(){
			game.onTick(2000,"movimientoNinja",{ninja.seMueve()})
			game.onTick(6000,"lanzarShurikens",{ninja.lanzarShurikens()})	
			game.onTick(250,"movimientoShurikens",{ ninja.desplazarShurikens()})
		
			game.onTick(1000,"ganarEnergiaJugador",{ jugador.ganarEnergia(1)})
			game.onTick(5000,"pociones",{ generadorDePociones.agregarPocion()})
  }
	
	override method removerEventos(){  
		game.removeTickEvent("movimientoNinja")
		game.removeTickEvent("lanzarShurikens")
		game.removeTickEvent("movimientoShurikens")
		game.removeTickEvent("pociones")
	}
	
	override method pasarAlsiguienteNivel(){
		ninja.seDetiene()
		game.removeVisual(ninja)
	 	game.say(jugador, "El ninja fue vencido")
	 	game.clear()
       
	 	
	   game.schedule(1000, { nivel2.iniciar() })
	 	
	
	}
	
	override method fondoDelNivel(){ return "Dojo.jpg"}
		
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
  	
  	
  	
  	game.addVisual(telon)   
	telon.fondo(self.fondoDelNivel())
  	
  	
	game.addVisual(jugador)
	game.addVisual(areaDeAtaque)
	game.addVisual(fantasmas)                                   
	game.addVisual(cartel)
		
	fantasmas.aparecerFantasmas()	
	game.showAttributes(fantasmas)
		
	config.configurarTeclas()
	
		
	self.agregarEventos()
	game.onCollideDo(jugador, {elemento => elemento.daniar(jugador)})
	game.onCollideDo(jugador, {pocion => pocion.mejorar(jugador)})
	
  }
  
  
	override method agregarEventos(){
		game.onTick(1000,"movimientoFantasmas",{fantasmas.moverFantasmas()})
		game.onTick(1000,"ganarEnergiaJugador",{ jugador.ganarEnergia(1)})
		game.onTick(10000,"pociones",{ generadorDePociones.agregarPocion()})
	}
	
	override method removerEventos(){
		game.removeTickEvent("movimientoFantasmas")
		game.removeTickEvent("ganarEnergiaJugador")
		game.removeTickEvent("pociones")
	}
	
	override method nivelGanado(){
		return fantasmas.estanVencidos()
	}
	
	override method pasarAlsiguienteNivel(){
		self.removerEventos()
	 	game.say(jugador, "los fantasmas fueron vencidos")
	 	game.clear()
	 	
	 	game.schedule(1000, { nivel3.iniciar() })
	}
	
	override method fondoDelNivel(){ return "Cementerio.jpg"}
  	
  }

//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL 3                                                          |
//+--------------------------------------------------------------------------------------------------+
  
  object nivel3 inherits Nivel{
  	
  	override method nivelGanado(){
		return mago.estaMuerto()
	}
	
	override method iniciar(){
	game.addVisual(telon) 
	telon.fondo(self.fondoDelNivel())
	
	game.addVisual(jugador)
	game.addVisual(mago)
 	game.addVisual(areaDeAtaque)
	game.addVisual(cartel)
	
	

	
	config.configurarTeclas()

			
	self.agregarEventos()

	game.onCollideDo(jugador, {elemento => elemento.daniar(jugador)})
	game.onCollideDo(jugador, {pocion => pocion.mejorar(jugador)})
	
	}
	
	override method fondoDelNivel(){return "Runas.jpg"}
  	
  	override method agregarEventos(){
  		

		
		game.onTick(150,"movimientolanzarBolasDeFuego",{ mago.desplazarBolasDeFuego()})
  		
  		
		game.onTick(300,"magoAcciones",{mago.actuar()})
		game.onTick(1000,"ganarEnergiaJugador",{ jugador.ganarEnergia(1)})
		game.onTick(10000,"pociones",{ generadorDePociones.agregarPocion()})
	}
  	
  	override method removerEventos(){
		game.removeTickEvent("magoAcciones")
		game.removeTickEvent("ganarEnergiaJugador")
		game.removeTickEvent("pociones")
		game.removeTickEvent("movimientolanzarBolasDeFuego")
	}
  	
  	override method pasarAlsiguienteNivel(){
	 	mago.seDetiene()
    	game.removeVisual(mago)
	 	game.clear()
	 	
	 	game.schedule(1000, { game.stop() })
	}
  	
  	
  }
  
  
   





	

