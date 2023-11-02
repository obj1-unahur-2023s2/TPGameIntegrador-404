import wollok.game.*
import entidades.*
import indicadores.*
import obstaculos.*
import pantallas.*
import dificultades.*
import direcciones.*

object juego{
	
	const obstaculos = [
		new Arbol(position = game.at(8,10)), new Arbol(position = game.at(14,6)), new Arbol(position = game.at(6,5)), new Arbol(position = game.at(18,11))
	]
	
	
	const capsulasVida = []
	const capsulasEnergia = []
	
	const bordes = []
	
	method capsulas() = (capsulasVida + capsulasEnergia).any({ c => c.position() == goku.direccionHaciaLaQueMira().destino(goku) })
	
	method obstaculos() = obstaculos
	
	method bordes() = bordes
	
	method eliminarCapsulaVida(capsula){
		
		capsulasVida.remove(capsula)
	}
	method eliminarCapsulaEnergia(capsula){
		
		capsulasEnergia.remove(capsula)
	}
	
	method iniciar() {
		game.clear()
		game.height(16)
		game.width(22)
		game.title("The Legend Of SuperSaiyan")
		game.boardGround("assets/pantallas/mapaNamek.png")
		game.addVisual(inicioPantalla)
		keyboard.p().onPressDo{facil.configurar()}
		keyboard.o().onPressDo{dificil.configurar()}
		keyboard.i().onPressDo{pantallaReglas.mostrar()}
		
	}
	
	method agregarVisuales(){
		game.addVisual(goku)
		game.addVisual(freezer)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		game.addVisual(barraDeFuria)
		obstaculos.forEach({a => game.addVisual(a)})
		bordes.forEach({b => game.addVisual(b)})
		
	}
	
	method configurarTeclas() {
		keyboard.up().onPressDo{ goku.caminarArriba()}
		keyboard.down().onPressDo{ goku.caminarAbajo()}
		keyboard.left().onPressDo{ goku.caminarIzquierda()}
		keyboard.right().onPressDo{ goku.caminarDerecha()}
		keyboard.q().onPressDo{ goku.golpear() }
		keyboard.w().onPressDo{ goku.usarBolaDeEnergia() }
		keyboard.e().onPressDo{ goku.usarBengalaSolar() }
		keyboard.r().onPressDo{ goku.transformarse() }
	}
	
	method bordesDelMapa(){
		
		self.bordeSuperior()
		self.bordeIzquierdo()
		self.bordeDerecho()
		self.bordeInferior()
	}
	
	method bordeInferior(){
		(2..19).forEach({x => bordes.add(new Obstaculo(position = game.at(x , 2)))})
	}
	
	method bordeSuperior(){
		(2..19).forEach({x => bordes.add(new Obstaculo(position = game.at(x , 14)))})
	}
	
	method bordeIzquierdo(){
		(2..14).forEach({y => bordes.add(new Obstaculo(position = game.at(1 , y)))})
	}
	
	method bordeDerecho(){
		(2..14).forEach({y => bordes.add(new Obstaculo(position = game.at(20 , y)))})
	}
	
	method posicionAleatoria() = game.at( 2.randomUpTo(20), 3.randomUpTo(13) )


	method generarCapsulaVida(maxCapsula, posicion){
		
		if (capsulasVida.size() < maxCapsula) {
			const nuevaCapsula = new CapsulaVida(position = posicion)
			capsulasVida.add(nuevaCapsula)
			game.addVisual(nuevaCapsula)
			obstaculos.forEach({a => game.removeVisual(a)})
			obstaculos.forEach({a => game.addVisual(a)})
		}
	}
	method generarCapsulaEnergia(maxCapsula, posicion){
		
		if (capsulasEnergia.size() < maxCapsula) {
			const nuevaCapsula = new CapsulaEnergia(position = posicion)
			capsulasEnergia.add(nuevaCapsula)
			game.addVisual(nuevaCapsula)
			obstaculos.forEach({a => game.removeVisual(a)})
			obstaculos.forEach({a => game.addVisual(a)})
		}
	}
	method generarCapsulaVidaSiEstaVacio(maxCapsula){
		var posicion = new Position(x=2.randomUpTo(20),y=3.randomUpTo(13))
		if(game.getObjectsIn(posicion).isEmpty())
            self.generarCapsulaVida(maxCapsula, posicion)
        else
            self.generarCapsulaVidaSiEstaVacio(maxCapsula)
	}
	method generarCapsulaEnergiaSiEstaVacio(maxCapsula){
		var posicion = new Position(x=2.randomUpTo(20),y=3.randomUpTo(13))
		if(game.getObjectsIn(posicion).isEmpty())
            self.generarCapsulaEnergia(maxCapsula, posicion)
        else
            self.generarCapsulaEnergiaSiEstaVacio(maxCapsula)
	}
}

object pantallaVictoria
{
	method mostrar()
	{
		game.clear()
		game.height(16)
		game.width(22)
		game.addVisual(victoriaPantalla)
		keyboard.p().onPressDo{facil.configurar()}
		keyboard.o().onPressDo{juego.iniciar()}
	}
}
object pantallaDerrota
{
	method mostrar()
	{
		game.clear()
		game.height(16)
		game.width(22)
		game.addVisual(derrotaPantalla)
		keyboard.p().onPressDo{facil.configurar()}
		keyboard.o().onPressDo{juego.iniciar()}
	}
}
object pantallaReglas
{
	method mostrar()
	{
		game.clear()
		game.height(16)
		game.width(22)
		game.addVisual(reglasPantalla)
		keyboard.p().onPressDo{juego.iniciar()}
	}
}


