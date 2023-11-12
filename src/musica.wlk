import wollok.game.*

object musica{
	
	method iniciar(){
		const musica=game.sound("assets/sonidos/musicaPeleaSagaFreezer.mp3")
		musica.volume(0)
		musica.shouldLoop(true)
		game.schedule(500,{musica.play()})
	}
	
}