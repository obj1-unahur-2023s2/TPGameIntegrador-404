import wollok.game.*

class Musica {
	
}

object musica{
	
	const musica=game.sound("assets/sonidos/menu.mp3")
	
	method iniciar(){
		musica.volume(0.1)
		musica.shouldLoop(true)
		game.schedule(500,{musica.play()})
	}	
}

object sonidoAReproducir{
	
	method iniciar(sonidos){
		const sonido = game.sound(sonidos)
		sonido.volume(0.5)
		sonido.play()
	}
}


