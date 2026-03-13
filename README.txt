# tres-monos-platformer

**Juego de plataformas "El Juego de los Tres Monos"**
Proyecto libre: código, imágenes y música totalmente gratuitos y modificables.

---

## Autor

Este juego ha sido desarrollado por **Mario G.**
Si deseas usar este proyecto con fines comerciales o distribuirlo de manera paga, por favor contacta a: **[mariogp.tic@gmail.com](mailto:mariogp.tic@gmail.com)**.

---

## Licencia

El juego es gratuito para **uso personal y educativo**, siempre que se **reconozca la autoría**.

* Se permite copiar, modificar y redistribuir, **siempre dando crédito al autor**.
* Para usos comerciales o cualquier proyecto de pago, **contactar al autor antes de implementarlo**.

> Para reforzar estas condiciones, también se incluye un archivo `EULA.md` en el repositorio.

---

## Estructura de Ficheros

* **`graficos/`** – Contiene gráficos y sprites del juego.

```javascript
load_fpg("graficos/graficos.fpg");
```

* **`sonidos/`** – Archivos de audio:

  * `sonidomonoboton.wav` → Botón presionado
  * `sonidomonosalir.wav` → Salir de juego/sección
  * `sonidomonosalto.wav` → Salto del personaje
  * `sonidomonogolpepalmera.wav` → Golpear palmera
  * `sonidomonocoge1.wav` y `sonidomonocoge2.wav` → Recoger objetos
  * `sonidosalpicaagua.wav` → Salpicar agua
  * `sonidoaguilaatacando.wav` → Águila atacando
  * `sonidomonochange.wav` → Cambio de estado/mode
  * `sonidoaumentacestita.wav` → Mejorar cesto
  * `sonidomonodorado.wav` y `sonidomonodoradoactivo001.wav` → Interacciones con mono dorado
  * `sonidomar.mp3`, `SonidoGeiser.wav`, `SonidoExplosion.wav` → Efectos ambientales
  * `pasonivel.wav` → Avanzar nivel
  * `tiempoagotado.wav`, `Sonidomosquito.wav`, `SonidoCogidaBola.wav` → Efectos diversos
  * Canciones de fondo: `cancionmenu.mp3`, `cancionjugando001-007.mp3`, `cancionfinal.mp3`, `cancionjuegopasado.mp3`

* **`fuentes/`** – Archivos de fuentes:

  * `fuentemarcadores.fnt`
  * `fuentemenuamarillo.fnt`
  * `fuentemenublanco.fnt`

* **Ejecutables y librerías:**

  * `Jugar.exe` → Ejecutable principal
  * `fmodex.dll` y `SDL2.dll` → Librerías necesarias

* **Código fuente y motor:**

  * `Jugar.prg` → Código en DIV y derivados (lenguaje Script)
  * `El GBC` → Código intermedio interpretado por la VM (pseudo-assembly y metadatos)

---

## Cómo Jugar

**Objetivo:** Recoge toda la fruta y supera los obstáculos mientras evitas a los enemigos de la selva.

### Niveles

* **Niveles 1-16:** Explora la selva, recoge fruta, evita mosquitos, arañas y pinchos.
* **Nivel 17 (Final):** Enfrenta al tótem maligno que controla a los animales.

  * **Cuidado con el águila**, que ataca en picado de vez en cuando.

### Enemigos

* **Mosquito:** Pequeños y rápidos, atacan constantemente.
* **Araña:** Lentas pero peligrosas al contacto.
* **Pinchos y Obstáculos:** Pueden hacerte perder vidas.
* **Águila:** Solo en nivel final, ataca en picado.
* **Tótem Maligno (Jefe Final):** Controla a los enemigos menores.

### Modos de Juego

* **Modo Clásico:** Pierdes vidas al tocar enemigos u obstáculos.
* **Modo Sin Muerte por Contacto:** Ideal para principiantes.
* **Modo Contrarreloj:** Completa los niveles lo más rápido posible.

### Controles

* **Flechas ← →:** Movimiento
* **Flecha ↑:** Saltar
* **Espacio:** Puñetazo (ataque limitado; en nivel final puedes lanzar cocos)

---

## Características Principales

* 🎮 Plataformas 2D clásicas, coloridas y accesibles
* 🍌 17 niveles llenos de fruta, enemigos y obstáculos
* 👊 Sistema de ataque simple: puñetazos y cocos en nivel final
* 🎯 Múltiples modos de juego: clásico, sin muerte, contrarreloj
* 👹 Jefe final épico: tótem maligno que controla a los animales
* 👶 Diseño pensado para niños y principiantes