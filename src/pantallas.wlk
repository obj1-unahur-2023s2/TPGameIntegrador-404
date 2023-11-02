import wollok.game.*
import juegoManager.*
class Pantalla
{
	var property image 
	var property position 
	
}
object inicioPantalla inherits Pantalla(image = "assets/pantallas/Inicio.png", position = game.origin()){}
object victoriaPantalla inherits Pantalla(image = "assets/pantallas/Victoria.png", position = game.origin()){}
object derrotaPantalla inherits Pantalla(image = "assets/pantallas/GameOver.png", position = game.origin()){}
object reglasPantalla inherits Pantalla(image = "assets/pantallas/Instrucciones.png", position = game.origin()){}