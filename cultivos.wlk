import wollok.game.*
import personaje.*
import almacen.*


class Maiz {
	var property position
	var crecimientoActual = maizBebe
	const crecimientoMaximo = maizAdulto
	var property precioDeVenta = 150

	method image() = crecimientoActual.image()


	//REGAR
	method serRegado() {
		if (crecimientoActual != crecimientoMaximo) {
			crecimientoActual = crecimientoActual.crecer()
		}
	}


	//COSECHA
	method serCosechado() {
		self.validarCosecha()
		almacen.almacenarCosecha(self)
		game.removeVisual(self)
	}

	method validarCosecha() {
		if (crecimientoActual != crecimientoMaximo) {
			self.error("este maiz no esta listo para ser cosechado")
		}
	}
}

object maizBebe {
	method image() = "corn_baby.png"

	method crecer() = maizAdulto
}

object maizAdulto {
	method image() ="corn_adult.png"
}


class Trigo {
	var property position
	var property crecimientoActual = 0
	const crecimientoMaximo = 3

	method image() = "wheat_" + crecimientoActual.toString() + ".png"


	//REGAR
	method serRegado() {
		if (crecimientoActual == crecimientoMaximo) {
			crecimientoActual = 0
		} else crecimientoActual += 1
	}


	//COSECHAR
	method serCosechado() {
		self.validarCosecha()
		almacen.almacenarCosecha(self)
		game.removeVisual(self)
	}

	method validarCosecha() {
		if (crecimientoActual < 2) {
			self.error("este trigo no esta listo para ser cosechado")
		}
	}


	//VENTA
	method precioDeVenta() = (crecimientoActual - 1) * 100
}

class Tomaco {
	var property position
	var property precioDeVenta = 80

	method image() = "tomaco_baby.png"


	//REGAR
	method serRegado() {
		self.validarRiego()
		position = self.moverTomacoArriba()
	}
	
	method validarRiego() {
		if (not self.esParcelaLibre()){
			self.error("no se puede regar este tomaco")
		}
	}

	method esParcelaLibre() = game.getObjectsIn(self.moverTomacoArriba()).isEmpty()
	
	method moverTomacoArriba() {
		return if (self.esElBorde()) game.at(position.x(), 0) else position.up(1)
	} //si esta al borde de arriba, va al borde de abajo del tablero
	
	method esElBorde() = position.y() == game.height() - 1


	//COSECHA
	method serCosechado() {
		almacen.almacenarCosecha(self)
		game.removeVisual(self)
	}
}

//INSTANCIAS
object maiz {
	method serSembrado(granjero) {
		const nuevoMaiz = new Maiz(position = granjero.position())
		game.addVisual(nuevoMaiz)
	}
}

object trigo {
	method serSembrado(granjero) {
		const nuevoTrigo = new Trigo(position = granjero.position())
		game.addVisual(nuevoTrigo)
	}
}

object tomaco {
	method serSembrado(granjero) {
		const nuevoTomaco = new Tomaco(position = granjero.position())
		game.addVisual(nuevoTomaco)
	}
}