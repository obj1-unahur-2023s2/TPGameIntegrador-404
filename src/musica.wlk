import wollok.game.*

object musica{
	
	const musica=game.sound("assets/sonidos/menu.mp3")
	
	method iniciar(){
		musica.volume(0.1)
		musica.shouldLoop(true)
		game.schedule(500,{musica.play()})
	}	
}

object sonidoGolpe{
	
	method iniciar(){
		const sonido = game.sound("assets/sonidos/golpe.wav")
		sonido.volume(0.5)
		sonido.play()
	}
}

object sonidoBengalaSolar{
	
	method iniciar(){
		const sonido = game.sound("assets/sonidos/bengalaSolar.wav")
		sonido.volume(0.3)
		sonido.play()
	}
}

object sonidoTransformacion{
	
	method iniciar(){
		const sonido = game.sound("assets/sonidos/transformacion.wav")
		sonido.volume(0.5)
		sonido.play()
	}
}

object sonidoKame{
	
	method iniciar(){
		const sonido = game.sound("assets/sonidos/kame.wav")
		sonido.volume(0.3)
		sonido.play()
	}
}