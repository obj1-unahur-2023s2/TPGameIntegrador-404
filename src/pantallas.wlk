import wollok.game.*
import juegoManager.*
class Pantalla
{
	var property image 
	var property position 
	
}
const inicioPantalla= new Pantalla(image = "assets/pantallas/inicio.png", position = game.origin())
const victoriaPantalla=new Pantalla(image = "assets/pantallas/victoria.png", position = game.origin())
const derrotaPantalla= new Pantalla(image = "assets/pantallas/gameOver.png", position = game.origin())
const reglasPantalla= new Pantalla(image = "assets/pantallas/instrucciones.png", position = game.origin())
const reglasPantallaVs= new Pantalla(image = "assets/pantallas/instruccionesVS.png", position = game.origin())
const victoriaJugador1= new Pantalla(image = "assets/pantallas/jugador1Win.png", position = game.origin())
const victoriaJugador2= new Pantalla(image = "assets/pantallas/jugador2Win.png", position = game.origin())



