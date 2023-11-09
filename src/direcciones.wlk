import habilidades.*
import wollok.game.*
import entidades.*
import animaciones.*

object frente {
	
	method miraHacia() = "Frente"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		if (not game.getObjectsIn(self.destino(entidad)).isEmpty()){
			game.getObjectsIn(self.destino(entidad)).first().recibirAtaque(entidad.danio())	
		}
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseFrente()})
	}
	
	method destino(entidad) = entidad.position().down(1)

}

object atras {
	
	method miraHacia() = "Atras"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		if (not game.getObjectsIn(self.destino(entidad)).isEmpty()){
			game.getObjectsIn(self.destino(entidad)).first().recibirAtaque(entidad.danio())	
		}
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseAtras()})
	}
	
	method destino(entidad) = entidad.position().up(1)
}

object derecha {
	
	method miraHacia() = "Derecha"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		if (not game.getObjectsIn(self.destino(entidad)).isEmpty()){
			game.getObjectsIn(self.destino(entidad)).first().recibirAtaque(entidad.danio())	
		}
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseDerecha()})	
	}
	
	method destino(entidad) = entidad.position().right(1)
}

object izquierda {
	
	method miraHacia() = "Izquierda"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		if (not game.getObjectsIn(self.destino(entidad)).isEmpty()){
			game.getObjectsIn(self.destino(entidad)).first().recibirAtaque(entidad.danio())	
		}
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseIzquierda()})
	}
	
	method destino(entidad) = entidad.position().left(1)

}