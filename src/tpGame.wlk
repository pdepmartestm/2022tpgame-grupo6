import wollok.game.*

object manchaMania {

	const agujeros = [ agujero1, agujero2, agujero3, agujero4, agujero5 ]
	const destinos = [ destino1, destino2 ]
	const personajes = [ amongUsRojo1, amongUsVerde1, amongUsCeleste1, amongUsArcoIris1, amongUsRojo2, amongUsVerde2, amongUsCeleste2, amongUsArcoIris2 ]
	const powerUps = [ saltoDoble1, saltoDoble2, portal1, portal2, vidaExtra1 ]
	const property jugadores = [ jugador1, jugador2 ]
	const property opciones = [ menuJugar, menuReglas, menuCreadores ]

	method menu() {
		game.title("Mancha Mania")
		game.boardGround("pantallaInicio.jpg")
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
		keyboard.alt().onPressDo({ self.jugar()})
	}

	method elegirPersonajes() {
		game.addVisual(aspectos)
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
	}

	method jugar() {
		opciones.forEach({ o => game.removeVisual(o)})
		game.removeVisual(aspectos)
		personajes.forEach({ p => game.removeVisual(p)}) // para evitar interacciones, sacamos todo lo que no se utiliza mas
		game.addVisual(mapa)
		game.addVisual(jugador1)
		game.addVisual(jugador2)
		
		game.schedule(5000,{=>self.aparecer()})
		
		//powerUps.forEach({ p => game.onCollideDo(p, { jugador => p.afectar(jugador)})}) //hacer q las interacciones funciones siempre igual con el mismo metodo
		//agujeros.forEach({ a => game.onCollideDo(a, { jugador => jugador.caerse()})})
		keyboard.up().onPressDo({ jugador1.aArriba()})
		keyboard.down().onPressDo({ jugador1.aAbajo()})
		keyboard.right().onPressDo({ jugador1.aLaDerecha()})
		keyboard.left().onPressDo({ jugador1.aLaIzquierda()})
		keyboard.w().onPressDo({ jugador2.aArriba()})
		keyboard.s().onPressDo({ jugador2.aAbajo()})
		keyboard.d().onPressDo({ jugador2.aLaDerecha()})
		keyboard.a().onPressDo({ jugador2.aLaIzquierda()})
		//game.onCollideDo(jugador2, { jugador1 => jugador2.atrapar(jugador1)}) // revisar esta parte
	}
	
	method aparecer(){
		agujeros.forEach({ a => game.addVisual(a)})
		powerUps.forEach({ p => game.addVisual(p)})
		destinos.forEach({ d => game.addVisual(d)})
		
		
		jugadores.forEach({j=> game.onCollideDo(j,{algo => algo.afectar(j)})})
	}

	method fin() {
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

object fondo {

	const property position = game.origin()
	const property image = "fondo.jpg"

}

object aspectos {

	const property position = game.origin()
	const property image = "personajes.png"

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

const finalizarJuego = new Opcion(presione = "Tecla control", position = game.at(5, 5), image = "finalizarJuego.png")

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
	
	method afectar(jugador){
		jugador.caerse()
	}

}

const agujero1 = new Obstaculo(position = game.at(4, 3), image = "agujero.png")

const agujero2 = new Obstaculo(position = game.at(7, 9), image = "agujero.png")

const agujero3 = new Obstaculo(position = game.at(2, 8), image = "agujero.png")

const agujero4 = new Obstaculo(position = game.at(8, 1), image = "agujero.png")

const agujero5 = new Obstaculo(position = game.at(5, 5), image = "agujero.png")

const agujero6 = new Obstaculo(position = game.at(10, 7), image = "agujero.png")

class Jugador {

	var property vida
	var property position
	var property image = ""
	var property turno
	const property otroJugador
	var property salto
	const respawn

	method imagenJugador(personaje) {
		image = personaje.image()
		game.removeVisual(personaje)
		manchaMania.quitarDeLista(personaje) // para evitar que colisione con otros obejtos
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

	method perder(premio) {
		game.removeVisual(self)
		otroJugador.ganar(premio)
		game.schedule(5000, {=> manchaMania.fin()})
	}

	method ganar(premio) {
		game.addVisualCharacterIn(premio, self.position())
	}

	method moverseA(destino) {
		position = destino.position()
	}

	method caerse() {
		if (vida == 1) {
			self.perder(copa)
		} else {
			self.moverseA(respawn)
			vida -= 1
		}
	}

	method sumarseVida() {
		vida += 1
	}

}

object jugador1 inherits Jugador(vida = 1, position = game.origin(), turno = 1, otroJugador = jugador2, salto = 1, respawn = respawnJ1) {

	var property movimientos = 0 // de esta manera sabemos cuantas veces se movio


	method afectar(jugador){
		jugador.afectar(self)
	}
	
	override method sumarTurno() {
		super()
		movimientos += 1
		if (movimientos == 50) {
			self.sobrevivir()
			game.say(self, "50 MOVIMIENTOS!")
		}
	}

	method sobrevivir() {
		otroJugador.perder(copa)
	}

}

object jugador2 inherits Jugador(vida = 1, position = game.at(14, 11), turno = 0, otroJugador = jugador1, salto = 1, respawn = respawnJ2) {

	method afectar(jugador) {
		jugador.perder(cadaver)
	}

}

object cadaver {

	const property image = "cadaver.png" // estaria bueno que cada color tenga su cadaver, pero no encontre imagenes png de todos

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
		game.removeVisual(self)
	}

}

const saltoDoble1 = new SaltoDoble(position = game.at(10, 4), image = "saltoDoble.png")

const saltoDoble2 = new SaltoDoble(position = game.at(1, 9), image = "saltoDoble.png")

class Portal {

	const property position
	const property image
	const property destino

	method afectar(jugador) {
		jugador.moverseA(destino)
	}

}

const portal1 = new Portal(position = game.at(1, 3), image = "portal.png", destino = destino1)

const portal2 = new Portal(position = game.at(9, 8), image = "portal.png", destino = destino2)

class Destino {

	const property position
	const property image

}

const destino1 = new Destino(position = game.at(7, 12), image = "destino.png")

const destino2 = new Destino(position = game.at(11, 10), image = "destino.png")

class VidaExtra {

	const property position
	const property image

	method afectar(jugador) {
		jugador.sumarseVida()
		game.removeVisual(self)
	}

}

const vidaExtra1 = new VidaExtra(position = game.at(9, 7), image = "corazon.png")

class Respawn {

	const property position = game.at(1, 11)

}

const respawnJ1 = new Respawn(position = game.origin())

const respawnJ2 = new Respawn(position = game.at(14, 11))
