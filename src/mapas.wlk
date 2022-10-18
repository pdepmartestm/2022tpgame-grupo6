import wollok.game.*
import tpGame.*
import interacciones.*

//MAPAS CHIQUITOS
const mapaChiquito1 = new Seleccionar(presione = "Tecla j", position = game.at(2, 5), image = "mapaChiquito1.jpg")

const mapaChiquito2 = new Seleccionar(presione = "Tecla k", position = game.at(7, 5), image = "mapaChiquito2.jpg")

const mapaChiquito3 = new Seleccionar(presione = "Tecla l", position = game.at(12, 5), image = "mapaChiquito3.jpg")

//MAPAS
const mapa1 = new Mapa(position = game.origin(), image = "mapa1.jpg", agujeros = [ agujero1, agujero2, agujero4, agujero8, agujero6 ], saltosDobles = [ saltoDoble1, saltoDoble3 ], portales = [ portal1, destino1, portal2, destino2 ], vidasExtra = [ vidaExtra1, vidaExtra3 ])

const mapa2 = new Mapa(position = game.origin(), image = "mapa2.jpg", agujeros = [ agujero1, agujero4, agujero3, agujero7 ], saltosDobles = [ saltoDoble2, saltoDoble5 ], portales = [ portal2, destino2, portal4, destino4 ], vidasExtra = [ vidaExtra2 ])

const mapa3 = new Mapa(position = game.origin(), image = "mapa3.jpg", agujeros = [ agujero3, agujero5, agujero6, agujero8, agujero2 ], saltosDobles = [ saltoDoble1, saltoDoble2, saltoDoble4 ], portales = [ portal1, portal3, destino1, destino3 ], vidasExtra = [ vidaExtra3 ])


