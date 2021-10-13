import wollok.game.*
import configuraciones.*
import jugador.*
import ninja.*
import shuriken.*


object nivel1 {
	
//	method pasaDeNivel(){
//		return ninja.estaMuerto()
//	}


	method iniciar(){
//	game.boardGround(image)
	game.addVisual(jugador)
	game.addVisual(ninja)
	game.addVisual(areaDeAtaque)
	game.addVisual(cartel)
	
	config.configurarTeclas()
	game.showAttributes(jugador)
	
	game.onTick(2000,"movimientoNinja",{ninja.seMueve()})
	game.onTick(6000,"lanzarShurikens",{ninja.lanzarShurikens()})
	game.onTick(500,"movimientoShurikens",{ self.moverShurikens()}
	)
					   						
 	game.whenCollideDo(jugador, {elemento => if (ninja.shurikens().contains(elemento)){
 													elemento.daniar(jugador)}}
 					   )	
}
	
	method moverShurikens(){
		ninja.shurikens().forEach({shuriken => shuriken.moverse()})	
	}
	
}
