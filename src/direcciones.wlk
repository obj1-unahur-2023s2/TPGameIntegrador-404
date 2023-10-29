import habilidades.*
import wollok.game.*
import entidades.*
import animaciones.*

object frente {
	
	method miraHacia() = "Frente"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		entidad.realizarAtaque()
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseFrente()})
	}
	
	method jugadorHacerDanioHaciaLaDireccionQueMira(entidad,cant){
		
		if (not game.getObjectsIn(entidad.position().down(1)).isEmpty()){
            game.getObjectsIn(entidad.position().down(1)).first().recibirAtaque(cant)

        }
	}
	
	method enemigoHacerDanioHaciaLaDireccionQueMira(entidad, cant){
		
		if (entidad.position().down(1) == goku.position() and entidad.puedeMoverse() ){
			game.getObjectsIn(entidad.position().down(1)).first().recibirAtaque(cant)
			animaciones.golpear(entidad)
		}
	}
}

object atras {
	
	method miraHacia() = "Atras"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		entidad.realizarAtaque()
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseAtras()})
	}
	
	method jugadorHacerDanioHaciaLaDireccionQueMira(entidad,cant){
		
		if (not game.getObjectsIn(entidad.position().up(1)).isEmpty()){
            game.getObjectsIn(entidad.position().up(1)).first().recibirAtaque(cant)

        }
	}
	
	method enemigoHacerDanioHaciaLaDireccionQueMira(entidad, cant){
		
		if (entidad.position().up(1) == goku.position() and entidad.puedeMoverse() ){
			game.getObjectsIn(entidad.position().up(1)).first().recibirAtaque(cant)
			animaciones.golpear(entidad)
		}
	}
}

object derecha {
	
	method miraHacia() = "Derecha"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		entidad.realizarAtaque()
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseDerecha()})	
	}
	
	method jugadorHacerDanioHaciaLaDireccionQueMira(entidad,cant){
		
		if (not game.getObjectsIn(entidad.position().right(1)).isEmpty()){
            game.getObjectsIn(entidad.position().right(1)).first().recibirAtaque(cant)

        }
	}
	
	method enemigoHacerDanioHaciaLaDireccionQueMira(entidad, cant){
		
		if (entidad.position().right(1) == goku.position() and entidad.puedeMoverse() ){
			game.getObjectsIn(entidad.position().right(1)).first().recibirAtaque(cant)
			animaciones.golpear(entidad)
		}
	}
}

object izquierda {
	
	method miraHacia() = "Izquierda"
	
	method atacarHaciaLaDireccionQueMira(entidad){
		
		entidad.realizarAtaque()
	}
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseIzquierda()})
	}
	
	method jugadorHacerDanioHaciaLaDireccionQueMira(entidad,cant){
		
		if (not game.getObjectsIn(entidad.position().left(1)).isEmpty()){
            game.getObjectsIn(entidad.position().left(1)).first().recibirAtaque(cant)

        }
	}
	
	method enemigoHacerDanioHaciaLaDireccionQueMira(entidad, cant){
		
		if (entidad.position().left(1) == goku.position() and entidad.puedeMoverse() ){
			game.getObjectsIn(entidad.position().left(1)).first().recibirAtaque(cant)
			animaciones.golpear(entidad)
		}
	}
}