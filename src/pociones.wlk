import configuraciones.*
import randomizer.*
import wollok.game.*

//Las pociones mejoran determinados aspectos del jugador en la cantidad que diga la constante cantidad de aumento
//Rojo=vida
//Verde= energia
//Azul == poder o ataque

class Pocion inherits ObjetoEnPantalla {
	
	const property position 
	const property cantidadDeAumento = 3
	
	method caracteristica()
	method mejorar(jugador)

	method image() = "pocion_" + self.caracteristica() + ".png"
	
	
}


class Vida inherits Pocion{
	override method caracteristica(){
		return "vida"
	}
	
	override method mejorar(jugador){
		jugador.AumentarVidaYDesaparecer(self)
	}
}

class Energia inherits Pocion{
	override method caracteristica(){
		return "energia"
	}
	override method mejorar(jugador){
		jugador.AumentarEnergiaYDesaparecer(self)
	}
}


class Ataque inherits Pocion{
	override method caracteristica(){
		return "ataque"
	}
	override method mejorar(jugador){
		jugador.AumentarAtaqueYDesaparecer(self)
	}
}


object generadorDePociones{
	
	var pociones = #{}
	const max = 4
	
	method agregarPocion(){
		if (self.faltanPociones()){
		const pocion = self.generarPocion()
		game.addVisual(pocion)
		pociones.add(pocion)
		}
	}
	
	method faltanPociones(){
		return pociones.size()< max
	}
	
	method remover(pocion){
		pociones.remove(pocion)
		if (game.hasVisual(pocion)){
			game.removeVisual(pocion)
		}
	}
	
	method generarPocion(){
		if((0..2).anyOne() ==  0 ){
			return new Vida(position = randomizer.position())
		}
		if((0..2).anyOne() ==  1 ){
			return new Energia(position = randomizer.position())
		}
		else{
			return new Ataque(position = randomizer.position())
		}
		
		
		
	}
}