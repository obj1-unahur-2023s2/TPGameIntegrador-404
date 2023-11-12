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
		configuracion.configurarJugador(25)
		configuracion.configurarEstadoInicial()
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
		configuracion.configurarJugador(20)
		configuracion.configurarEstadoInicial()
	}
}
object unoVsUno {
	method configurar(){
		game.clear()
		game.height(16)
		game.width(22)
		juego.bordesDelMapa()
		juego.agregarVisualesParaUnoVsUno()
		juego.configurarTeclasParaUnoVsUno()
		game.onTick(15000, "GenerarCapsulas", { juego.generarCapsulaVidaSiEstaVacio(2) })
		game.onTick(7500, "GenerarCapsulas", { juego.generarCapsulaEnergiaSiEstaVacio(2) })
		configuracion.configurarJugadorParaUnoVsUno(5)
		configuracion.configurarEstadoInicial()
	}
}

object configuracion{
	
	method configurarEnemigo(danio, vida, vMovimiento, vDanio){
		freezer.danio(danio)
		freezer.vida(vida)
		freezer.velocidadDeMovimiento(vMovimiento)
		freezer.velocidadDeAtaque(vDanio)
	}
	method configurarJugadorParaUnoVsUno(danio){
		self.configurarJugador(danio)
		freezer.danio(10)
		freezer.vida(1000)
		
	}
	method configurarJugador(danio){
		goku.danio(danio)
		goku.estaTransformado(false)
		goku.vida(100)
		goku.furia(0)
		goku.energia(100)
		game.onCollideDo(goku,{algo => algo.serAgarrado(goku)})
	}
	
	method configurarEstadoInicial(){
		
		goku.position(game.at(10,10))
		goku.accion("")
		goku.direccionHaciaLaQueMira(frente)
		freezer.position(game.at(10,5))
		freezer.accion("")
		freezer.direccionHaciaLaQueMira(atras)
	}
}



