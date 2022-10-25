import wollok.game.*
import tpGame.*
import interacciones.*

//MAPAS CHIQUITOS
const mapaChiquito1 = new Seleccionar(presione = "Tecla j", position = game.at(2, 5), image = "mapaChiquito1.jpg")

const mapaChiquito2 = new Seleccionar(presione = "Tecla k", position = game.at(7, 5), image = "mapaChiquito2.jpg")

const mapaChiquito3 = new Seleccionar(presione = "Tecla l", position = game.at(12, 5), image = "mapaChiquito3.jpg")

//MAPAS
const mapa1 = new Mapa(position = game.origin(), image = "mapa1.jpg", interacciones = [ agujero1, agujero2, agujero5, agujero8, agujero6, saltoDoble1, saltoDoble3, portal1, portal2, vidaExtra1, vidaExtra3 ])

const mapa2 = new Mapa(position = game.origin(), image = "mapa2.jpg", interacciones = [ agujero1, agujero4, agujero5, agujero7, saltoDoble2, saltoDoble5, portal2, portal4, vidaExtra2 ])

const mapa3 = new Mapa(position = game.origin(), image = "mapa3.jpg", interacciones = [ agujero3, agujero5, agujero6, agujero8, agujero2, saltoDoble1, saltoDoble2, saltoDoble4, portal1, portal3, vidaExtra3 ])

