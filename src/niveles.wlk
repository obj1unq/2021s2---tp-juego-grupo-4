import wollok.game.*
import configuraciones.*
import jugador.*
import ninja.*
import shuriken.*

//+--------------------------------------------------------------------------------------------------+
//|                                 NIVEL 1                                                          |
//+--------------------------------------------------------------------------------------------------+
object nivel1 {
	
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
	jugador.enemigosNivel(#{ninja})  
	
	self.agregarEventos()
	
	game.onCollideDo(jugador, {elemento => if (ninja.esUnShuriken(elemento)){elemento.daniar(jugador)}})
	}
	
	
	method agregarEventos(){
 		if (not self.nivelGanado()){
			game.onTick(2000,"movimientoNinja",{ninja.seMueve()})
			game.onTick(6000,"lanzarShurikens",{ninja.lanzarShurikens()})	
			game.onTick(500,"movimientoShurikens",{ ninja.desplazarShurikens()})
 		}
	}
	
	method removerEventos(){
		game.removeTickEvent("movimientoNinja")
		game.removeTickEvent("lanzarShurikens")
		game.removeTickEvent("movimientoShurikens")
	}
	
	method finalizar(){
	}
	
}
	
	

