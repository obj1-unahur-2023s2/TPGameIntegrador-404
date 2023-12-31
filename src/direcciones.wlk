import habilidades.*
import wollok.game.*
import entidades.*
import animaciones.*

object frente {
	
	method miraHacia() = "frente"
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseFrente()})
	}
	
	method destino(entidad) = entidad.position().down(1)
	
	method esquivarObstaculo(){
    	if( freezer.hayUnObstaculoEnLaDireccionHaciaLaQueMira()){
			freezer.caminarIzquierda()
			game.schedule(200,{freezer.caminarAbajo()})	
		}
    }
}

object atras {
	
	method miraHacia() = "atras"
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseAtras()})
	}
	
	method destino(entidad) = entidad.position().up(1)
	
	method esquivarObstaculo(){
    	if( freezer.hayUnObstaculoEnLaDireccionHaciaLaQueMira()){
    		freezer.caminarDerecha()
			game.schedule(200,{freezer.caminarArriba()})	
		}
    }
}

object derecha {
	
	method miraHacia() = "derecha"
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseDerecha()})	
	}
	
	method destino(entidad) = entidad.position().right(1)
	
	method esquivarObstaculo(){
    	if(freezer.hayUnObstaculoEnLaDireccionHaciaLaQueMira()){
			freezer.caminarAbajo()
		}
    }
}

object izquierda {
	
	method miraHacia() = "izquierda"
	
	method desplazamiento(bolaDeEnergia){
		
		game.onTick(250, "movimientoBola", {bolaDeEnergia.moverseIzquierda()})
	}
	
	method destino(entidad) = entidad.position().left(1)
	
	method esquivarObstaculo(){
    	if(freezer.hayUnObstaculoEnLaDireccionHaciaLaQueMira() ){
			freezer.caminarArriba()
		}
    }

}