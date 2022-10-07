import wollok.game.*

object manchaMania {

	const agujeros = [ agujero1, agujero2, agujero3, agujero4, agujero5 ]
	const personajesj1 = [ amongUsRojo1, amongUsVerde1, amongUsCeleste1, amongUsArcoIris1 ]
	const personajesj2 = [ amongUsRojo2, amongUsVerde2, amongUsCeleste2, amongUsArcoIris2 ]
	const powerUps = [ saltoDoble1, saltoDoble2 ]
	const property jugadores = [ jugador1, jugador2 ]

	method menu() {
		game.title("Mancha Mania")
		game.boardGround("pantallaInicio.jpg")
		game.height(13)
		game.width(18)
		game.addVisual(bot)
		game.addVisual(menuJugar)
		game.addVisual(menuReglas)
		game.addVisual(menuCreadores)
		game.say(bot, "Seleccione una Opcion, presione DEL para volver")
		game.showAttributes(menuJugar)
		game.showAttributes(menuReglas)
		game.showAttributes(menuCreadores)
		game.showAttributes(bot)
		keyboard.space().onPressDo({ self.elegirPersonajes()})
		keyboard.enter().onPressDo({ self.mostrarReglas()})
		keyboard.shift().onPressDo({ self.mostrarCreadores()})
		keyboard.alt().onPressDo({ self.jugar()})
	}

	method elegirPersonajes() {
		game.addVisual(fondo)
		personajesj1.forEach({ p => game.addVisual(p)})
		personajesj1.forEach({ p => game.showAttributes(p)})
		personajesj2.forEach({ p => game.addVisual(p)})
		personajesj2.forEach({ p => game.showAttributes(p)})
		keyboard.num1().onPressDo({ jugador1.imagenJugador(amongUsRojo1.image())})
		keyboard.num1().onPressDo({ game.removeVisual(amongUsRojo1)})
		keyboard.num2().onPressDo({ jugador1.imagenJugador(amongUsVerde1.image())})
		keyboard.num2().onPressDo({ game.removeVisual(amongUsVerde1)})
		keyboard.num3().onPressDo({ jugador1.imagenJugador(amongUsCeleste1.image())})
		keyboard.num3().onPressDo({ game.removeVisual(amongUsCeleste1)})
		keyboard.num4().onPressDo({ jugador1.imagenJugador(amongUsArcoIris1.image())})
		keyboard.num4().onPressDo({ game.removeVisual(amongUsArcoIris1)})
		keyboard.num5().onPressDo({ jugador2.imagenJugador(amongUsRojo2.image())})
		keyboard.num5().onPressDo({ game.removeVisual(amongUsRojo2)})
		keyboard.num6().onPressDo({ jugador2.imagenJugador(amongUsVerde2.image())})
		keyboard.num6().onPressDo({ game.removeVisual(amongUsVerde2)})
		keyboard.num7().onPressDo({ jugador2.imagenJugador(amongUsCeleste2.image())})
		keyboard.num7().onPressDo({ game.removeVisual(amongUsCeleste2)})
		keyboard.num8().onPressDo({ jugador2.imagenJugador(amongUsArcoIris2.image())})
		keyboard.num8().onPressDo({ game.removeVisual(amongUsArcoIris2)})
	}

	method jugar() {
		game.addVisual(mapa)
		game.addVisual(jugador1)
		game.addVisual(jugador2)
		agujeros.forEach({ a => game.addVisual(a)})
		powerUps.forEach({ p => game.addVisual(p)})
			// game.schedule(10000,{=>game.addVisual(saltoDoble1)})
			// game.schedule(20000,{=>game.addVisual(saltoDoble2)})
		powerUps.forEach({ p => game.onCollideDo(p, { jugador1 => p.afectar(jugador1)})})
		powerUps.forEach({ p => game.onCollideDo(p, { jugador2 => p.afectar(jugador2)})})
		powerUps.forEach({ p => game.onCollideDo(p, { jugador1 => game.removeVisual(p)})})
		powerUps.forEach({ p => game.onCollideDo(p, { jugador2 => game.removeVisual(p)})})
		agujeros.forEach({ a => game.onCollideDo(a, { jugador1 => jugador1.perder()})})
		agujeros.forEach({ a => game.onCollideDo(a, { jugador1 => jugador2.perder()})})
		keyboard.up().onPressDo({ jugador1.aArriba()})
		keyboard.down().onPressDo({ jugador1.aAbajo()})
		keyboard.right().onPressDo({ jugador1.aLaDerecha()})
		keyboard.left().onPressDo({ jugador1.aLaIzquierda()})
		keyboard.w().onPressDo({ jugador2.aArriba()})
		keyboard.s().onPressDo({ jugador2.aAbajo()})
		keyboard.d().onPressDo({ jugador2.aLaDerecha()})
		keyboard.a().onPressDo({ jugador2.aLaIzquierda()})
	// game.onCollideDo(jugador1, { jugador2 => jugador2.ganar(trofeoJ2)})
	}

	method mostrarReglas() {
		game.addVisual(infoReglas)
		keyboard.del().onPressDo({ game.removeVisual(infoReglas)})
	}

	method mostrarCreadores() {
		game.addVisual(infoCreadores)
		keyboard.del().onPressDo({ game.removeVisual(infoCreadores)})
	}

}

object fondo {

	const property position = game.origin()
	const property image = "fondo.jpg"

}

object bot {

	const property position = game.at(1, 7)
	const property image = "bot.png"

}

class Opcion {

	const property presione
	const property position
	const property image

}

const menuJugar = new Opcion(presione = "Tecla Space", position = game.at(4, 8), image = "jugar.jpg")

const menuReglas = new Opcion(presione = "Tecla Enter", position = game.at(4, 5), image = "reglas.jpg")

const menuCreadores = new Opcion(presione = "Tecla Shift", position = game.at(4, 2), image = "creadores.jpg")

object mapa {

	const property position = game.origin()
	const property image = "mapa.jpg"

}

class Informacion {

	const property position
	const property image

}

const infoReglas = new Informacion(position = game.at(-1, 0), image = "infoReglas.jpg")

const infoCreadores = new Informacion(position = game.origin(), image = "infoCreadores.jpg")

class Obstaculo {

	const property position
	const property image

}

const agujero1 = new Obstaculo(position = game.at(4, 3), image = "agujero.png")

const agujero2 = new Obstaculo(position = game.at(7, 9), image = "agujero.png")

const agujero3 = new Obstaculo(position = game.at(2, 8), image = "agujero.png")

const agujero4 = new Obstaculo(position = game.at(8, 1), image = "agujero.png")

const agujero5 = new Obstaculo(position = game.at(5, 5), image = "agujero.png")

const agujero6 = new Obstaculo(position = game.at(10, 7), image = "agujero.png")

class Jugador {

	var property position
	var property image = ""
	var property turno
	const property otroJugador
	var property salto

	method imagenJugador(imagen) {
		image = imagen
	}

	method aArriba() {
		if (turno > 0) {
			position = position.up(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
	}

	method aLaDerecha() {
		if (turno > 0) {
			position = position.right(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
	}

	method aLaIzquierda() {
		if (turno > 0) {
			position = position.left(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
	}

	method aAbajo() {
		if (turno > 0) {
			position = position.down(1)
			turno = turno - 1
			otroJugador.sumarTurno()
		}
	}

	method sumarTurno() {
		if (otroJugador.turno() == 0) {
			turno += salto
		}
	}

	method dobleTurno() {
		salto *= 2 // por alguna razon se mueve 4 veces en lugar de 2
	}

	method perder() {
		game.addVisualCharacterIn(copa, otroJugador.position())
		game.removeVisual(self)
	}

}

object jugador1 inherits Jugador(position = game.origin(), turno = 1, otroJugador = jugador2, salto = 1) {

	var property movimientos = 0 // de esta manera sabemos cuantas veces se movio

	override method sumarTurno() {
		super()
		movimientos += 1
		if (movimientos == 50) {
			self.sobrevivir()
			game.say(self, "50 MOVIMIENTOS!")
		}
	}

	method sobrevivir() {
		game.addVisualCharacterIn(copa, self.position())
		game.removeVisual(otroJugador)
	}

}

object jugador2 inherits Jugador(position = game.at(14, 11), turno = 0, otroJugador = jugador1, salto = 1) {

	method atrapar() {
		game.onCollideDo(self, { jugador1 => game.removeVisual(jugador1)})
		game.addVisualCharacterIn(cadaver, self.position())
	}

}

object cadaver {

	const property image = "cadaverCeleste.png" // estaria bueno que cada color tenga su cadaver, pero no encontre imagenes png de todos

}

object copa {

	const property image = "trofeo.png"

}

class Personaje {

	const property tecla
	const property position
	const property image

}

const amongUsRojo1 = new Personaje(tecla = 1, position = game.at(5, 7), image = "amongUsRojo.png")

const amongUsVerde1 = new Personaje(tecla = 2, position = game.at(7, 7), image = "amongUsVerde.png")

const amongUsCeleste1 = new Personaje(tecla = 3, position = game.at(9, 7), image = "amongUsCeleste.png")

const amongUsArcoIris1 = new Personaje(tecla = 4, position = game.at(11, 7), image = "amongUsArcoIris.png")

const amongUsRojo2 = new Personaje(tecla = 5, position = game.at(5, 4), image = "amongUsRojo.png")

const amongUsVerde2 = new Personaje(tecla = 6, position = game.at(7, 4), image = "amongUsVerde.png")

const amongUsCeleste2 = new Personaje(tecla = 7, position = game.at(9, 4), image = "amongUsCeleste.png")

const amongUsArcoIris2 = new Personaje(tecla = 8, position = game.at(11, 4), image = "amongUsArcoIris.png")

class SaltoDoble {

	const property position
	const property image

	method afectar(jugador) {
		jugador.dobleTurno()
	}

}

const saltoDoble1 = new SaltoDoble(position = game.at(10, 4), image = "saltoDoble.png")

const saltoDoble2 = new SaltoDoble(position = game.at(1, 9), image = "saltoDoble.png")

//POWER UP QUE CAMBIE QUIEN PERSIGUE Y QUIEN ATRAPA?
