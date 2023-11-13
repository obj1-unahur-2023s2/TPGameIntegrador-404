import wollok.game.*
import juegoManager.*
class Pantalla
{
	var property image 
	var property position 
	
}
const inicioPantalla= new Pantalla(image = "assets/pantallas/Inicio.png", position = game.origin())
const victoriaPantalla=new Pantalla(image = "assets/pantallas/Victoria.png", position = game.origin())
const derrotaPantalla= new Pantalla(image = "assets/pantallas/GameOver.png", position = game.origin())
const reglasPantalla= new Pantalla(image = "assets/pantallas/Instrucciones.png", position = game.origin())
const reglasPantallaVs= new Pantalla(image = "assets/pantallas/InstruccionesVS.png", position = game.origin())
const victoriaJugador1= new Pantalla(image = "assets/pantallas/Jugador1Win.png", position = game.origin())
const victoriaJugador2= new Pantalla(image = "assets/pantallas/Jugador2Win.png", position = game.origin())



