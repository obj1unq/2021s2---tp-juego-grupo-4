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
	method image() = "pocion_" + self.caracteristica() + ".png"
	
	method caracteristica()
	method mejorar(jugador)
	override method tomarPuntosDeDanio(poderGolpe){
		generadorDePociones.remover(self)
		game.sound("destruir power up.mp3").play()
	}

	
	
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

object vidaFactory{
	method nuevaPocion(){
		return new Vida(position = randomizer.position())
	}
}

object energiaFactory{
	method nuevaPocion(){
		return new Energia(position = randomizer.position())
	}
}

object poderFactory{
	method nuevaPocion(){
		return new Ataque(position = randomizer.position())
	}
}

object generadorDePociones{
	
	var pociones = #{}
	const max = 2
	const factories= [vidaFactory, energiaFactory, poderFactory]
	
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
		const factory = factories.get((0..2).anyOne())
		game.sound("aparece power up.mp3").play()
		return factory.nuevaPocion()
	
	}
}