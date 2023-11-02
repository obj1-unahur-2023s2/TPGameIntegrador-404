import entidades.*
import wollok.game.*
import juegoManager.*
import direcciones.*

object facil
{
	method configurar()
	{
		game.clear()
		game.height(16)
		game.width(22)
		juego.bordesDelMapa()
		juego.agregarVisuales()
		juego.configurarTeclas()
		game.onTick(10000, "GenerarCapsulas", { juego.generarCapsulaVidaSiEstaVacio(3) })
		game.onTick(7000, "GenerarCapsulas", { juego.generarCapsulaEnergiaSiEstaVacio(3) })
		configuracion.configurarEnemigo(10,500, 400, 800)
		configuracion.configurarPosicionesIniciales()
	}
}
object dificil
{
	method configurar()
	{
		game.clear()
		game.height(16)
		game.width(22)
		juego.bordesDelMapa()
		juego.agregarVisuales()
		juego.configurarTeclas()
		game.onTick(15000, "GenerarCapsulas", { juego.generarCapsulaVidaSiEstaVacio(2) })
		game.onTick(7500, "GenerarCapsulas", { juego.generarCapsulaEnergiaSiEstaVacio(2) })
		configuracion.configurarEnemigo(25,1000, 600, 1000)
		configuracion.configurarPosicionesIniciales()
	}
}

object configuracion{
	
	method configurarEnemigo(danio, vida, vMovimiento, vDanio){
		freezer.danio(danio)
		freezer.vida(vida)
		freezer.velocidadDeMovimiento(vMovimiento)
		freezer.velocidadDeAtaque(vDanio)
	}
	
	method configurarPosicionesIniciales(){
		goku.position(game.at(10,10))
		goku.accion("")
		goku.direccionHaciaLaQueMira(frente)
		freezer.position(game.at(10,5))
		freezer.accion("")
		freezer.direccionHaciaLaQueMira(atras)
	}
}



