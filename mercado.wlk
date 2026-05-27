import wollok.game.*
import almacen.*


class Mercado {
    var property position
    const mercaderia = []
    var property oro

    method image() = "market.png"

    method comprarCosecha() {
        oro -= almacen.valorDeCosecha()
        mercaderia.addAll(almacen.cultivosCosechados())
    }

}

object mercado {
    method agregarMercadoEn_Con_Oro(positionDada, oroDado) {
        const nuevoMercado = new Mercado(position = positionDada, oro = oroDado)
		game.addVisual(nuevoMercado)
    }
}