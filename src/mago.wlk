import wollok.game.*
import configuraciones.*
import niveles.*
import jugador.*


object mago inherits Enemigo{
	var   vida      = 80
	var   manaUsado = 0     
    var  property  position         = game.at(3,6)
    var  property dirrecionACaminar = izquierda
	var  property hechizosEnUso     = []
	
	method image() = "mago.png" 
	
	override method seDetiene(){
		game.say(self,"he sido derrotado")  //sacar mensaje
		self.removerBolasDeFuego()
		nivel3.removerEventos()
	}
	
	override method estaMuerto(){
		return vida == 0
	}
	
	override method tomarPuntosDeDanio(poderGolpe){
    	vida = 0.max(vida - poderGolpe)
    	game.say(self,"Vida Mago: " + vida)
    	if(not self.estaMuerto()){
    	   musica.activarSonido("Tp.mp3") 
	       jugador.position(game.at(jugador.position().x(),0) )  
    	}else{ 
    	  nivel3.terminarNivelSiCorresponde()
    	}		  
    }
    
   method actuar(){
	  if(not jugador.estaMuerto()){
	  	self.atacar()
		self.seMueve()
		}
	}
    
    override method seMueve(){
		if(self.puedoMover(dirrecionACaminar)){
			position = self.dirrecionACaminar().siguiente(position)
		}else{ dirrecionACaminar = dirrecionACaminar.opuesto() }
	}	
	
	method puedoMover(dir){
		return coordenadas.posicionValida(self.dirrecionACaminar().siguiente(position)) 
	}
	
		
	method puedoAtacar(){
		return manaUsado >= 0
	}
	
	method 	atacar(){
	  self.castearHechizo()
	   manaUsado += 1
	}
	
	
	method castearHechizo(){
		if(manaUsado == 4){ manaUsado = -2}
		else  self.usarHechizo()
	 }
	 
	method usarHechizo(){
	  if(self.puedoAtacar()){	
		const spell = new BolaDeFuego (position = abajo.siguiente(self.position()))
		spell.aparecer()
		hechizosEnUso.add(spell)
	   }
	}
	 
	 method lanzarBolasDeFuego(){
		hechizosEnUso.forEach{spell => spell.aparecer()}
	}
	
	method desplazarBolasDeFuego(){
		hechizosEnUso.forEach{spell => spell.moverse()}
	}
	
 	method removerBolasDeFuego(){
 		hechizosEnUso.forEach{spell => spell.desaparecer()}
 	}
	 
	
}


class BolaDeFuego inherits ObjetoEnPantalla{
	
	var property position
	var casillaRestantes = 7
	
	method image() = "BolaDeFuego.png" 
	
	method aparecer(){
		musica.activarSonido("BolaDeFuego.mp3") // sonidito de bola de fuego  
		position =  abajo.siguiente(mago.position())
		if (not game.hasVisual(self)){
			game.addVisual(self)}
	}
	
	override method daniar(objeto){
		objeto.recibirDanio(40)
		self.desaparecer()
	}	
	
	method desaparecer(){
		if (game.hasVisual(self)){
			mago.hechizosEnUso().remove(self)
			game.removeVisual(self)
		}
	}
	
	method moverse(){
		position = abajo.siguiente(position)
		casillaRestantes -= 1 
		self.desaparecerSiCorresponde()
	}
	
	method desaparecerSiCorresponde(){
		if(casillaRestantes <= 0){self.desaparecer()}
	}
}

