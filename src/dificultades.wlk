import entidades.*
import wollok.game.*
import juegoManager.*
import direcciones.*
import pantallas.*
import indicadores.*
import musica.*


class Dificultad{
	
	method configurar(){
		game.clear()
		game.height(16)
		game.width(22)
		juego.bordesDelMapa()
	}
	
	method pantallaVictoria(){
		game.clear()
		game.height(16)
		game.width(22)
		game.addVisual(victoriaPantalla)
		keyboard.o().onPressDo{juego.dificultad().configurar()}
		keyboard.p().onPressDo{juego.iniciar()}
	}
	
	method pantallaDerrota(){
		game.clear()
		game.height(16)
		game.width(22)
		game.addVisual(derrotaPantalla)
		keyboard.o().onPressDo{juego.dificultad().configurar()}
		keyboard.p().onPressDo{juego.iniciar()}	
	}
}

object facil inherits Dificultad
{
	override method configurar()
	{	
		super()
		juego.agregarVisuales()
		juego.configurarTeclas()
		game.onTick(10000, "GenerarCapsulas", { juego.generarCapsulaVidaSiEstaVacio(3) })
		game.onTick(7000, "GenerarCapsulas", { juego.generarCapsulaEnergiaSiEstaVacio(3) })
		configuracion.configurarEnemigo(10,500, 600, 1000)
		configuracion.configurarJugador(25,100)
		configuracion.configurarEstadoInicial()
		self.agregarVisualesIndicadores()
	}
	
	method agregarVisualesIndicadores(){
		const barraDeVida = new BarraDeVida(position = game.at(0,15), usuario = goku, division = 10)
		const barraDeEnergia = new BarraDeEnergia(position = game.at(2,15), usuario = goku)
		const barraDeVidaEnemigo = new BarraDeVida(position = game.at(19,15), usuario = freezer, division = 50)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		game.addVisual(barraDeFuria)
		game.addVisual(barraDeVidaEnemigo)
	}
	
	method maximoVida() = 100
}
object dificil inherits Dificultad
{
	override method configurar()
	{
		super()
		juego.agregarVisuales()
		juego.configurarTeclas()
		game.onTick(15000, "GenerarCapsulas", { juego.generarCapsulaVidaSiEstaVacio(2) })
		game.onTick(7500, "GenerarCapsulas", { juego.generarCapsulaEnergiaSiEstaVacio(2) })
		configuracion.configurarEnemigo(20,1000, 400, 800)
		configuracion.configurarJugador(20,100)
		configuracion.configurarEstadoInicial()
		self.agregarVisualesIndicadores()
	}
	
	method agregarVisualesIndicadores(){
		const barraDeVida = new BarraDeVida(position = game.at(0,15), usuario = goku, division = 10)
		const barraDeEnergia = new BarraDeEnergia(position = game.at(2,15), usuario = goku)
		const barraDeVidaEnemigo = new BarraDeVida(position = game.at(19,15), usuario = freezer, division = 100)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		game.addVisual(barraDeFuria)
		game.addVisual(barraDeVidaEnemigo)
	}
	
	method maximoVida() = 100
}
object unoVsUno inherits Dificultad{
	
	override method configurar(){
		super()
		juego.agregarVisualesParaUnoVsUno()
		juego.configurarTeclasParaUnoVsUno()
		game.onTick(9000, "GenerarCapsulas", { juego.generarCapsulaVidaSiEstaVacio(3) })
		game.onTick(5000, "GenerarCapsulas", { juego.generarCapsulaEnergiaSiEstaVacio(3) })
		configuracion.configurarJugadorParaUnoVsUno()
		configuracion.configurarEstadoInicial()
		self.agregarVisualesIndicadores()
	}
	
	override method pantallaVictoria(){
		game.clear()
		game.height(16)
		game.width(22)
		game.addVisual(victoriaJugador1)
		keyboard.o().onPressDo{juego.dificultad().configurar()}
		keyboard.p().onPressDo{juego.iniciar()}
	}
	
	override method pantallaDerrota(){
		game.clear()
		game.height(16)
		game.width(22)
		game.addVisual(victoriaJugador2)
		keyboard.o().onPressDo{juego.dificultad().configurar()}
		keyboard.p().onPressDo{juego.iniciar()}	
	}
	
	method agregarVisualesIndicadores(){
		const barraDeVida = new BarraDeVida(position = game.at(0,15), usuario = goku, division = 50)
		const barraDeEnergia = new BarraDeEnergia(position = game.at(2,15), usuario = goku)
		const barraDeVidaEnemigo = new BarraDeVida(position = game.at(19,15), usuario = freezer, division = 50)
		const barraDeEnergiaEnemigo = new BarraDeEnergia(position = game.at(16,15), usuario = freezer)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		game.addVisual(barraDeFuria)
		game.addVisual(barraDeVidaEnemigo)
		game.addVisual(barraDeEnergiaEnemigo)
	}
	
	method maximoVida() = 500
}

object configuracion{
	
	method configurarEnemigo(danio, vida, vMovimiento, vDanio){
		freezer.danio(danio)
		freezer.vida(vida)
		freezer.velocidadDeMovimiento(vMovimiento)
		freezer.velocidadDeAtaque(vDanio)
	}
	method configurarJugadorParaUnoVsUno(){
		self.configurarJugador(10,500)
		freezer.danio(15)
		freezer.vida(500)
		freezer.energia(100)
		game.onCollideDo(freezer,{algo => algo.serAgarrado(freezer)})
		
	}
	method configurarJugador(danio,vida){
		goku.danio(danio)
		goku.estaTransformado(false)
		goku.vida(vida)
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



