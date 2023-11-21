import entidades.*
import wollok.game.*
import juegoManager.*
import direcciones.*
import pantallas.*
import indicadores.*
import musica.*

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
	
	method agregarVisualesIndicadores()
	
	method maximoVida() = 100
}
class ParametrosDificultad inherits Dificultad{
		const edanio
		const evida
		const eVMovimiento
		const eVDanio
		const danio
		const vida
		const tiempoOnTick
		const capsula
		const divBarEnemy
		
	override method configurar(){
		
		game.clear()
		game.height(16)
		game.width(22)
		juego.bordesDelMapa()
		juego.agregarVisuales()
		juego.configurarTeclas()
		game.onTick((tiempoOnTick + (tiempoOnTick/2)), "GenerarCapsulas", { juego.generarCapsulaVidaSiEstaVacio(capsula) })
		game.onTick(tiempoOnTick , "GenerarCapsulas", { juego.generarCapsulaEnergiaSiEstaVacio(capsula) })
		configuracion.configurarEnemigo(edanio,evida,eVMovimiento,eVDanio)
		configuracion.configurarJugador(danio,vida)
		configuracion.configurarEstadoInicial()
		self.agregarVisualesIndicadores()
	}
	override method agregarVisualesIndicadores(){
		const barraDeVida = new BarraDeVida(position = game.at(0,15), usuario = goku, division = 10)
		const barraDeEnergia = new BarraDeEnergia(position = game.at(2,15), usuario = goku)
		const barraDeVidaEnemigo = new BarraDeVida(position = game.at(19,15), usuario = freezer, division = divBarEnemy)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		game.addVisual(barraDeFuria)
		game.addVisual(barraDeVidaEnemigo)
	}	
}
//DECLARACION DE LOS NIVELES CON DIFERENTES PARAMETROS PARA HACERLO MAS DIFICIL O MAS FACIL!
const facil= new ParametrosDificultad(edanio = 10, evida = 500, eVMovimiento = 600, eVDanio = 1000, danio = 25, vida = 100,
										   tiempoOnTick = 10000 , capsula = 2,divBarEnemy=50)

const dificil=new ParametrosDificultad(edanio = 20, evida = 1000, eVMovimiento = 400, eVDanio = 800, danio = 20, vida = 100,
	 tiempoOnTick = 15000, capsula = 1,divBarEnemy=100)



object unoVsUno inherits Dificultad{
	
	override method configurar(){
		super()
		juego.agregarVisuales()
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
	override method agregarVisualesIndicadores(){
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
	override method maximoVida() = 500
}





