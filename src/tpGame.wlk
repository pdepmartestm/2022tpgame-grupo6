import wollok.game.*
import imagenes.*
import interacciones.*
import botones.*
import mapas.*
import corazones.*

object manchaMania {

	const personajes = [ amongUsRojo1, amongUsVerde1, amongUsCeleste1, amongUsArcoIris1, amongUsRojo2, amongUsVerde2, amongUsCeleste2, amongUsArcoIris2 ]
	const property jugadores = [ jugador1, jugador2 ]
	const property opciones = [ menuJugar, menuReglas, menuCreadores ]
	var interaccionesIncluidas = false // para ver si todas las interacciones se agregaron

	method menu() {
		game.title("Mancha Mania")
		game.boardGround("fondo.jpg")
		game.height(13)
		game.width(18)
		game.addVisual(bot)
		opciones.forEach({ o => game.addVisual(o)})
		game.say(bot, "Seleccione una Opcion, presione DEL para volver")
		opciones.forEach({ o => game.showAttributes(o)})
		game.showAttributes(bot)
		keyboard.space().onPressDo({ self.elegirPersonajes()})
		keyboard.enter().onPressDo({ self.mostrarReglas()})
		keyboard.shift().onPressDo({ self.mostrarCreadores()})
	}

	method elegirPersonajes() {
		game.addVisual(aspectos)
		game.say(bot, "Elijan sus aspectos")
		personajes.forEach({ p => game.addVisual(p)})
		personajes.forEach({ p => game.showAttributes(p)})
		keyboard.num1().onPressDo({ jugador1.imagenJugador(amongUsRojo1)})
		keyboard.num2().onPressDo({ jugador1.imagenJugador(amongUsVerde1)})
		keyboard.num3().onPressDo({ jugador1.imagenJugador(amongUsCeleste1)})
		keyboard.num4().onPressDo({ jugador1.imagenJugador(amongUsArcoIris1)})
		keyboard.num5().onPressDo({ jugador2.imagenJugador(amongUsRojo2)})
		keyboard.num6().onPressDo({ jugador2.imagenJugador(amongUsVerde2)})
		keyboard.num7().onPressDo({ jugador2.imagenJugador(amongUsCeleste2)})
		keyboard.num8().onPressDo({ jugador2.imagenJugador(amongUsArcoIris2)})
		keyboard.alt().onPressDo({ self.elegirMapa()})
		keyboard.del().onPressDo({ game.removeVisual(aspectos)})
		keyboard.del().onPressDo({ personajes.forEach({ p => game.removeVisual(p)})})
	}

	method jugar() {
		game.onCollideDo(jugador1, { algo => algo.afectar(jugador1)})
		game.onCollideDo(jugador2, { algo => algo.afectar(jugador2)})
		keyboard.up().onPressDo({ jugador1.aArriba()})
		keyboard.down().onPressDo({ jugador1.aAbajo()})
		keyboard.right().onPressDo({ jugador1.aLaDerecha()})
		keyboard.left().onPressDo({ jugador1.aLaIzquierda()})
		keyboard.w().onPressDo({ jugador2.aArriba()})
		keyboard.s().onPressDo({ jugador2.aAbajo()})
		keyboard.d().onPressDo({ jugador2.aLaDerecha()})
		keyboard.a().onPressDo({ jugador2.aLaIzquierda()})
	}

	method elegirMapa() {
		game.say(bot, "Elijan un mapa")
		opciones.forEach({ o => game.removeVisual(o)})
		game.removeVisual(aspectos)
		personajes.forEach({ p => game.removeVisual(p)}) // para evitar interacciones, sacamos todo lo que no se utiliza mas
		game.addVisual(mapaChiquito1)
		game.addVisual(mapaChiquito2)
		game.addVisual(mapaChiquito3)
		game.showAttributes(mapaChiquito1)
		game.showAttributes(mapaChiquito2)
		game.showAttributes(mapaChiquito3)
		keyboard.j().onPressDo({ self.mapa(mapa1)})
		keyboard.k().onPressDo({ self.mapa(mapa2)})
		keyboard.l().onPressDo({ self.mapa(mapa3)})
	}

	method mapa(mapaX) {
		game.removeVisual(bot)
		game.removeVisual(mapaChiquito1)
		game.removeVisual(mapaChiquito2)
		game.removeVisual(mapaChiquito3)
		game.addVisual(mapaX)
		mapaX.crearse()
		game.addVisual(jugador1)
		game.addVisual(jugador2)
		game.addVisual(corazonJ11)
		game.addVisual(corazonJ21)
		self.jugar()
	}

	method agregarInteraccion(colecciones) {
		game.schedule(1000, {=> self.agregarUnVisual(colecciones)})
	}

	method agregarUnVisual(colecciones) {
		game.onTick(2000, "agregar interaccion", {=> self.agregarElementoRandom(colecciones)})
	}

	method agregarElementoRandom(colecciones) {
		var interaccion = colecciones.anyOne()
		interaccion.aparecer(colecciones)
		if (colecciones.isEmpty()) {
			game.removeTickEvent("agregar interaccion")
			interaccionesIncluidas = true
		}
	}

	method fin() {
		if (!interaccionesIncluidas) game.removeTickEvent("agregar interaccion")
		game.addVisual(fondo)
		game.addVisual(finalizarJuego)
		game.showAttributes(finalizarJuego)
		keyboard.control().onPressDo({ game.stop()})
	}

	method mostrarReglas() {
		game.addVisual(infoReglas)
		keyboard.del().onPressDo({ game.removeVisual(infoReglas)})
	}

	method mostrarCreadores() {
		game.addVisual(infoCreadores)
		keyboard.del().onPressDo({ game.removeVisual(infoCreadores)})
	}

	method quitarDeLista(personaje) {
		personajes.remove(personaje)
	}

}

//IMAGENES
class Imagen {

	const property position
	const property image

	method afectar(jugador) {
	} // de esta manera estas imagenes no tiran mensaje de error al colisionar

}

//SELECCIONAR OPCION
class Seleccionar {

	const property presione
	const property position
	const property image

}

//MOVIMIENTOS
class Limites {

	const limiteArriba = 12
	const limiteAbajo = -1
	const limiteDerecha = 17
	const limiteIzquierda = -1

}

//JUGADORES
class Jugador inherits Limites {

	var property vida
	var property position
	var property image = ""
	var property turno
	const property otroJugador
	var property salto
	const respawn
	var property posicionPosible = position
	var property corazones

	method noPuedoMoverme() {
		game.say(self, "No puedo moverme :(")
	}

	method dentroDeLimites() {
		return self.posicionPosible().x() < limiteDerecha && self.posicionPosible().y() < limiteArriba && self.posicionPosible().x() > limiteIzquierda && self.posicionPosible().y() > limiteAbajo
	}

	method imagenJugador(personaje) {
		image = personaje.image()
		game.removeVisual(personaje)
		manchaMania.quitarDeLista(personaje) // para evitar que colisione con otros obejtos
	}

	method aArriba() {
		posicionPosible = position.up(1)
		if (self.mePuedoMover()) {
			self.moverse()
		} else {
			self.noPuedoMoverme()
		}
	}

	method aLaDerecha() {
		posicionPosible = position.right(1)
		if (self.mePuedoMover()) {
			self.moverse()
		} else {
			self.noPuedoMoverme()
		}
	}

	method aLaIzquierda() {
		posicionPosible = position.left(1)
		if (self.mePuedoMover()) {
			self.moverse()
		} else {
			self.noPuedoMoverme()
		}
	}

	method aAbajo() {
		posicionPosible = position.down(1)
		if (self.mePuedoMover()) {
			self.moverse()
		} else {
			self.noPuedoMoverme()
		}
	}

	method mePuedoMover() {
		return turno > 0 && self.dentroDeLimites()
	}

	method moverse() {
		position = posicionPosible
		turno = turno - 1
		otroJugador.sumarTurno()
	}

	method sumarTurno() {
		if (otroJugador.turno() == 0) {
			turno += salto
		}
	}

	method dobleTurno() {
		salto *= 2 // por alguna razon se mueve 4 veces en lugar de 2
	}

	method perder(premio) {
		game.removeVisual(self)
		otroJugador.ganar(premio)
		game.schedule(7000, {=> manchaMania.fin()})
	}

	method ganar(premio) {
		game.addVisualCharacterIn(premio, self.position())
	}

	method moverseA(destino) {
		position = destino.position()
	}

	method caerse() {
		self.quitarCorazon()
		if (!self.murio()) self.moverseA(respawn)
	}

	method murio() {
		return vida == 0
	}

	method quitarCorazon() {
		vida -= 1
		game.removeVisual(corazones.get(vida))
		if (vida == 0) {
			self.perder(copa)
		}
	}

	method sumarseVida() {
		vida += 1
		game.addVisual(corazones.get(vida - 1))
	}

}

object jugador1 inherits Jugador(vida = 1, position = game.origin(), turno = 1, otroJugador = jugador2, salto = 1, respawn = respawnJ1, corazones = [ corazonJ11, corazonJ12, corazonJ13 ]) {

	method afectar(jugador) {
		jugador.perder(cadaver)
		game.say(self, "te atrape!")
	}

	override method ganar(premio) {
		super(premio)
		game.addVisual(p1Wins)
	}

}

object jugador2 inherits Jugador(vida = 1, position = game.at(14, 11), turno = 0, otroJugador = jugador1, salto = 1, respawn = respawnJ2, corazones = [ corazonJ21, corazonJ22, corazonJ23 ]) {

	var property movimientos = 0 // de esta manera sabemos cuantas veces se movio

	method afectar(jugador) {
	}

	override method moverse() {
		super()
		movimientos += 1
		self.multiploDeDiez()
		if (movimientos == 50) {
			otroJugador.perder(copa)
			game.say(self, "AL FIN 50 MOVIMIENTOS!")
		}
	}

	method multiploDeDiez() {
		if (movimientos % 10 == 0) game.say(self, movimientos.toString()) // solo avisa cuando se mueve 10 veces
	}

	override method ganar(premio) {
		super(premio)
		game.addVisual(p2Wins)
	}

}

//CORAZONES
class Corazon {

	const property position
	const property image

	method afectar(jugador) { // de esta manera si colisionan no tira error
	}

}

//PREMIOS
object cadaver {

	const property image = "cadaver.png" // estaria bueno que cada color tenga su cadaver, pero no encontre imagenes png de todos

	method afectar(jugador) { // de esta manera cuando aparece al final, no salta el mensaje de error
	}

}

object copa {

	const property image = "trofeo.png"

	method afectar(jugador) { // de esta manera cuando aparece al final, no salta el mensaje de error
	}

}

//MAPAS
class Mapa {

	const property position
	const property image
	const property interacciones

	method afectar(jugador) { // para evitar un mensaje de error
	}

	method crearse() {
		manchaMania.agregarInteraccion(interacciones)
	}

}

//INTERACCIONES
class Aparicion {

	method aparecer(colecciones) {
		game.addVisual(self)
		colecciones.remove(self)
	}

}

class Agujeros inherits Aparicion {

	const property position
	const property image

	method afectar(jugador) {
		jugador.caerse()
	}

}

class SaltoDoble inherits Aparicion {

	const property position
	const property image

	method afectar(jugador) {
		jugador.dobleTurno()
		game.say(jugador, "Doble Salto")
		game.removeVisual(self)
	}

}

class Portal inherits Aparicion {

	const property position
	const property image
	const property destino

	method afectar(jugador) {
		jugador.moverseA(destino)
	}

	override method aparecer(colecciones) {
		super(colecciones)
		destino.aparecer(colecciones)
	}

}

class Destino inherits Aparicion {

	const property position
	const property image

	method afectar(jugador) { // para evitar que salte un mensaje al pasar por encima consultar si esta bien dejarlo asi
		game.say(self, "Yo soy la salida")
	}

}

class VidaExtra inherits Aparicion {

	const property position
	const property image

	method afectar(jugador) {
		jugador.sumarseVida()
		game.say(jugador, "Vida Extra")
		game.removeVisual(self)
	}

}

class Respawn {

	const property position = game.at(1, 11)

}

