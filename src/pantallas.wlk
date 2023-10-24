import wollok.game.*
import juegoManager.*
class Pantalla
{
	var property image 
	var property position 
	
}
object inicio inherits Pantalla(image = "assets/Victoria.png", position = game.at(0,0))
{}