object almacen {
    const cultivosCosechados   = []

    //COSECHA
    method cultivosCosechados() = cultivosCosechados

    method almacenarCosecha(cultivo) {
        cultivosCosechados.add(cultivo)
    }

    //VENTA
    method valorDeCosecha() = cultivosCosechados.sum({c => c.precioDeVenta()})

    method venderCosecha() {
        cultivosCosechados.clear()
    }

    method tamañoCosecha() = cultivosCosechados.size()
}