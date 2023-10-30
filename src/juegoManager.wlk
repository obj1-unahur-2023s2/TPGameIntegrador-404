import wollok.game.*
import entidades.*
import indicadores.*
import obstaculos.*
import pantallas.*

object juego{
	
	const obstaculos = [
		new Arbol(position = game.at(10,10)), new Arbol(position = game.at(14,6)), new Arbol(position = game.at(6,5)), new Arbol(position = game.at(18,11))
	]
	
	
	const capsulasVida = []
	const capsulasEnergia = []
	
	const bordes = []
	
	method obstaculos() = obstaculos
	
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
		game.boardGround("assets/mapaNamek.png")
		game.addVisual(inicio)
		keyboard.p().onPressDo{self.configurarFacil()}
		keyboard.o().onPressDo{self.configurarDificil()} //cambiar a objetos
		
	}
	method configurarFacil()
	{
		game.clear()
		
		self.bordesDelMapa()
		self.agregarVisuales()
		self.configurarTeclas()
		freezer.velocidadDeMovimiento(600)
		freezer.velocidadDeAtaque(1000)
		game.onTick(15000, "GenerarCapsulas", { self.generarCapsulaVidaSiEstaVacio(2) })
		game.onTick(7500, "GenerarCapsulas", { self.generarCapsulaEnergiaSiEstaVacio(3) })
		self.configurarEnemigo(10,100)
	}
	method configurarDificil()
	{
		game.clear()
		
		
		self.bordesDelMapa()
		self.agregarVisuales()
		self.configurarTeclas()
		
		freezer.velocidadDeMovimiento(400)
		freezer.velocidadDeAtaque(700)
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


	method generarCapsulaVida(maxCapsula){
		
		if (capsulasVida.size() < maxCapsula) {
			const nuevaCapsula = new CapsulaVida(position = self.posicionAleatoria())
			game.addVisual(nuevaCapsula)
			capsulasVida.add(nuevaCapsula)
			obstaculos.forEach({a => game.removeVisual(a)})
			obstaculos.forEach({a => game.addVisual(a)})
		}
	}
	method generarCapsulaEnergia(maxCapsula){
		
		if (capsulasEnergia.size() < maxCapsula) {
			const nuevaCapsula = new CapsulaEnergia(position = self.posicionAleatoria())
			game.addVisual(nuevaCapsula)
			capsulasEnergia.add(nuevaCapsula)
			obstaculos.forEach({a => game.removeVisual(a)})
			obstaculos.forEach({a => game.addVisual(a)})
		}
	}
	method generarCapsulaVidaSiEstaVacio(maxCapsula){
		var posicion = new Position(x=2.randomUpTo(20),y=3.randomUpTo(13))
		if(game.getObjectsIn(posicion).isEmpty())
            self.generarCapsulaVida(maxCapsula)
        else
            self.generarCapsulaVidaSiEstaVacio(maxCapsula)
	}
	method generarCapsulaEnergiaSiEstaVacio(maxCapsula){
		var posicion = new Position(x=2.randomUpTo(20),y=3.randomUpTo(13))
		if(game.getObjectsIn(posicion).isEmpty())
            self.generarCapsulaEnergia(maxCapsula)
        else
            self.generarCapsulaEnergiaSiEstaVacio(maxCapsula)
	}
	
	method configurarEnemigo(danio, vida){
		freezer.danio(danio)
		freezer.vida(vida)
	}
}




