import wollok.game.*
import tpGame.*

//AGUJEROS
const agujero1 = new Agujeros(position = game.at(4, 3), image = "agujero.png")

const agujero2 = new Agujeros(position = game.at(7, 9), image = "agujero.png")

const agujero3 = new Agujeros(position = game.at(2, 8), image = "agujero.png")

const agujero4 = new Agujeros(position = game.at(15, 1), image = "agujero.png")

const agujero5 = new Agujeros(position = game.at(5, 10), image = "agujero.png")

const agujero6 = new Agujeros(position = game.at(10, 7), image = "agujero.png")

const agujero7 = new Agujeros(position = game.at(11, 9), image = "agujero.png")

const agujero8 = new Agujeros(position = game.at(13, 6), image = "agujero.png")

// SALTOS DOBLES
const saltoDoble1 = new SaltoDoble(position = game.at(10, 4), image = "saltoDoble.png")

const saltoDoble2 = new SaltoDoble(position = game.at(5, 8), image = "saltoDoble.png")

const saltoDoble3 = new SaltoDoble(position = game.at(15, 9), image = "saltoDoble.png")

const saltoDoble4 = new SaltoDoble(position = game.at(3, 6), image = "saltoDoble.png")

const saltoDoble5 = new SaltoDoble(position = game.at(7, 9), image = "saltoDoble.png")

//PORTALES
const portal1 = new Portal(position = game.at(1, 3), image = "portal.png", destino = destino1)

const portal2 = new Portal(position = game.at(15, 8), image = "portal.png", destino = destino2)

const portal3 = new Portal(position = game.at(4, 10), image = "portal.png", destino = destino3)

const portal4 = new Portal(position = game.at(8, 2), image = "portal.png", destino = destino4)

//DESTINOS
const destino1 = new Destino(position = game.at(7, 10), image = "destino.png")

const destino2 = new Destino(position = game.at(2, 6), image = "destino.png")

const destino3 = new Destino(position = game.at(10, 2), image = "destino.png")

const destino4 = new Destino(position = game.at(2, 9), image = "destino.png")

//VIDAS EXTRA
const vidaExtra1 = new VidaExtra(position = game.at(13, 7), image = "corazon.png")

const vidaExtra2 = new VidaExtra(position = game.at(8, 4), image = "corazon.png")

const vidaExtra3 = new VidaExtra(position = game.at(3, 11), image = "corazon.png")

//RESPAWNS
const respawnJ1 = new Respawn(position = game.origin())

const respawnJ2 = new Respawn(position = game.at(14, 11))

