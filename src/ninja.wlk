import wollok.game.*
import configuraciones.*
import shuriken.*
import niveles.*

//agregar imagen de ninja muerto 

object ninja{
	var  property  vida     = 100
    var  property  position = game.center()
    
    const shuriken1 = new Shuriken( direccion = izquierda)
    const shuriken2 = new Shuriken( direccion = abajo	 )
    const shuriken3 = new Shuriken( direccion = derecha	 )
     
    const property shurikens =[shuriken1,shuriken2,shuriken3] 

	
	method image(){ return "ninja.png"}
	method estaMuerto(){ return vida <= 0}	
	
	method esUnShuriken(elemento){return shurikens.contains(elemento)}
			
	
	method seMueve(){
		const x = (coordenadas.x().anyOne()).truncate(0) 
		const y = (coordenadas.y().anyOne()).truncate(0) 
		
			position = game.at(x,y)	
	}
	
	method seDetiene(){
		game.say(self,"he sido derrotado")  //sacar mensaje
		self.removerShurikens()
		nivel1.removerEventos()
	}
	
	method lanzarShurikens(){
		shurikens.forEach{shuriken => shuriken.aparecer()}
	}
	
	method desplazarShurikens(){
		shurikens.forEach{shuriken => shuriken.moverse()}
	}
	
 	method removerShurikens(){
 		shurikens.forEach{shuriken => shuriken.desaparecer()}
 	}
	
//se podrá llamar recibirDanio(cant)? 		
	method tomarPuntosDeDanio(cant){
		vida -= cant
		if(self.estaMuerto()){
			self.seDetiene()
		} 	
	}
	
	
}
	

