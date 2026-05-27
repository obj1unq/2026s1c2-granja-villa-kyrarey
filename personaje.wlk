// personaje.wlk
import wollok.game.*
import almacen.*

object personaje {
	var property position = game.center()
	const property image = "fplayer.png"
	var property oro = 0


	// SEMBRAR
	method sembrar(cultivo) {
		self.validarParcelaParaSembrar()
		cultivo.serSembrado(self)
	}
	
	method validarParcelaParaSembrar() {
		if (not (self.esParcelaLibre())) {
			self.error("no se puede cultivar en esta parcela")
		}
	}

	method esParcelaLibre() = game.colliders(self).isEmpty()
	//usar colliders!!!


	// REGAR
	method regar() {
		self.validarParcelaParaRiego()
		game.uniqueCollider(self).serRegado()
		//retorna el objeto con el que colisiono
	}

	method validarParcelaParaRiego(){
		if (self.esParcelaLibre()) {  //??? verificar si hay cultivo
			self.error("no tengo nada para regar")
		}
	}

	//COSECHA
	method cosechar() {
		self.validarParcelaParaCosecha()
		game.uniqueCollider(self).serCosechado()
	}

	method validarParcelaParaCosecha(){
		if (self.esParcelaLibre()) {  //??? verificar si hay cultivo
			self.error("no hay nada para cosechar")
		}
	}


	//VENTA
	method vender() {
		self.validarSiHayMercadoConOroSuficiente()
		game.uniqueCollider(self).comprarCosecha()
		oro += almacen.valorDeCosecha()
		almacen.venderCosecha()
	}

	method decirCantDeOroYPlantasParaVender() {
		game.say(self, "tengo " + oro.toString() + " monedas y " + almacen.tamañoCosecha() + " plantas para vender")
	}

	method validarSiHayMercadoConOroSuficiente() {
		if (not self.hayMercado() and not self.tieneElMercadoOroSuficiente()) {
			self.error("no hay un mercado válido acá")
		}
	}

	method hayMercado() = not self.esParcelaLibre() //and ??
	//como verifico si lo que hay es un cultivo o un mercado?

	method tieneElMercadoOroSuficiente() = game.uniqueCollider(self).oro() >= oro



	//MOVIMIENTO (para tests)
	method moverIzq(cantParcelas) {
		position = game.at(0.max(position.x() - cantParcelas), position.y())
	}

	method moverDer(cantParcelas) {
		position = game.at((game.width() - 1).min(position.x() + cantParcelas), position.y())
	}
	
	method moverAr(cantParcelas) {
		position = game.at(position.x(), (game.height() - 1).min(position.y() + cantParcelas))
	}
	
	method moverAb(cantParcelas) {
		position = game.at(position.x(), 0.max(position.y() - cantParcelas))
	}
}