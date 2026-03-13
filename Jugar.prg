program El_Juego_de_Los_3_Monos;

// Autor Mario Gómez. Versión 1.0

audio_setup.song_channels = 2; // indico al engine audio de alocar 2 canales de canciones
audio_refresh_setup(refresh_audio_engine); // setea la config de AUDIO_SETUP

global;
    tocolatela = 0;  
    activadavelocidadlentatelaraña = 0;   


    totem_x_original;  // posición original del tótem
    totem_x_actual;    // posición actual del tótem
    totem_y;           // posición Y del tótem
    totem_golpeado = 0;      // flag para animación de golpe
    cooldown_coco = 0; // contador de recarga
    totemtoques = 100;
   

// Estados de lanzadoras: 1=activa, 0=destrozada
lanzadorestacas1 = 1; // inferior izquierda
lanzadorestacas2 = 1; // inferior centro
lanzadorestacas3 = 1; // inferior derecha
lanzadorestacas4 = 1; // superior izquierda
lanzadorestacas5 = 1; // superior centro
lanzadorestacas6 = 1; // superior derecha
energia = 100;   // Energía actual
energia_totem = 100; // Energía total

tiempo_fijo_superiores = 400; // frames entre disparos de las lanzadoras superiores
tiempo_fijo_inferiores = 400; // frames entre disparos de las lanzadoras inferiores

graficoEstaca = 999;     // ID de gráfico de la estaca
graficoLanzadora = 999;  // ID de gráfico de la lanzadora

juegofinalizado = 0; 
    
// Variables para estacas superiores (parábola)
estaca_sup_activa = 0;   // cual estaca superior está activa (0=ninguna, 1=izq, 2=med, 3=der)
tiempo_estaca_sup = 0;   // contador de tiempo para estacas superiores
    
// Variables para estacas inferiores (línea recta)
estaca_inf_activa = 0;   // cual estaca inferior está activa
tiempo_estaca_inf = 0;   // contador de tiempo para estacas inferiores
    
// Variables para marcador de toques
toques_restantes = 10;   // número de toques necesarios para ganar
marcador_x = 160;        // posición X del marcador (centro)
marcador_y = 380;        // posición Y del marcador (abajo)      
totemgolpeado = 0;   

inmortalmientrascaerevive = 0;
tiempoinmortal = 0;
lanzaderastotales = 0;

movimientomarx = 0;
movimientomary = 0; 
señaldireccion; // depende de la señal que toques el mono va para arriba o para abajo

graficoinicialmono1andando = 1;
graficofinalmono1andando = 20;        
                        
graficoinicialmono2trepando = 131;
graficofinalmono2trepando = 139;       
                        
graficoinicialmono2andando = 101;
graficofinalmono2andando = 110; 

graficoinicialmono2salto = 105;
                        
graficoinicialmono2pegando = 122;
graficofinalmono2pegando = 129;     
                        
graficoinicialramas = 912;
graficofinalramas = 921;   
                        
AlturaTerrenoArriba = 200;
AlturaTerrenoMedio = 370;
AlturaTerrenoAbajo = 535;   
                  
contadoranimacioninicio;    
tiempobloqueodeteclas = 0; // usado para que mientras cambia de mono no aparezcan graficos indeseados                 
pinchosactivos = 0;              
idmono;      
xmono; // identifica la posicion x del mono para poder interactuar otros procesos con el.
ymono; // identifica la posicion y del mono para poder interactuar otros procesos con el. 
nubeshay = 0;   
//numeroaleatorio = 0;

frutaenpantalla;               
frutastengo;
frutacogida;  // Al recoger una fruta, frutacogida se establece en 1 durante unos segundos. Esto permite aumentar el tamaño de la cestita.
vidastengo;
textovidastengo;
nivel;
tiempo;
cogidaestatua;
fin_nivel = true; // controla el nivel
alturamono;
establecenuevomono = 1;
                  
abajo; medio; arriba;
subetiempo; // si esta en 0 no pasa nada si esta en 1 sube 20 segundos de uno en uno al contador de tiempo.
texto1; // texto 1 menu
texto2; // texto 2 menu
texto3; // texto 3 menu
texto4; // mensajes durante el juego
texto5; // mensajes durante el juego
textotiempo; // numero de marcador de tiempo
textofrutastengo; // numero de marcador de fruta
textosumatiempo;
numerodecajas = 0; // para controlar la z de las cajas
fuerza_salto = 12; // fuerza con que salta el mono
picadomono = 0; // comprueba si lo pico el mosquito
transicionactivada = 0; // pausa el tiempo mientras esta la transicion activada
contadortransicion = 0;
tipodetiempo = 1; // 1 sin tiempo 2 con tiempo por nivel 3 tiempo continuo
tipoinmortal = 1; // 1 inmortal 2 mortal
xteladea = 0;
tocadaarena = 0;
estatuaactiva = 0;

// Declaramos las variables para almacenar los identificadores de los sonidos del juego.
// Cada variable representará un sonido específico que se cargará en el juego.
estoypegando = 0; // para saber cuando un mono esta pegando. afecta a troncos de palmeras y afecta a mosquitos.
flagsmono;
sonidomonoboton;            // Sonido asociado al presionar un botón
sonidomonosalir;            // Sonido al salir del juego o de una sección
sonidomonosalto;            // Sonido para el salto del personaje
sonidomonogolpepalmera;     // Sonido al golpear una palmera
sonidomonocoge1;            // Primer sonido para la recogida de objetos
sonidomonocoge2;            // Segundo sonido para la recogida de objetos
SonidoSalpicaAgua;
sonidomonochange;           // Sonido al cambiar de estado o modo del personaje
pasonivel;                  // Sonido al completar y avanzar de nivel
sonidoaumentacestita;       // Sonido al aumentar la cantidad de frutas cogidas
sonidotiempoagotado;       // Sonido para cuando se agota el tiempo
sonidocogidabola;           // Sonido para cuando cogemos una bola transformadora
sonidomosquito;
sonidomonodoradoactivo;             
sonidoaguilaatacando;
SonidoGeiser;
SonidoExplosion;       

cancionmenu;
sonidomonodorado;
sonidomar;
cancionjugando001;    
cancionjugando002;    
cancionjugando003;    
cancionjugando004;      
cancionjugando005;  
cancionjugando006;  
cancionjugando007;      
cancionfinal;  
cancionjuegopasado;
activadotiemposonando = 0;

local
    velocidad_gravedad = 0; // velocidad a la que esta bajando o subiendo el objeto
    en_suelo = false; // indica si el objeto esta sobre el suelo o en el aire
    
begin
    rand_seed(get_millisecs());
    // mode_set(800, 600,32, mode_fullscreen);
    mode_set(800, 600, 32);
    set_fps(30, 0);
    load_fpg("graficos/graficos.fpg");
 
    // Sonidos para acciones específicas del personaje (mono):
    sonidomonoboton = sound_load("sonidos/sonidomonoboton.wav");      // Sonido al presionar un botón
    sonidomonosalir = sound_load("sonidos/sonidomonosalir.wav");      // Sonido al salir del juego o de una sección
    sonidomonosalto = sound_load("sonidos/sonidomonosalto.wav");      // Sonido del salto del personaje
    sonidomonogolpepalmera = sound_load("sonidos/sonidomonogolpepalmera.wav"); // Sonido al golpear una palmera
    sonidomonocoge1 = sound_load("sonidos/sonidomonocoge1.wav");      // Sonido al recoger un objeto (variante 1)
    sonidomonocoge2 = sound_load("sonidos/sonidomonocoge2.wav");      // Sonido al recoger un objeto (variante 2)
    sonidosalpicaagua = sound_load("sonidos/sonidosalpicaagua.wav");  // Sonido al recoger un objeto (variante 2)
    sonidoaguilaatacando = sound_load("sonidos/sonidoaguilaatacando.wav");    // Sonido al cambiar de estado o modo
    sonidomonochange = sound_load("sonidos/sonidomonochange.wav");    // Sonido al cambiar de estado o modo
    sonidoaumentacestita = sound_load("sonidos/SonidoaumentaCestita.wav");    // Sonido al cambiar de estado o modo
    sonidomonodorado = sound_load("sonidos/monodorado.wav");          // Sonido al tocar el mono dorado
    sonidomonodoradoactivo = sound_load("sonidos/sonidomonodoradoactivo001.wav");
    sonidomar = sound_load("sonidos/sonidomar.mp3");
    SonidoGeiser = sound_load("sonidos/SonidoGeiser.wav");
    SonidoExplosion = sound_load("sonidos/SonidoExplosion.wav");
    // Sonido para avanzar de nivel:
    pasonivel = sound_load("sonidos/pasonivel.wav");                  // Sonido al completar y pasar al siguiente nivel
    sonidotiempoagotado = sound_load("sonidos/tiempoagotado.wav");  
    sonidomosquito = sound_load("sonidos/Sonidomosquito.wav");  
    sonidocogidabola = sound_load("sonidos/SonidoCogidaBola.wav");  
    cancionmenu = song_load("sonidos/cancionmenu.mp3");
    cancionjugando001 = song_load("sonidos/cancionjugando001.mp3");
    cancionjugando002 = song_load("sonidos/cancionjugando002.mp3");
    cancionjugando003 = song_load("sonidos/cancionjugando003.mp3");
    cancionjugando004 = song_load("sonidos/cancionjugando004.mp3");
    cancionjugando005 = song_load("sonidos/cancionjugando005.mp3");
    cancionjugando006 = song_load("sonidos/cancionjugando006.mp3");
    cancionjugando007 = song_load("sonidos/cancionjugando007.mp3");
    cancionfinal = song_load("sonidos/cancionfinal.mp3");
    cancionjuegopasado = song_load("sonidos/cancionjuegopasado.mp3");
          
    load_fnt("fuentes/fuentemarcadores.fnt");
    load_fnt("fuentes/fuentemenuamarillo.fnt");
    load_fnt("fuentes/fuentemenublanco.fnt");   
    logogemix();
    frame;
end
     
PROCESS tiempoagotado()
PRIVATE
    puestotexto = 0;
    contador = 0;
BEGIN
    graph = 974;
    x = 800;
    y = 0;

    LOOP
        // Mover texto hacia la izquierda
        IF(x > -350) 
            x = x - 50; 
        END

        // Mostrar mensaje cuando llega a la posición
        IF(x <= -350 AND puestotexto == 0)
            puestotexto = 1;
            texto4 = write(2, 430, 315, 1, "¡Se acabó el tiempo!");
        END

        // Contar tiempo de visualización
        IF(puestotexto == 1)
            contador++;
        END

        // Eliminar texto después de 70 frames
        IF(contador >= 70)
            delete_text(texto4);
            BREAK;
        END

        FRAME;
    END
END

PROCESS logogemix()
PRIVATE
BEGIN
    contadoranimacioninicio = 0; 
    fade_on();
    put_screen(0, 900);
    song_play(cancionmenu, 1);
    logogemix2();   
    x = -20;
    y = -20;
    graph = 967;

    LOOP 
        contadoranimacioninicio++;

        IF(contadoranimacioninicio > 30 AND contadoranimacioninicio < 55)
            x++;
            y++;
        END

        IF(contadoranimacioninicio > 66)
            y = y - 5;
        END

        IF(contadoranimacioninicio > 250)
            BREAK;
        END

        FRAME;
    END
END


PROCESS logogemix2()
BEGIN
    graph = 968;

    LOOP
        IF(contadoranimacioninicio > 66)
            y = y - 5;

            IF(contadoranimacioninicio == 67)
                suelomenu();
                palmeramenu(0, 100, 755);
                palmeramenu(1, 700, 755);
            END

            IF(contadoranimacioninicio > 200)
                BREAK;
            END
        END

        FRAME;
    END
END

 
PROCESS suelomenu()
PRIVATE
    posiciontitulo = 550;
BEGIN
    graph = 903;
    y = 550;
    x = 400;
    generador_de_nubes();

    LOOP
        IF(contadoranimacioninicio > 66 AND contadoranimacioninicio < 140)
            y = y - 3;
        END

        IF(contadoranimacioninicio == 140)
            titulomenu();
        END 

        IF(contadoranimacioninicio == 200)
            textosmenu(); 
        END

        FRAME;
    END
END


PROCESS textosmenu()
PRIVATE
    STRING textotipodetiempo = "Sin Tiempo";
    STRING textoinmortal = "Modo Seguro"; 
    fuente1 = 2;
    fuente2 = 3;
    fuente3 = 3;
    fuente4 = 3;
    opcion = 1;
    ultima_opcion = 0;
BEGIN
    // Crear textos iniciales
    texto1 = write(fuente1, 400, 250, 4, "Jugar");
    texto2 = write(fuente2, 400, 320, 4, textotipodetiempo);
    texto3 = write(fuente3, 400, 390, 4, textoinmortal);
    texto4 = write(fuente4, 400, 460, 4, "Salir");

    tipodetiempo = 1;
    tipoinmortal = 1;

    LOOP
        // Navegación del menú
        IF(key(_esc))
            opcion = 4;
            BREAK;
        END

        IF(key(_up) AND timer[0] >= 25)
            opcion = max(1, opcion - 1);
            timer = 0;
        END

        IF(key(_down) AND timer[0] >= 25)
            opcion = min(4, opcion + 1);
            timer = 0;
        END

        // Actualizar selección visual
        IF(ultima_opcion != opcion)
            ultima_opcion = opcion;

            fuente1 = (opcion == 1 ? 2 : 3);
            fuente2 = (opcion == 2 ? 2 : 3);
            fuente3 = (opcion == 3 ? 2 : 3);
            fuente4 = (opcion == 4 ? 2 : 3);

            delete_text(texto1);
            delete_text(texto2);
            delete_text(texto3);
            delete_text(texto4);

            texto1 = write(fuente1, 400, 250, 4, "Jugar");
            texto2 = write(fuente2, 400, 320, 4, textotipodetiempo);
            texto3 = write(fuente3, 400, 390, 4, textoinmortal);
            texto4 = write(fuente4, 400, 460, 4, "Salir");
        END

        // Manejar selección con _space
        IF(key(_space) AND timer[0] >= 25)
            SWITCH(opcion)
                CASE 2:
                    timer[0] = 0;
                    tipodetiempo = (tipodetiempo % 3) + 1;
                    SWITCH(tipodetiempo)
                        CASE 1: textotipodetiempo = "Sin Tiempo"; END
                        CASE 2: textotipodetiempo = "Tiempo por Nivel"; END
                        CASE 3: textotipodetiempo = "Tiempo Continuo"; END
                    END
                END

                CASE 3:
                    timer[0] = 0;
                    tipoinmortal = (tipoinmortal % 2) + 1;
                    SWITCH(tipoinmortal)
                        CASE 1: textoinmortal = "Modo Seguro"; END
                        CASE 2: textoinmortal = "Modo Desafío"; END
                    END
                END

                CASE 1, 4:
                    BREAK; // salir del loop
                END
            END

            // Actualizar textos de tiempo e inmortal
            delete_text(texto2);
            texto2 = write(fuente2, 400, 320, 4, textotipodetiempo);
            delete_text(texto3);
            texto3 = write(fuente3, 400, 390, 4, textoinmortal);
        END

        FRAME;
    END

    // Salimos del menú
    SWITCH(opcion)
        CASE 1:
            delete_text(texto1); 
            delete_text(texto2);
            delete_text(texto3);
            delete_text(texto4);

            transicion(1);
            FRAME(4000);

            signal(TYPE suelomenu, s_kill);
            signal(TYPE palmeramenu, s_kill);
            signal(TYPE ramasmenu, s_kill);
            signal(TYPE titulomenu, s_kill);
            signal(TYPE generador_de_nubes, s_kill);
            signal(TYPE nube, s_kill);
            signal(TYPE logogemix, s_kill);
            signal(TYPE logogemix2, s_kill);

            jugar();
        END

        CASE 4:
            delete_text(texto1); 
            delete_text(texto2);
            delete_text(texto3);
            delete_text(texto4);

            signal(TYPE suelomenu, s_kill);
            signal(TYPE palmeramenu, s_kill);
            signal(TYPE ramasmenu, s_kill);
            signal(TYPE titulomenu, s_kill);
            signal(TYPE generador_de_nubes, s_kill);
            signal(TYPE nube, s_kill);

            fade_off();
        END
    END
END


  PROCESS palmeramenu(flags, x, y)
PRIVATE
BEGIN
    graph = 911;
    ramasmenu(flags, x, y - 112);

    LOOP
        IF(contadoranimacioninicio > 66 AND contadoranimacioninicio < 140)
            y = y - 3;
        END

        FRAME;
    END
END


PROCESS ramasmenu(flags, x, y)
PRIVATE
    contador = 0;
    direccion = 0;
BEGIN
    graph = graficoinicialramas;

    LOOP
        contador++;

        // Animación de la rama
        IF(contador >= 3)
            IF(direccion == 0)
                graph = graph + 1;
                IF(graph >= graficofinalramas)
                    direccion = 1;
                END
            ELSE
                graph = graph - 1;
                IF(graph <= graficoinicialramas)
                    direccion = 0;
                END
            END
            contador = 0;
        END

        // Movimiento vertical de la rama
        IF(contadoranimacioninicio > 66 AND contadoranimacioninicio < 140)
            y = y - 3;
        END

        FRAME;
    END
END


PROCESS titulomenu()
BEGIN
    graph = 969;
    x = 400;
    y = 115;

    generador_de_nubes();

    LOOP
        FRAME;
    END
END


PROCESS mar(x, y, flags)
PRIVATE
    contadormar = 0;
BEGIN
    graph = 996;

    LOOP
        x += movimientomarx * (flags == 0 ? 1 : -1);
        FRAME;
    END
END
     
process mono(x, y, flags, numeromono); //numeromono= 1,2 o 3.
private
fueradepantalla=0;

primeraimagenandando;    
ultimaimagenandando;    
                 
graficomonosaltando;
primergraficomuerto;
ultimograficomuerto;    
              
                  
primeraimagenrespirando;    // animación andando primera imagen
ultimaimagenrespirando;    // animación andando última imagen    
                      
graficomonopicado;  

primeraimagenpegando;
ultimaimagenpegando; 
                 
tiempomonopicado=200;             
         atrapado_en_la_tela;          
velocidad=0;
tiemposinmoverse=0;
misombra;
contadorpicadomosquito=0;
tiemporebotemono=0;
contadorcambiocolorespicaduramosquito;
tablacolorespicadura[9] = 0x7f0082FF, 2 dup(0x7f0082FF), 3 dup(0x111042FF), 3 dup(0x7f0082FF);
count = 0;
xoriginal;
yoriginal;        
t=0;
 
pinchadomono=0;
velocidadmono=3;
        contador2=30;
             sumay=0; //para cuando el mono es pinchado para que suba al pincharse
incrementovelocidadensalto;
fx_advancedtype_tint tint; // para tintar prueba
methods
  method callback finalize()



  begin
    signal(misombra, s_kill);
  end


begin
 
inmortalmientrascaerevive=1;
picadomono=0; // para que la picadura no pase al siguiente nivel
  switch(numeromono)
   
    case 1: 
      primeraimagenandando=1;
      ultimaimagenandando=32;
      graficomonosaltando=7;
      primeraimagenrespirando=33;    
      ultimaimagenrespirando=40;    
      graficomonopicado=41;      
      primeraimagenpegando=73;   // 42
      ultimaimagenpegando=69; 
      tiempomonopicado=250;                        
      velocidadmono=5;       
      primergraficomuerto=70;
      ultimograficomuerto=71;           
    end
    case 2: 
      primeraimagenandando=101;
      ultimaimagenandando=132;    
      graficomonosaltando=107;
      primeraimagenrespirando=134;    
      ultimaimagenrespirando=144;  
      graficomonopicado=145; 
      primeraimagenpegando=146; 
      ultimaimagenpegando=169;                  
      tiempomonopicado=200;    
      velocidadmono=3;
      primergraficomuerto=170;
      ultimograficomuerto=171; 
    end
    case 3: 
      primeraimagenandando=200;
      ultimaimagenandando=231;    
      graficomonosaltando=207;
      primeraimagenrespirando=232;    
      ultimaimagenrespirando=239;  
      graficomonopicado=240; 
      primeraimagenpegando=241;
      ultimaimagenpegando=264;  
      tiempomonopicado=150;    
      velocidadmono=3;
      primergraficomuerto=265;
      ultimograficomuerto=266; 
    end
  end



  graph=primeraimagenandando;
    
if(nivel<17)  misombra=sombra_del_mono(x, y,40); end

  loop
  

   if(keydown(_p))
       while(keydown(_p)) frame; end
       pausa(numeromono);
     end

  if (tipodetiempo <> 1 and transicionactivada == 0 and nivel<17)

    // solo cuenta si queda tiempo
    if (tiempo >= 0)
        contador2--;

        if (contador2 == 0)

            tiempo=tiempo-1; 

            contador2 = 30;
        end

    end

end




  if(juegofinalizado==1) monofinal(x, AlturaTerrenoAbajo, flags, numeromono);  break; end


  

  
    xmono=x;
    ymono=y;
   flagsmono=flags;


if(cooldown_coco > 0)
    cooldown_coco--; // el contador baja cada frame
end

if(key(_space) AND nivel == 17 AND cooldown_coco == 0)
    cooldown_coco = 2; // frames de espera antes del siguiente disparo

    if(flags == 0) // mirando derecha
        coco_final(x + 20, y, 1);
    else // mirando izquierda
        coco_final(x - 20, y, 0);
    end
end



 
  // controlar sale por un lado entra por otro
   if (nivel<=16)
       if (x <= 0 and key(_left)) x=800; 
          if(señaldireccion==1) y =y-170; else  y =y+170; end 
       end
   if (x >= 800 and key(_right)) x=0; 
       if(señaldireccion==1) y =y-170; else  y =y+170; end 
   end
   end
   
   if(nivel==17)
    if (x <= 1 and key(_left)) 
       if(señaldireccion==1) y =y-170; if(key(_left)) x=4; flags=0;  end 
     end
  
      if (x <= 1 and key(_left)) 
       if(señaldireccion==2) y =y+170;  if(key(_left)) x=4; flags=0; end end
   end
   
      
   
  
  end

   if ((collision(type totem_final)))
        x=x-10;
   end
   
   
   
end


 if (nivel==17)
   if (x <= 15 and key(_left)) x=15; 
     
   end
   if (x >= 795 and key(_right)) x=795; 
     
   end

   
   end



  if(x<0 or x>800) fueradepantalla++; else fueradepantalla=0; end
  if(fueradepantalla>=4) if(x>400) x=799; else x=001; end end 
  
  
  
  

  
  
    // gestiona la muerte del mono
    if((tipoinmortal==2) and (collision (type dureza_de_la_arena) or (collision (type pinchos)  or collision(type mosquito) or (collision (type aguila)))))


    

 muertemono(x,y,primergraficomuerto,ultimograficomuerto,numeromono);
      break;
    end  
   
    if( inmortalmientrascaerevive==1)
      tiempoinmortal++;
    end
    if (tiempoinmortal>=150)
       tiempoinmortal=0; inmortalmientrascaerevive=0;
    end
     
    if(tiempoinmortal==0)
      if(collision(type estaca_linea_final) or collision(type estaca_parabola_final) or collision(type lanzadora_lineal) ) 
        muertemono(x, y, primergraficomuerto, ultimograficomuerto, numeromono); break; 
      end 
   end

// en caso de que sea inmortal y toca pinchos lo hace botar
      if (tipoinmortal==1 and (collision (type pinchos)))
        graph=graficomonopicado;
      end


  
  
  
  
  
  
  
if(tipoinmortal == 1 and (collision(type dureza_de_la_arena) or (collision(type pinchos) or collision(type caja)or collision(type aguila)))) 

        tiempobloqueodeteclas = 1;
        graph = graficomonopicado;

        if(flags == 0)      
            repeat
                y = y - 2;
                sumay = sumay + 1;
                x = x - 3; 
                frame;
            until(sumay > 10);
            sumay = 0;
        else 
            repeat
                y = y - 2;
                sumay = sumay + 1;
                x = x + 3; 
                frame;
            until(sumay > 10);
            sumay = 0;
        end

        tiempobloqueodeteclas = 0;
   
end

if(collision(type arena))
    tocadaarena = 1; 
else 
    tocadaarena = 0; 
end
 
  
  if(collision (type bola_cambio_mono)) tiempobloqueodeteclas=1; explosioncambiomono(x, y); 
  numeromono=establecenuevomono;
    switch(establecenuevomono)
   
    case 1: 
      primeraimagenandando=1;
      ultimaimagenandando=32;
      graficomonosaltando=7;
      primeraimagenrespirando=33;    
      ultimaimagenrespirando=40;    
      graficomonopicado=41;   
      primeraimagenpegando=73;   // 42
      ultimaimagenpegando=69; 
      tiempomonopicado=250;                        
      velocidadmono=5;   
      primergraficomuerto=70;
      ultimograficomuerto=71;                  
    end
    case 2: 
      primeraimagenandando=101;
      ultimaimagenandando=132;    
      graficomonosaltando=107;
      primeraimagenrespirando=134;    
      ultimaimagenrespirando=144;  
      graficomonopicado=145; 
      primeraimagenpegando=146;
      ultimaimagenpegando=169;                  
      tiempomonopicado=200;    
      velocidadmono=3;
      primergraficomuerto=170;
      ultimograficomuerto=171; 
    end
    case 3: 
      primeraimagenandando=200;
      ultimaimagenandando=231;    
      graficomonosaltando=207;
      primeraimagenrespirando=232;    
      ultimaimagenrespirando=239;  
      graficomonopicado=240; 
      primeraimagenpegando=241;
      ultimaimagenpegando=264;  
      tiempomonopicado=150;    
      velocidadmono=3;
      primergraficomuerto=265;
      ultimograficomuerto=266; 
    end
  end
  frame;
  tiempobloqueodeteclas=0;
  end


 
 if (en_suelo and key(_up) and tiempobloqueodeteclas==0 and tocadaarena==0)  //and not atrapado_en_la_tela
      sound_play(sonidomonosalto); 
      graph=graficomonosaltando;
      velocidad_gravedad = -fuerza_salto; 
    end 
if (en_suelo) incrementovelocidadensalto=1; else   incrementovelocidadensalto=2; end
  
 
 
    if (picadomono==0)
      xoriginal=x;
      yoriginal=y;
      if((key(_left) or key(_right))  and tiempobloqueodeteclas==0)
     
        if(key(_left))  flags=1; velocidad = -velocidadmono; end 
        if(key(_right)) flags=0; velocidad = velocidadmono; end

        graph=graph+1;
        
        x=x+velocidad*incrementovelocidadensalto; 
        if(graph>=ultimaimagenandando) graph=primeraimagenandando; end
        else 
        if(graph<=ultimaimagenandando) graph=ultimaimagenandando; end
      end
      
     
    end


    if (picadomono==1)
      xoriginal=x;
      yoriginal=y;
      if((key(_left) or key(_right)) and tiempobloqueodeteclas==0)
        if(key(_right) and x>15)  flags=1; velocidad = -velocidadmono; end 
        if(key(_left) and x>15) flags=0; velocidad = velocidadmono; end
        graph=graph+1;
        x=x+velocidad*incrementovelocidadensalto; 
        if(graph>=ultimaimagenandando) graph=primeraimagenandando; end
        else 
        if(graph<=ultimaimagenandando) graph=ultimaimagenandando; end
      end
    end
    
 
// animación respira cuando esta parado
    if(scan_code==0)
      velocidad=0;
      if (tiemposinmoverse==0) graph=primeraimagenrespirando;  end
      tiemposinmoverse++;
    else tiemposinmoverse=0;
    end

    if(tiemposinmoverse>15) 
      graph=graph+1;
      if(graph>=ultimaimagenrespirando) graph=primeraimagenrespirando; end
    end
     
        
// fin animación respira cuando esta parado
   
     
    if (en_suelo and key(_space) and tiempobloqueodeteclas==0)
     estoypegando=1;
      if(collision(type troncopalmera)) sound_play(sonidomonogolpepalmera); end
 
      switch(numeromono)

        case 1: from graph=46 to 69; frame; end
        end
        case 2: from graph=146 to 169; frame; end
        end
        case 3: from graph=241 to 264; frame; end
        end
      end
      estoypegando=0; 
      graph=primeraimagenrespirando;
    end
    
   
// controlamos a que altura esta el mono para luego saber por donde sale y donde entra
if(y <= AlturaTerrenoArriba) 
    alturamono = 1; 
end
if(y <= AlturaTerrenoMedio + 50 and y >= AlturaTerrenoMedio) 
    alturamono = 2; 
end
if(y >= AlturaTerrenoMedio + 20) 
    alturamono = 3; 
end

gravedad(5, -10);

if(collision(type dureza_del_tronco) or collision(type piedra_grande))
    x = xmono;
end

if(collision(type mosquito))
    picadomono = 1;
    graph = graficomonopicado;
end

if(picadomono == 1 and nivel < 17)
    contadorpicadomosquito++;
    contadorcambiocolorespicaduramosquito++;
    if(contadorcambiocolorespicaduramosquito >= 9) 
        contadorcambiocolorespicaduramosquito = 0; 
    end

    fx.mode = fx_advanced; // aplico un efecto avanzado mediante estructura TINT
    fx.fxref = &tint; 
    tint.color = tablacolorespicadura[contadorcambiocolorespicaduramosquito];

    tiemporebotemono = tiemporebotemono + 6;

    if(tiemporebotemono <= 20 and tiemporebotemono >= 0) 
        x = x - 3; y = y - 10; 
    end
    if(tiemporebotemono <= 40 and tiemporebotemono >= 21) 
        x = x - 3; y = y + 8; 
    end
    if(tiemporebotemono <= 60 and tiemporebotemono >= 41) 
        x = x - 3; y = y - 10; 
    end
    if(tiemporebotemono <= 80 and tiemporebotemono >= 61) 
        x = x - 3; y = y + 8; 
    end
    if(tiemporebotemono <= 100 and tiemporebotemono >= 81) 
        x = x - 2; y = y - 10; 
    end
    if(tiemporebotemono <= 120 and tiemporebotemono >= 101) 
        x = x - 2; y = y + 5; 
    end
    if(tiemporebotemono <= 140 and tiemporebotemono >= 121) 
        x = x - 1; y = y - 3; 
    end
    if(tiemporebotemono <= 150 and tiemporebotemono >= 141) 
        x = x - 1; y = y + 3; 
    end
end

if(contadorpicadomosquito >= tiempomonopicado)
    fx.mode = fx_solid; 
    picadomono = 0;
    contadorpicadomosquito = 0;
end



if(picadomono == 1 and nivel == 17) 
    contadorpicadomosquito++;
    contadorcambiocolorespicaduramosquito++;
    if(contadorcambiocolorespicaduramosquito >= 9) 
        contadorcambiocolorespicaduramosquito = 0; 
    end

    fx.mode = fx_advanced; // aplico un efecto avanzado mediante estructura TINT
    fx.fxref = &tint; 
    tint.color = tablacolorespicadura[contadorcambiocolorespicaduramosquito];

    tiemporebotemono = tiemporebotemono + 6;

    if(tiemporebotemono <= 20 and tiemporebotemono >= 0) 
        x = x + 2; y = y - 10; 
    end
    if(tiemporebotemono <= 40 and tiemporebotemono >= 21) 
        x = x + 2; y = y + 8; 
    end
    if(tiemporebotemono <= 60 and tiemporebotemono >= 41) 
        x = x + 2; y = y - 10; 
    end
    if(tiemporebotemono <= 80 and tiemporebotemono >= 61) 
        x = x + 2; y = y + 8; 
    end
    if(tiemporebotemono <= 100 and tiemporebotemono >= 81) 
        x = x + 1; y = y - 10; 
    end
    if(tiemporebotemono <= 120 and tiemporebotemono >= 101) 
        x = x + 1; y = y + 5; 
    end
end

if(contadorpicadomosquito >= tiempomonopicado)
    fx.mode = fx_solid; 
    picadomono = 0;
    contadorpicadomosquito = 0;
end

atrapado_en_la_tela = collision(type Objeto_tela_de_a); // si el mono la toca la tela
if(atrapado_en_la_tela)                 
    graph = graficomonopicado;
    tiempobloqueodeteclas = 1;
    if(key(_left)) flags = 0; end
    if(key(_right)) flags = 1; end
    tocolatela = 1;
    if(xteladea < x) 
        x = x - 3;  
    end
    if(xteladea > x) 
        x = x + 3;  
    end
end

if(tocolatela == 1 and not atrapado_en_la_tela) 
    tocolatela = 0; 
    tiempobloqueodeteclas = 0;
end

if(collision(type tela_de_araña_que_no_se_va) or tocadaarena == 1)
    activadavelocidadlentatelaraña = 1;
    velocidadmono = 2;
else
    activadavelocidadlentatelaraña = 0;
    switch(numeromono)
        case 1: velocidadmono = 5; end
        case 2: velocidadmono = 3; end
        case 3: velocidadmono = 3; end
    end
end

frame;
end
end



process muertemono(x, y, primergraficomuerto, ultimograficomuerto, numeromono);
private
    contadormuerto = 0;
begin
    loop
    
        contadormuerto++;
        y = y - 2;

        if(contadormuerto > 5) 
            graph = primergraficomuerto;
        else 
            graph = ultimograficomuerto;
        end

        if(contadormuerto > 10) 
            contadormuerto = 0;
        end

        if(y < -10) 
            break;
        end

        if(y < AlturaTerrenoArriba + 40  and vidastengo > 0) 
            vidastengo = vidastengo - 1;  
            inmortalmientrascaerevive = 1;
            mono(x, y, flags, numeromono); 
            break;
        end

        if(y < 10 and vidastengo <=0)
            delete_text(all_text);
            eliminacosas();
            logogemix();
            break;
        end

        frame;
    end
end

process sombra_del_mono(x, y, incrementosombra)
begin
    graph = 928;
    z = 1;  
    incrementosombra = -3;
    flags = 4;
    size = 110; 

    loop
        if(father.en_suelo and picadomono == 0 and tiempobloqueodeteclas == 0)
            y = father.y + incrementosombra;
            size = 110;
        else
            size = 100;
        end

        x = father.x; 
        frame;
    end
end

        
process hojastrampa(x, y);
private
begin
    y = y + 5;
    graph = 987;
    z = -1;

    pinchos(x, y);

    loop
        frame;
    end
end



process pinchos(x, y)
private
    tablaanimacionpinchos[15] = 5 dup(988), 5 dup(989), 5 dup(990);
    contador = 0;
    distancia = 0;
begin
    y = y + 5;
    graph = 988;
    z = 1;

    loop
        distancia = x - xmono;

        if(distancia <= 60 and distancia >= -60)
            if(contador < 14) contador++; end
            graph = tablaanimacionpinchos[contador];
        else
            if(contador > 1) contador--; end
            graph = tablaanimacionpinchos[contador];
        end

        frame;
    end
end   
     
process Objeto_sombra_mono(x, y, incrementosombra);
private
begin
    // Ajuste inicial
    y = y + 5;
    graph = 923;
    z = 3;
    flags = 4;
    size = 110;

    loop
        // Actualizar posición según el padre
        x = father.x;
        if(father.en_suelo) 
            y = father.y + incrementosombra;
            size = 110;
        else
            size = 100;
        end

        frame;
    end
end
 
  
process sueloycielo(tiposuelo,tipocielo)
private
    graficosuelo;
    zsuelo;
begin 
    

   switch(tipocielo)
        case 1:
            put_screen(0, 900);  
        end

        case 2:
            put_screen(0, 901);
        end

        case 3:
            put_screen(0, 902);
 
end 
 end
    // Determinar gráfico y z según tipo
    switch(tiposuelo)
        case 1: graficosuelo = 903; zsuelo = 1; end
        case 2: graficosuelo = 904; zsuelo = 2; end
        case 3: graficosuelo = 905; zsuelo = 3; end
        case 4: graficosuelo = 283; zsuelo = 3; end
    end

   
        graph = graficosuelo;
        z = zsuelo;
        x = 400;
        y = 300;

        loop
       
            frame;
        end

end



process control_del_nivel()
private
iniciotransicionagotadotiempo=0;
begin
  generador_de_nubes();
  loop 
    if(tipodetiempo<>1 and tiempo<=0 and iniciotransicionagotadotiempo==0)
    iniciotransicionagotadotiempo=1;
      transicion(2);
    end
    if(key(_esc))let_me_alone(); break; end 
  frame;
  end
end

process generador_de_nubes()
private
    controltiempoGeneradordeNubes = 0;
begin
    loop
        controltiempoGeneradordeNubes++;

        if(controltiempoGeneradordeNubes == 200 or controltiempoGeneradordeNubes == 600)
            nube();
        end

        if(controltiempoGeneradordeNubes >= 600)
            controltiempoGeneradordeNubes = 0;
        end

        frame;
    end
end


process nube()
private
begin
    nubeshay++;
    graph = rand(906, 907);
    z = 4;

    y = rand(20, 400);
    flags = rand(0, 1);
    x = 1000;

    loop
        x--;

        if(collision(type nube) or x < -300)
            nubeshay--;
            break;
        end

        frame;
    end
end

process marcador(icono, x, y)
private
    contador = 0;
    contador2 = 30;
   suena;
begin
    graph = 910;
    z = -10;

    // mostrar icono correspondiente
    marcador_icono(icono, x, y);

    switch(icono)
        case 909:
            textofrutastengo = write_int(1, x, y, 4, &frutastengo); 
        end
        case 908:
 if(tipodetiempo == 2)
                tiempo = 59;
            end
            if(tipodetiempo <> 1 and nivel<17) // en la final no pone tiempo
                textotiempo = write_int(1, x, y, 4, &tiempo);
                activadotiemposonando = 0;
            end
           
        end
        case 995:
            textovidastengo = write_int(1, x, y, 4, &vidastengo);
        end
    end

    loop
    
     if(energia<=60) y--; 
//text_move(textotiempo, x, y);
if (icono==995 )text_move(textovidastengo, x, y); end

if (icono==909 )text_move(textofrutastengo, x, y); end
     if(y<-100) 
     
 break; end 
 
 end
    
    // activar sonido de tiempo agotado cuando queda menos de 12 segundos 
    if(tiempo <6 and activadotiemposonando == 0) activadotiemposonando = 1; suena=sound_play(sonidotiempoagotado); end 
    // resetear indicador de sonido si el tiempo vuelve a ser mayor 
    if(tiempo > 6 and activadotiemposonando == 1) activadotiemposonando = 0; soundchannel_stop(suena); end



        // Manejo del tiempo si no es "sin tiempo" y no hay transición


        frame;
    end
end

process marcador_icono(graph, x, y)
private
    xoriginal;
    yoriginal;
    contadortamañocesta = 0;
    subetiempocontador = 0;
begin
    z = -11;
    x = x - 80;
    xoriginal = x;
    yoriginal = y;

    loop

if(energia<=60) y--; if(y<-100)  break; end end
            // marcador cestita
        if(graph == 909 and frutacogida == 1 and scale.z == 100)
            sound_play(sonidoaumentacestita);
            frutacogida = 2;
        end
 if(nivel<17)
        // marcador reloj
        if(graph == 908 and subetiempo == 1)
            subetiempocontador++;
            tiempo = tiempo + 1;
            if(subetiempocontador >= 30)
                subetiempo = 0;
                subetiempocontador = 0;
            end
        end

        // pequeño temblor si el tiempo es bajo
        if(  activadotiemposonando == 1 and graph == 908)
            x = x + rand(-1, 1);
            y = y + rand(-1, 1);
            frame;
            x = xoriginal;
            y = yoriginal;
        end
end
        frame;
    end
end

process ponetiempoasumar(x, y)
private
    contador = 0;

    methods
        method callback initialize()
        begin
            graph = WRITE_IN_MAP(1, "+30", 4);
        end
begin
    z = -2;
    subetiempo = 1;

    loop
        y--;
        contador++;
        if(contador >= 60) break; end
        frame;
    end
end

process palmera(x,y,cocoizquierdo,cocoderecho,flags)
private
begin
  switch(flags)
    case 0:
      troncopalmera(x,y,flags);
      ramaspalmera(x+2,y-112,flags);
      dureza_del_tronco(x-10, y, size,flags);
    end
    case 1:
      troncopalmera(x,y,flags);
      ramaspalmera(x,y-112,flags);
      dureza_del_tronco(x+10, y, size,flags);
    end
  end


 if(cocoizquierdo)  coco(x-15, y, 0); end;

 if(cocoderecho)  coco(x+15, y, 0); end;



  loop
  frame;
  end
end

process dureza_del_tronco(x, y, size,flags);
begin
  graph=966;
  z=2;
  loop
  if(not collision (type troncopalmera))
    break;
  end
  frame;
  end
end



process dureza_de_la_arena(x, y, size,flags);
begin
  graph=985;
  z=2;
  loop
  if(not collision (type arena))
    break;
  end
  frame;
  end
end

process piedra_grande(x, y, size, flags)
begin
    graph = 983;
    z = -1;
    y = y + 10;

    loop
        frame;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Nombre: ramaspalmera(x, y, flags)                                                                                           //
// Descripción: Representa una fruta que se puede encontrar en el juego; es necesario recoger todas para avanzar       //
//              al siguiente nivel.                                                                                    // 
// Variables:                                                                                                          //
//            tipo          : Indica el tipo de fruta; tipo=1 para manzana, tipo=2 para plátano.                       // 
//            x             : Posición X inicial del gráfico correspondiente al ícono de la fruta.                     // 
//            y             : Posición Y inicial del gráfico correspondiente al ícono de la fruta.                     // 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
process ramaspalmera(x, y, flags)
private
direccion=0;
contador=0;
cocostengo;
misombra;
caeactivado=0;
methods
method callback finalize()
begin
  signal(misombra, s_kill);
end
begin

  graph=graficoinicialramas;
  z=0;
  angle=0;
  misombra=sombra_ramas(x,y+114);
 /* cocostengo = rand(0, 1000);
if(cocostengo<250) cocostengo=0; end
  if(cocostengo>=250 and cocostengo<500) cocostengo=1; end
  if(cocostengo>=500 and cocostengo<800) cocostengo=2; end
  if(cocostengo>=800) cocostengo=3; end
  
  switch(cocostengo)
    case 1:
      coco(x, y+5, 0);
    end
    case 2:
      coco(x-15, y, 0);
      coco(x+15, y, 0);
    end
    case 3:
      coco(x-15, y, 0);
      coco(x, y+5, 0);
      coco(x+15, y, 0);
    end
  end
  */
   
  loop
    contador++;
    if(direccion==0)
      if(contador>=3)
        graph=graph+1;
        contador=0;
        if(graph>=graficofinalramas)
          direccion=1;
        end
      end
    end
    if(direccion==1)
      if(contador>=3)
        graph=graph-1;
        contador=0;
        if(graph<=graficoinicialramas)
          direccion=0;
        end
      end
    end
    if(not collision(type troncopalmera) or caeactivado==1)  
      y=y+10; flags= 2; caeactivado=1;
    end
    if(y<=-100 or y>=900)
      break;
    end
  frame;
  end
end


process troncopalmera(x, y, flags)
private
    toques = 15;
    xguardada;
    yguardada;
    contador = 0;
    direccion;
begin
    graph = 911;
    z = 1;
    y = y + 2;
    xguardada = x;
    yguardada = y;

    loop
        if(collision(type mono) and estoypegando == 1 and toques > 0)
            contador++;
            if(contador >= 4)
                hojaspierdetronco(x, y);
                // mover según posición del mono
                x = xguardada + (xmono > xguardada ? -2 : 2);
                y = yguardada + 2;
                toques--;
            else
                x = xguardada;
                y = yguardada;
            end
        end

        if(toques <= 0)
            // decidir dirección del tronco roto
            direccion = (xmono > xguardada ? 0 : 1);
            Objeto_troncoseva(x, y, size, flags, direccion);
            Objeto_troncoroto(x, y, size, flags);
            break;
        end

        frame;
    end
end

process hojaspierdetronco(x, y)
private
  incremento_de_x;
  velocidad_gravedad1;
  numero_de_hojas;

begin
    y=y-95;
    graph=927;
    z=1;
    from numero_de_hojas=0 TO 3;
      clone
      break;
      end
    end
    incremento_de_x=rand(-10,10);
    velocidad_gravedad=rand(-24,-8);
    numero_de_hojas=60;
    while (numero_de_hojas-->0)
      x+=incremento_de_x;
      y+=velocidad_gravedad;
      velocidad_gravedad+=2;
      frame;
    end
end

process objeto_troncoseva(x, y, size, flags, direccion) // direccion 0=izquierda, 1=derecha
begin
    graph = 952;
    z = -3;

    loop
        // mover según dirección
        x += (direccion == 0 ? -10 : 10);
        y += 10;

        // comprobar salida de pantalla
        if(x <= -100 or x >= 900) break; end

        frame;
    end
end

process objeto_troncoroto(x, y, size, flags)
begin
    graph = 953;
    z = -3;
    loop
        frame;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Nombre: coco(x, y, flags)                                                                                           //
// Descripción: Representa coco                                                                                        //                                                                              // 
// Variables:                                                                                                          //
//            x             : Posición X inicial del gráfico.                                                          // 
//            y             : Posición Y inicial del gráfico.                                                          // 
//            flags         : Indica si apunta hacia la derecha o hacia la izquierda.                                  // 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                                                                                                               
process coco(x, y, flags)
private
contadory=0;
estado=-1;
contadorcogible=0;
begin
  graph=951;
  z=-1;
  y=y-100;
  loop      
    if(not collision(type ramaspalmera) and estado==-1)  
      if(not en_suelo)
         gravedad(20, 20);
      end 
      if(en_suelo)
        estado=0;   
        z=-4;  
      end
    end 
    if(estado>-1)
      contadorcogible++;
    end
      if(estado==0) y++; contadory++; end;
      if(contadory>=10) contadory=0; estado=1; end
      if(estado==1) y--; contadory++; end;
      if(contadory>=10) contadory=0; estado=0; end
      
    if(collision (type mono) and contadorcogible>15) 
      salpicon(3,x,y);
      frutasdentrodelacesta(3,150,50);
      frutastengo += 1;
      break; 
    end
    frame;
    end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Nombre: señalindicador(x,y,direccion)                                                                               //
// Descripción: Ilustración de un cartel de señalización que indica la dirección de un camino,                         //
//              con flechas que apuntan hacia arriba o hacia abajo, simbolizando opciones de trayectoria.              // 
// Variables:                                                                                                          //
//            x             : Posición X inicial del gráfico correspondiente al ícono de la señal.                     // 
//            y             : Posición Y inicial del gráfico correspondiente al ícono de la señal.                     // 
//            direccion     : Indica si la mano dibujada apunta hacia arriba(1) o hacia abajo(2).                      //              
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                         
                                                                                                                         
process señalindicador(x, y, direccion)
private
begin
    flags = x < 400 ? 0 : 1;
    graph = 948 + direccion;
    z = 1;

    loop
        if(collision(type mono))
            señaldireccion = direccion;
        end
        frame;
    end
end




process estatua_mono_oro(x,y)
private
  contador=0;
  contador2=0;
  misombra;
  xoriginal;
  yoriginal;
   estatuadeoro=0;
   sonidoactivado=0;
   
    methods
  method callback finalize()
  begin
    signal(misombra, s_kill);
  end
begin
  estatuaactiva=0; // si esta en 1 permite pasar de nivel
  cogidaestatua=0; 

  graph=986;  
 if(nivel<17) z=1; misombra = sombra(x,y-2,100); else z=-10;    end
 
  y=y+10;
  xoriginal=x;
  yoriginal=y;
  loop
  if (frutaenpantalla>=1 )graph=986; estatuaactiva=0; else graph=964; estatuaactiva=1;   end
 // if (estatuadeoro== 0 and estatuaactiva==1) estatuadeoro=1; sound_play(sonidomonodoradoactivo); frame; end
   if (estatuaactiva==1) estatuadeoro=1; 
   
   if(sonidoactivado==0)
   
   sound_play(sonidomonodoradoactivo); sonidoactivado=1; end frame; end
 
  
    contador2++;
    if(contador2>=5) contador++; contador2=0; end
    if(contador==10)
      x=x+2;
    end
    if(contador==11)
      y=y-2;
    end
    if(contador==12)
      x=x-2; 
    end
    if(contador==13)
      y=y+2;
    end   
    if(contador==14)
      contador=-30;
    end
  

    if(collision (type mono) and estatuaactiva==1)  
    
      sound_play(sonidomonodorado); 
      if(nivel==17)  generador_confeti();             cancionjuegopasado = song_play(cancionjuegopasado,1);
        songchannel_fade(cancionjuegopasado, 1, 5000); 
      
    
      
      else cogidaestatua=1; end

    break;
    end

if(energia<=60) if(y<AlturaTerrenoAbajo) y=y+8; end       end
  frame;
  end
end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Nombre: fruta(tipo, x, y)                                                                                           //
// Descripción: Representa una fruta que se puede encontrar en el juego; es necesario recoger todas para avanzar       //
//              al siguiente nivel.                                                                                    // 
// Variables:                                                                                                          //
//            tipo          : Indica el tipo de fruta; tipo=1 para manzana, tipo=2 para plátano.                       // 
//            x             : Posición X inicial del gráfico correspondiente al ícono de la fruta.                     // 
//            y             : Posición Y inicial del gráfico correspondiente al ícono de la fruta.                     // 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


process fruta(tipo, x, y)
private
    estado = 0;
    contadory = 0;
    id2 = 0;
    misombra;
methods
    method callback finalize()
    begin
        signal(misombra, s_kill);
    end
begin
    y = y - 5;
    frutaenpantalla = frutaenpantalla + 1;

    misombra = sombra(x, y, 100); // (x, y, sizemaximo)
    z = 1;

    // asignar gráfico según tipo
    switch(tipo)
        case 1: graph = 924; end
        case 2: graph = 925; end
    end;

    loop
        // colisión con mono
        if(collision(type mono))
            salpicon(tipo, x, y);
            frutasdentrodelacesta(tipo, 150, 50);
            frutastengo += 1;
            frutaenpantalla -= 1;
            break;
        end

        // movimiento vertical oscilante
        y += (estado == 0 ? 1 : -1);
        contadory++;
        if(contadory >= 10)
            contadory = 0;
            estado = 1 - estado;
        end

        frame;
    end
end
                                                                                                                
process itemtiempo(tipo, x, alturafinal,retardo) // retardo minimo 400
private
  estado=0;
  contadory=0;
  id2 = 0;
  misombra;
  methods
  method callback finalize()
  begin
    signal(misombra, s_kill);
  end
begin
  graph=974;
  
  z=1;  
   switch(tipo)
    case 1:
      y=alturafinal-10;
      misombra = sombra(x,alturafinal-5,100); // (x, y,sizemaximo);
    end
    case 2:
      y=-retardo;
      loop
      if((alturafinal-5)>y) y=y+5; end
      if((alturafinal-5)<=y) break; end
      frame;
      end
      
    end
  end
  loop
 
  if(collision (type mono)) 
    sound_play(sonidocogidabola);
 soundchannel_stop(sonidotiempoagotado);

    subetiempo=1;
    ponetiempoasumar(x, y);
    break; 
  end
  if(estado==0) y++; contadory++; end;
  if(contadory>=10) contadory=0; estado=1; end
  
  if(estado==1) y--; contadory++; end;
  if(contadory>=10) contadory=0; estado=0; end
    
    frame;
    end
end

process sombra(x, y, sizemaximo)
private
    pos_anterior;
begin
    y = y + 10;
    graph = 923;
    z = 1;
    flags = 4;
    size = sizemaximo;
    pos_anterior = father.y;

    loop
        // actualizar posición
        x = father.x;
        if(father.y > pos_anterior)
            size = sizemaximo;
        else
            size = sizemaximo - 5;
        end

        pos_anterior = father.y;
        frame;
    end
end


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Nombre: sombra_ramas(x, y)                                                                                          //
// Descripción: Gráfico que representa la sombra de las ramas de las palmeras.                                         // 
// Variables:                                                                                                          //
//            x          : Posición X inicial del gráfico correspondiente al ícono de las ramas.                       // 
//            y          : Posición Y inicial del gráfico correspondiente al ícono de las ramas.                       // 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

process sombra_ramas(x, y)
private
  graph_de_las_ramas;
  flags_de_las_ramas;
  xoriginal;
begin
  y=y+5;
  xoriginal=x;
  graph=928;
  z=1;  
  flags=4;
  flags_de_las_ramas=father.flags;
    loop 
      graph_de_las_ramas=father.graph;
      if(flags_de_las_ramas==1)
        if(graph_de_las_ramas<=915) x=xoriginal+1; end
        if(graph_de_las_ramas<=921 and graph_de_las_ramas>=916) x=xoriginal; end
        if(graph_de_las_ramas>=920) x=xoriginal-1; end
      end
      if(flags_de_las_ramas==0)
        if(graph_de_las_ramas<=915) x=xoriginal-1; end
        if(graph_de_las_ramas<=921 and graph_de_las_ramas>=916) x=xoriginal; end
        if(graph_de_las_ramas>=920) x=xoriginal+1; end
      end
      frame;
    end
end

process gravedad(offset_sup, offset_inf)

private
    c_suelo = -5197824;
    gravedad_temp;
graficodurezasuelo=926;
begin

if(nivel<17) graficodurezasuelo=926; else graficodurezasuelo=284; end

    father.en_suelo = false;
    gravedad_temp = (father.velocidad_gravedad += 1); // aumenta la gravedad del objeto

    if (gravedad_temp > 2) // y establece un limite de gravedad de 15
        father.velocidad_gravedad = 10;
        gravedad_temp = 5;
    end

    if (gravedad_temp < 0) // si el objeto sube

        while (gravedad_temp++ != 0)           
               father.y--; 
        end

    else 
       if (not father.en_suelo) 
    father.y += gravedad_temp;
end
 
    from gravedad_temp = -5 to 5; // establece un rango de comprobacion
    

 if (map_get_pixel(0, graficodurezasuelo, father.x, (father.y + gravedad_temp + offset_inf)) == c_suelo
     
or map_get_pixel(0, graficodurezasuelo, father.x-5, (father.y + gravedad_temp + offset_inf)) == c_suelo

or map_get_pixel(0, graficodurezasuelo, father.x-+5, (father.y + gravedad_temp + offset_inf)) == c_suelo







 ) // si toca el suelo
      



  father.en_suelo = true; 
        break; // pone en_suelo y sale
    end
    end

    if (gravedad_temp < 9) // ajusta los nuevos valores de y
        father.y += gravedad_temp;
        father.velocidad_gravedad = 0;

    end
 end
end
                                                                                                       
process frutasdentrodelacesta(tipo, x, y)
private
    contador = 0;
begin
    y = y + 5;
    
    // asignar gráfico según tipo
    switch(tipo)
        case 1: graph = 924; end
        case 2: graph = 925; end
        case 3: graph = 951; end
    end;

    x = x - rand(70, 90);
    z = -10;
    flags = rand(0, 1);
    rotation.z = rand(0, 1000);

    loop
        if(contador < 10)
            contador++;
            y--;
        end
        frame;
    end
end  
  
  
  


process salpicon(tipo, x, y)
private
    contador = 0;
    fx_advancedtype_tint tint;
    limite = 0;
begin
    // inicialización según tipo
    switch(tipo)
        case 1:
            y -= 30;
            sound_play((frutastengo % 2) ? sonidomonocoge1 : sonidomonocoge2);
            graph = 939;
            limite = 946;
        end

        case 2:
            y -= 30;
            sound_play((frutastengo % 2) ? sonidomonocoge1 : sonidomonocoge2);
            graph = 929;
            limite = 936;
        end

        case 3:
            y -= 30;
            sound_play((frutastengo % 2) ? sonidomonocoge1 : sonidomonocoge2);
            graph = 954;
            limite = 961;
        end

        case 4:
            sound_play(sonidosalpicaagua);
            graph = 954;
            limite = 961;
            fx.mode = fx_advanced;
            fx.fxref = &tint;
            tint.color = 0x7f0082ff;
        end

        case 5:
            graph = 954;
            limite = 961;
        end
    end

    // bucle de animación
    loop
        contador++;
        if(contador >= 1)
            graph++;
            contador = 0;
        end

        // fruta recogida (tipos 1, 2, 3)
        if((tipo == 1 or tipo == 2 or tipo == 3) and graph >= limite)
            frutacogida = 1;
            break;
        end

        // fin directo (tipos 4, 5)
        if((tipo == 4 or tipo == 5) and graph >= limite)
            break;
        end

        frame;
    end
end

process salpiconsangre(x, y)
private
    contador = 0;
begin
    sound_play((frutastengo % 2) ? sonidomonocoge1 : sonidomonocoge2);
    y = y - 30;
    graph = 934;

    loop
        contador++;
        y++;

        if(contador >= 2)
            graph++;
            contador = 0;
        end

        if(graph >= 938) break; end
        frame;
    end
end                                                                                                                
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Nombre: mono(x, y, flags, numeromono)                                                                               //
// Descripción: Proceso que gestiona al protagonista del juego.                                                        //
// Variables:                                                                                                          //
//            x          : Posición X inicial del mono.                                                                //
//            y          : Posición Y inicial del mono.                                                                //
//            flags      : Indica la orientación horizontal del mono (derecha o izquierda).                            //
//            numeromono : Representa el número del mono que aparecerá en la pantalla.                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






process tela_de_araña_que_no_se_va(x, y);
begin
  graph=965;
  z=-1;
  y=y-40;
  loop
  frame; 
  end 
end     
     

process arena(x, y);
begin
    graph = 984;
    z = 1;
    y = y + 17;

    if(tipoinmortal == 2)
        dureza_de_la_arena(x, y, size, flags);
    end

    loop
        frame;
    end
end

process generadordecajas();
private
  tiempogenerando=0;
  velocidad;
begin

numerodecajas=0; // asi controlamos que las cajas que caen últimas se ponen encima del grafico de las primeras para apilarlas
frutaenpantalla = frutaenpantalla + 1;         
 
  loop
    tiempogenerando=tiempogenerando+1;
    
    
    switch(nivel)

    case 3: 
      velocidad=2;
      if(tiempogenerando==50) caja(200, -100,velocidad,0,1); end
      if(tiempogenerando==150) caja(400, -100,velocidad,0,1); end
      if(tiempogenerando==250) frutaenpantalla = frutaenpantalla - 1;  caja(700, -100,velocidad,0,1);  end    
    end
    
    case 6: 
      velocidad=3;
      if(tiempogenerando==50) caja(300, -100,velocidad,0,1); end
      if(tiempogenerando==150) caja(400, -100,velocidad,0,2); end
      if(tiempogenerando==250) caja(700, -100,velocidad,0,1); end
      if(tiempogenerando==300) caja(450, -100,velocidad,0,2); end
      if(tiempogenerando==350) frutaenpantalla = frutaenpantalla - 1;  caja(250,-100,velocidad,0,1); end   
    end
    
     case 9: 
     velocidad=4;
      if(tiempogenerando==50) caja(400, -100,velocidad,0,1); end
      if(tiempogenerando==150) caja(700, -100,velocidad,0,1); end
      if(tiempogenerando==250) caja(700, -100,velocidad,0,2); end
      if(tiempogenerando==300) caja(300, -100,velocidad,0,1); end
      if(tiempogenerando==350) caja(100,-100,velocidad,0,3); end   
      if(tiempogenerando==400)caja(400,-100,velocidad,0,3); end
      if(tiempogenerando==450)caja(500,-100,velocidad,0,3); end
      if(tiempogenerando==550)caja(300,-100,velocidad,0,2); end
      if(tiempogenerando==550)frutaenpantalla = frutaenpantalla - 1; caja(500,-100,velocidad,0,2); end
     end     
    case 12: 
      velocidad=5;
      if(tiempogenerando==50) caja(700, -100,velocidad,0,3); end
      if(tiempogenerando==150) caja(100, -100,velocidad,0,3); end
      if(tiempogenerando==300) caja(600, -100,velocidad,0,3); end
      if(tiempogenerando==350) caja(100,-100,velocidad,0,2); end   
      if(tiempogenerando==400)caja(400,-100,velocidad,0,1); end
      if(tiempogenerando==450)caja(200,-100,velocidad,0,3); end
      if(tiempogenerando==550)caja(300,-100,velocidad,0,1); end
      if(tiempogenerando==550)frutaenpantalla = frutaenpantalla - 1;  caja(400,-100,velocidad,0,3); end
     end   
    case 15: 
      velocidad=5;
 //     if(tiempogenerando==50) caja(100, -100,velocidad,0,1); end
      if(tiempogenerando==100) caja(300, -100,velocidad,0,3); end
      if(tiempogenerando==150) caja(700, -100,velocidad,0,1); end
         if(tiempogenerando==200) caja(100,-100,velocidad,0,2); end   
     if(tiempogenerando==200)caja(500,-100,velocidad,0,2); end
      if(tiempogenerando==300)caja(100,-100,velocidad,0,3); end
     if(tiempogenerando==300)caja(300,-100,velocidad,0,2); end
      if(tiempogenerando==300)caja(500,-100,velocidad,0,3); end
      if(tiempogenerando==450)frutaenpantalla = frutaenpantalla - 1;  caja(700,-100,velocidad,0,2); end
      if(tiempogenerando==550)caja(500,-100,velocidad,0,1); end
     end
    end   
  frame; 
  end 
end     
  
process caja(x, y, velocidad, se_separa, suelodonderompe);
private
    choca = 0;
    cuentaeny = 0;
    suelodondechoca;
begin
    graph = 991;
    numerodecajas = numerodecajas + 1;
    z = -10 - numerodecajas;

    if(suelodonderompe == 1) suelodondechoca = AlturaTerrenoAbajo - 10; end
    if(suelodonderompe == 2) suelodondechoca = AlturaTerrenoMedio - 10; end
    if(suelodonderompe == 3) suelodondechoca = AlturaTerrenoArriba - 10; end

    loop
        // caída de la caja
        if(y < suelodondechoca and cuentaeny < 20)
            y = y + velocidad;
            if(collision(type cajarota))
                cuentaeny = cuentaeny + 1;
            end
        end

        // al llegar al suelo
        if(y >= suelodondechoca and choca <> 1)
            choca = 1;
            fruta(2, x, suelodondechoca + 10);
        end

        // ejecutar efecto de cajarota y terminar
        if(choca == 1)
            cajarota(x, y, velocidad, 992, se_separa);
            cajarota(x, y, velocidad, 993, se_separa);
            break;
        end

        frame;
    end
end


process cajarota(x, y, velocidad, graph, se_separa)
private
    contadordesaparece = 0;
    contadorparpadeo = 0;
begin
se_separa=1;
    loop
        // mover caja si se separa
        if(se_separa == 1)
            if(graph == 992)
                x = x - 2; y = y + 2;
            else
                x = x + 2; y = y + 2;
            end
        end

        // contar desaparición si no es inmortal
    //    if(tipoinmortal <> 2)
   //         contadordesaparece++;
   //     end

        // parpadeo
        contadorparpadeo++;
        flags = (contadorparpadeo < 2 ? 0 : 4);
        if(contadorparpadeo > 5)
            contadorparpadeo = 0;
        end

        // romper loop si toca desaparecer
        if(tipoinmortal <> 2 and contadordesaparece > 25)
            break;
        end

        frame;
    end
end 

process jugar();
private
    cancionsonando;
    cancionsonando2;
begin
    // Detener canción del menú
    SONGCHANNEL_FADE(cancionmenu, 0, 100); 

    // Reproducir canción de juego
    cancionsonando = song_play(cancionjugando001, 1);
    songchannel_fade(cancionsonando, 1, 5000); 

    // Inicializar variables del juego
    tiempo = 59;
    frutaenpantalla = 0;                 
    frutastengo = 0;
    frutacogida = 0;  // Indica que se ha recogido una fruta temporalmente
    nivel = 1;
    subetiempo = 0;
    cogidaestatua = 0;
    vidastengo=3;
    repeat
        switch (nivel)
          case 1:

    
    sueloycielo(2,1);
    control_del_nivel();   

    idmono = mono(200, AlturaTerrenoMedio, 0, 1);
    palmera(100, AlturaTerrenoMedio, 1, 0, 0);
    palmera(700, AlturaTerrenoMedio, 0, 0, 1);

    fruta(2, 500, AlturaTerrenoMedio);
    estatua_mono_oro(600, AlturaTerrenoMedio);

    piedra_grande(20, AlturaTerrenoMedio, size, 1);
    piedra_grande(780, AlturaTerrenoMedio, size, 0);
    arena(400, AlturaTerrenoMedio);


    if(tipodetiempo == 3) 
        itemtiempo(1, 150, AlturaTerrenoMedio, 5); 
    end
         end

      

      case 2:
        cancionsonando = song_play(cancionjugando002,1);
        songchannel_fade(cancionsonando, 1, 5000); 
        
sueloycielo(1,1);
sueloycielo(2,1);
 piedra_grande(5, AlturaTerrenoAbajo, size, 1);
        control_del_nivel();
        idmono=mono(700, AlturaTerrenoAbajo,1,establecenuevomono); 
        palmera(100,AlturaTerrenoAbajo,1,1,0);     
        palmera(700,AlturaTerrenoMedio,0,0,1);
        fruta(2,200,AlturaTerrenoMedio);
        fruta(1,300,AlturaTerrenoMedio);
        fruta(2,400,AlturaTerrenoMedio);
        hojastrampa(500, AlturaTerrenoMedio);
        fruta(2,600,AlturaTerrenoMedio);
        fruta(1,400,AlturaTerrenoAbajo);
        fruta(2,500,AlturaTerrenoAbajo);
        fruta(1,600,AlturaTerrenoAbajo);
        fruta(2,300,AlturaTerrenoAbajo);
        mosquito(100,160,AlturaTerrenoAbajo,-2);
        señalindicador(750,AlturaTerrenoAbajo,1);
        señalindicador(50,AlturaTerrenoMedio,2);
        estatua_mono_oro(200,AlturaTerrenoAbajo);
        tela_de_araña_que_no_se_va(35, AlturaTerrenoAbajo);
        piedra_grande(750, AlturaTerrenoMedio, size,0);
      end
      
      case 3: // cajas
 
        cancionsonando = song_play(cancionjugando003,1);
        songchannel_fade(cancionsonando, 1, 5000);
        
sueloycielo(1,1);

        control_del_nivel();
        idmono=mono(700, AlturaTerrenoAbajo,1,establecenuevomono);
        generadordecajas();
        estatua_mono_oro(100,AlturaTerrenoAbajo);
        piedra_grande(10, AlturaTerrenoAbajo, size,0);
        piedra_grande(800, AlturaTerrenoAbajo, size,0);
      end   
       
                       

      case 4:
        cancionsonando = song_play(cancionjugando003,1);
        songchannel_fade(cancionsonando, 1, 5000); 
        
sueloycielo(1,1);
sueloycielo(2,1);

        control_del_nivel();
        idmono=mono(100, AlturaTerrenoMedio,0,establecenuevomono); //numeromono= 1,2 o 3.
        palmera(600,AlturaTerrenoMedio,1,1,0);
        palmera(700,AlturaTerrenoMedio,1,1,1); 
        fruta(1,300,AlturaTerrenoMedio);
        fruta(1,400,AlturaTerrenoMedio);
        if (tipodetiempo==3)itemtiempo(1, 500, AlturaTerrenoMedio,5); end
        fruta(2,300,AlturaTerrenoAbajo);
        fruta(2,400,AlturaTerrenoAbajo);
        fruta(2,500,AlturaTerrenoAbajo);
        señalindicador(750,AlturaTerrenoAbajo,1);
        piedra_grande(20, AlturaTerrenoAbajo, size,1);
        señalindicador(50,AlturaTerrenoMedio,2); 
        bola_cambio_mono(500, AlturaTerrenoAbajo, 3);   
 

        estatua_mono_oro(200,AlturaTerrenoAbajo);
        mosquito(200,400,AlturaTerrenoMedio,2);
        tela_de_araña_que_no_se_va(650, AlturaTerrenoMedio);       
        piedra_grande(780, AlturaTerrenoMedio, size,0);
      end   
      
       case 5:
        cancionsonando = song_play(cancionjugando004,1);
        songchannel_fade(cancionsonando, 1, 5000); 
        mosquito(200,500,AlturaTerrenoMedio,2);
        
       sueloycielo(1,1);
sueloycielo(2,1);
sueloycielo(3,1);
        control_del_nivel();
        idmono=mono(300, AlturaTerrenoMedio,0,establecenuevomono); 
        palmera(300,AlturaTerrenoArriba,0,0,0);
        fruta(1,100,AlturaTerrenoArriba);
        fruta(1,200,AlturaTerrenoArriba);
        fruta(2,400,AlturaTerrenoArriba);
        fruta(2,600,AlturaTerrenoArriba);
        fruta(1,700,AlturaTerrenoArriba);
        fruta(1,100,AlturaTerrenoMedio);
        fruta(2,200,AlturaTerrenoMedio);
        fruta(2,400,AlturaTerrenoMedio);
        fruta(1,500,AlturaTerrenoMedio);      
        if(tipoinmortal==1) fruta(1,600,AlturaTerrenoMedio); else  hojastrampa(600, AlturaTerrenoMedio); end
        fruta(2,700,AlturaTerrenoMedio);
        fruta(2,100,AlturaTerrenoAbajo);
        if(tipoinmortal==1) fruta(1,200,AlturaTerrenoAbajo); else  hojastrampa(200, AlturaTerrenoAbajo); end
        fruta(2,300,AlturaTerrenoAbajo);
        fruta(1,400,AlturaTerrenoAbajo);
        fruta(1,600,AlturaTerrenoAbajo);
        fruta(2,700,AlturaTerrenoAbajo);
        
        señalindicador(50,AlturaTerrenoAbajo,1);
        señalindicador(750,AlturaTerrenoAbajo,1);       
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);       
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2); 
        
        
        estatua_mono_oro(500,AlturaTerrenoArriba);
        bola_cambio_mono(500, AlturaTerrenoAbajo, 2);   
      end 
 
 
      case 6: // cajas
aguila(850,200,5);
        cancionsonando = song_play(cancionjugando003,1);
        songchannel_fade(cancionsonando, 1, 5000);
        
    sueloycielo(1,1);
sueloycielo(2,1);

        
        control_del_nivel();
        idmono=mono(700, AlturaTerrenoAbajo,1,establecenuevomono);
        generadordecajas();
        estatua_mono_oro(200,AlturaTerrenoMedio);
//        piedra_grande(10, AlturaTerrenoAbajo, size,0);
        piedra_grande(700, AlturaTerrenoMedio, size,0);
        piedra_grande(10, AlturaTerrenoAbajo, size,0);
        señalindicador(750,AlturaTerrenoAbajo,1);       
        señalindicador(50,AlturaTerrenoMedio,2);
      
      end    
  
      case 7:
        cancionsonando = song_play(cancionjugando005);
        songchannel_fade(cancionsonando, 1, 5000); 
        
     sueloycielo(1,1);
sueloycielo(2,1);
sueloycielo(3,1);
        arena(300, AlturaTerrenoMedio);
        arena(600, AlturaTerrenoMedio);
        control_del_nivel();
        idmono=mono(300, AlturaTerrenoAbajo,0,establecenuevomono);
        palmera(500,AlturaTerrenoAbajo,0,0,1);              
        if(tipoinmortal==1) piedra_grande(500, AlturaTerrenoArriba, size,0);   else  fruta(1,600,AlturaTerrenoArriba);  palmera(500,AlturaTerrenoArriba,0,0,1); end
        fruta(2,400,AlturaTerrenoArriba);
        fruta(2,100,AlturaTerrenoAbajo);
        fruta(1,200,AlturaTerrenoAbajo);
        fruta(1,400,AlturaTerrenoAbajo);
        if (tipodetiempo==3)itemtiempo(1, 600, AlturaTerrenoAbajo,5); else fruta(1,600,AlturaTerrenoAbajo); end
        señalindicador(50,AlturaTerrenoAbajo,1);
  
        señalindicador(750,AlturaTerrenoAbajo,1);       
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);  
        
     
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2);
        
        estatua_mono_oro(300,AlturaTerrenoArriba);
       
        bola_cambio_mono(450, AlturaTerrenoArriba, 2);
        if (tipodetiempo==3)itemtiempo(1, 100, AlturaTerrenoArriba,5);  end

   
      end   
           
      case 8:
        cancionsonando = song_play(cancionjugando006,1);
        songchannel_fade(cancionsonando, 1, 5000); 
        
       sueloycielo(1,1);
sueloycielo(2,1);
sueloycielo(3,1);
        control_del_nivel();
        idmono=mono(300, AlturaTerrenoAbajo,0,establecenuevomono);
        mosquito(600,400,AlturaTerrenoMedio,-2);
        mosquito(100,600,AlturaTerrenoAbajo,2);
        palmera(100,AlturaTerrenoAbajo,0,0,0);        
        if(tipoinmortal==1) fruta(1,200,AlturaTerrenoMedio);  else  palmera(200,AlturaTerrenoMedio,0,0,1); end
        palmera(300,AlturaTerrenoMedio,0,0,1); 
        palmera(500,AlturaTerrenoArriba,0,0,1);
        fruta(1,100,AlturaTerrenoArriba);
        fruta(1,200,AlturaTerrenoArriba);
        fruta(2,600,AlturaTerrenoArriba);
        fruta(2,700,AlturaTerrenoArriba);
        fruta(1,100,AlturaTerrenoMedio);
        fruta(1,400,AlturaTerrenoMedio);
        fruta(1,500,AlturaTerrenoMedio);
        fruta(1,600,AlturaTerrenoMedio);
        fruta(1,700,AlturaTerrenoMedio);
        fruta(1,200,AlturaTerrenoAbajo);
        fruta(1,400,AlturaTerrenoAbajo);
        fruta(1,600,AlturaTerrenoAbajo);
        señalindicador(50,AlturaTerrenoAbajo,1);
        señalindicador(750,AlturaTerrenoAbajo,1);
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2);
        estatua_mono_oro(400,AlturaTerrenoArriba); 
  //    tela_de_araña_que_no_se_va(300, AlturaTerrenoArriba);
        Objeto_spider(600,300,AlturaTerrenoArriba-50,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);
        Objeto_spider(100,700,AlturaTerrenoAbajo-50,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);
      end             
      
      case 9: // cajas
aguila(850,200,5);
        cancionsonando = song_play(cancionjugando003,1);
        songchannel_fade(cancionsonando, 1, 5000);
        if (tipodetiempo==3)itemtiempo(1, 400, AlturaTerrenoMedio,5);  end
       sueloycielo(1,1);
sueloycielo(2,1);
sueloycielo(3,1);
                señalindicador(50,AlturaTerrenoAbajo,1);
        señalindicador(750,AlturaTerrenoAbajo,1);
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2);
        control_del_nivel();
        idmono=mono(700, AlturaTerrenoAbajo,1,establecenuevomono);
        generadordecajas();
        estatua_mono_oro(100,AlturaTerrenoAbajo);
   //     piedra_grande(10, AlturaTerrenoAbajo, size,0);
     //   piedra_grande(10, AlturaTerrenoMedio, size,0);
      end    

      case 10:
        cancionsonando = song_play(cancionjugando007,1);
        songchannel_fade(cancionsonando, 1, 5000); 
        
       sueloycielo(1,1);
       sueloycielo(2,1);
       sueloycielo(3,1);
        control_del_nivel();
        idmono=mono(300, AlturaTerrenoAbajo,0,establecenuevomono);
        palmera(100,AlturaTerrenoAbajo,0,0,0);
        palmera(200,AlturaTerrenoMedio,0,0,1);
        palmera(500,AlturaTerrenoMedio,0,0,1);
        palmera(500,AlturaTerrenoArriba,0,0,1);      
        palmera(700,AlturaTerrenoArriba,0,0,1);
        fruta(1,100,AlturaTerrenoArriba);
        fruta(1,200,AlturaTerrenoArriba);
        fruta(1,400,AlturaTerrenoArriba);
     
        fruta(1,100,AlturaTerrenoMedio);
        fruta(1,300,AlturaTerrenoMedio);
        fruta(1,400,AlturaTerrenoMedio);
        fruta(1,600,AlturaTerrenoAbajo);
        señalindicador(50,AlturaTerrenoAbajo,1);
        señalindicador(750,AlturaTerrenoAbajo,1);    
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);     
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2);
        estatua_mono_oro(300,AlturaTerrenoArriba);    
        tela_de_araña_que_no_se_va(500, AlturaTerrenoAbajo);
        bola_cambio_mono(600, AlturaTerrenoArriba, 2);
        bola_cambio_mono(400, AlturaTerrenoAbajo, 2);
         if (tipodetiempo==3)itemtiempo(1, 600, AlturaTerrenoArriba,5);else fruta(1,600,AlturaTerrenoMedio);  end
      end     


   case 11: 
        cancionsonando = song_play(cancionjugando006,1);
        songchannel_fade(cancionsonando, 1, 5000); 
        
     sueloycielo(1,1);

        control_del_nivel();   
        idmono=mono(200, AlturaTerrenoAbajo,0,establecenuevomono); //numeromono= 1,2 o 3.
        mosquito(300,400,AlturaTerrenoArriba,2);
        mosquito(300,400,AlturaTerrenoMedio,-2);
        mosquito(100,800,AlturaTerrenoAbajo,2);
        mosquito(100,0,AlturaTerrenoAbajo,-2);
     //   itemtiempo(2, 300, AlturaTerrenoAbajo,400);
 
        palmera(100,AlturaTerrenoAbajo,0,0,0);
        palmera(600,AlturaTerrenoAbajo,0,0,1);
        fruta(2,300,AlturaTerrenoAbajo);
        fruta(2,500,AlturaTerrenoAbajo);
        estatua_mono_oro(700,AlturaTerrenoAbajo);
        piedra_grande(20, AlturaTerrenoAbajo, size,1);
        piedra_grande(780, AlturaTerrenoAbajo, size,0);
        Objeto_spider(250,200,AlturaTerrenoAbajo-50,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);
        Objeto_spider(350,400,AlturaTerrenoAbajo-50,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);
        Objeto_spider(450,600,AlturaTerrenoAbajo-50,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);
   
      end

      case 12: // cajas
aguila(850,200,5);
        cancionsonando = song_play(cancionjugando003,1);
        songchannel_fade(cancionsonando, 1, 5000);
        
       sueloycielo(1,1);
sueloycielo(2,1);
sueloycielo(3,1);
        control_del_nivel();
        idmono=mono(700, AlturaTerrenoAbajo,1,establecenuevomono);
        generadordecajas();
        estatua_mono_oro(100,AlturaTerrenoAbajo);
 
     

                señalindicador(50,AlturaTerrenoAbajo,1);
        señalindicador(750,AlturaTerrenoAbajo,1);
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2);
      end    

      case 13:
        cancionsonando = song_play(cancionjugando005,1);
        songchannel_fade(cancionsonando, 1, 5000); 
        
       sueloycielo(1,1);
sueloycielo(2,1);
sueloycielo(3,1);
        control_del_nivel();
        idmono=mono(300, AlturaTerrenoAbajo,0,establecenuevomono);
        mosquito(600,400,AlturaTerrenoMedio,-2);
        mosquito(100,600,AlturaTerrenoAbajo,2);
        palmera(100,AlturaTerrenoAbajo,0,0,0);
        palmera(200,AlturaTerrenoMedio,0,0,1);
        palmera(300,AlturaTerrenoMedio,0,0,1);
        palmera(500,AlturaTerrenoArriba,0,0,1);
        fruta(1,200,AlturaTerrenoArriba);
        fruta(2,600,AlturaTerrenoArriba);
        fruta(2,700,AlturaTerrenoArriba);
        fruta(1,100,AlturaTerrenoMedio);
        fruta(1,500,AlturaTerrenoMedio);
        fruta(1,600,AlturaTerrenoMedio);
        fruta(1,700,AlturaTerrenoMedio);
        fruta(1,200,AlturaTerrenoAbajo);
        //fruta(2,300,AlturaTerrenoAbajo);
        fruta(1,400,AlturaTerrenoAbajo);
        fruta(1,600,AlturaTerrenoAbajo);

  
        estatua_mono_oro(400,AlturaTerrenoMedio);

          señalindicador(50,AlturaTerrenoAbajo,1);
        señalindicador(750,AlturaTerrenoAbajo,1);
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2);

     
  //      tela_de_araña_que_no_se_va(300, AlturaTerrenoArriba);
        Objeto_spider(600,300,AlturaTerrenoArriba-50,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);
        Objeto_spider(100,700,AlturaTerrenoAbajo-50,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);
        bola_cambio_mono(600, AlturaTerrenoArriba, 1);
        bola_cambio_mono(200, AlturaTerrenoAbajo, 2);
        bola_cambio_mono(600, AlturaTerrenoMedio, 3);
        bola_cambio_mono(400, AlturaTerrenoAbajo, 1);
      end             


    case 14: 
        cancionsonando = song_play(cancionjugando004,1);
        songchannel_fade(cancionsonando, 1, 5000);
   //     mosquito(200,500,AlturaTerrenoAbajo,3);
  //  Objeto_spider(50,300,300,5);  //Objeto_spider(retardo,xtela,ytela,velocidadbajando);

        
       sueloycielo(1,1);

        control_del_nivel();   
        idmono=mono(200, AlturaTerrenoAbajo,0,1); //numeromono= 1,2 o 3.
         mosquito(50,700,AlturaTerrenoMedio,2);
         mosquito(50,100,AlturaTerrenoArriba,-2);
     //   itemtiempo(2, 300, AlturaTerrenoAbajo,400);
 
        palmera(100,AlturaTerrenoAbajo,0,0,0);
        palmera(700,AlturaTerrenoAbajo,0,0,1);
        fruta(2,300,AlturaTerrenoAbajo);
        fruta(2,500,AlturaTerrenoAbajo);
        estatua_mono_oro(600,AlturaTerrenoAbajo);
        piedra_grande(20, AlturaTerrenoAbajo, size,1);
        piedra_grande(780, AlturaTerrenoAbajo, size,0);
      end
      
      case 15: // cajas
aguila(850,200,5);
            cancionsonando = song_play(cancionjugando003,1);
        songchannel_fade(cancionsonando, 1, 5000);
        
      sueloycielo(1,1);
sueloycielo(2,1);
sueloycielo(3,1);
        hojastrampa(200, AlturaTerrenoMedio);
        hojastrampa(400, AlturaTerrenoMedio);
        hojastrampa(600, AlturaTerrenoMedio);
        hojastrampa(200, AlturaTerrenoArriba);
        hojastrampa(400, AlturaTerrenoArriba);
        hojastrampa(600, AlturaTerrenoArriba);
        control_del_nivel();
        idmono=mono(700, AlturaTerrenoAbajo,1,establecenuevomono);
        generadordecajas();
        estatua_mono_oro(100,AlturaTerrenoAbajo);
  

        señalindicador(50,AlturaTerrenoAbajo,1);
        señalindicador(750,AlturaTerrenoAbajo,1);
        señalindicador(50,AlturaTerrenoMedio,2);
        señalindicador(750,AlturaTerrenoMedio,1);
        señalindicador(50,AlturaTerrenoArriba,2);
        señalindicador(750,AlturaTerrenoArriba,2);

      end        
      
      case 16:
        cancionsonando = song_play(cancionjugando003,1);
        songchannel_fade(cancionsonando, 1, 5000);
         
        sueloycielo(3,1);
        control_del_nivel();
        idmono=mono(100, AlturaTerrenoArriba,0,establecenuevomono);
  
        palmera(200,AlturaTerrenoArriba,0,0,1);
        palmera(300,AlturaTerrenoArriba,0,0,1);
        palmera(400,AlturaTerrenoArriba,0,0,1);
        fruta(2,600,AlturaTerrenoArriba);
        estatua_mono_oro(700,AlturaTerrenoArriba);
        piedra_grande(20, AlturaTerrenoArriba, size,0);
        piedra_grande(800, AlturaTerrenoArriba, size,0);
        mosquito(200,600,200,2);
        mosquito(200,500,300,2);
        mosquito(200,400,400,2);
        mosquito(200,300,500,2);
        mosquito(200,200,600,2);

      end        
      case 17:
       
        cancionsonando = song_play(cancionfinal,1);
        songchannel_fade(cancionsonando, 1, 5000);   
       
        
         // Inicializar variables del nivel final
    totem_x_original = 400;
    totem_x_actual = 400;
    totem_y = 100;
    totem_golpeado = 0;
    estaca_sup_activa = 0;
    tiempo_estaca_sup = 0;
    estaca_inf_activa = 0;
    tiempo_estaca_inf = 0;
    toques_restantes = 10;
    // Crear el tótem
  palmera(730, AlturaTerrenoMedio, 0, 0, 1);      
   barra_energia_fondo();
   totem_final();
    idmono = mono(210, AlturaTerrenoMedio, 0, 1);
    sueloycielo(1,1);   
    sueloycielo(4,0);
control_del_nivel();
estatua_mono_oro(590,410);


    marcador(995,650,50); // corazones

  chorrodeagua();
         
     end


  end
  fin_nivel=false;
  repeat
    if (cogidaestatua == 1) 
      cogidaestatua = 2;
      delete_text(textotiempo);
      delete_text(textofrutastengo);  
      delete_text(textovidastengo);     
      transicion(1);
             
        
          end
          if (cogidaestatua == 2 and contadortransicion<5)
          eliminacosas();
              
              
              fin_nivel = true; 
           end
          frame;
        until(fin_nivel==true);
    until (nivel == 100); // no cierra el juego hasta llegar al nivel 100
end


process eliminacosas()
begin
frutaenpantalla=0;
signal(TYPE aguila, s_kill);
signal(TYPE arena, s_kill);
signal(TYPE barra_energia, s_kill);
signal(TYPE basearribachorrodeagua, s_kill);
signal(TYPE bola_cambio_mono, s_kill);
signal(TYPE caja, s_kill);
signal(TYPE cajarota, s_kill);
signal(TYPE chorrodeagua, s_kill);
signal(TYPE coco, s_kill);
signal(TYPE control_del_nivel, s_kill);

signal(TYPE dureza_de_la_arena, s_kill);
signal(TYPE dureza_del_tronco, s_kill);
signal(TYPE estatua_mono_oro, s_kill);
signal(TYPE estaca_linea_final, s_kill);
signal(TYPE estaca_parabola_final, s_kill);
signal(TYPE fruta, s_kill);
signal(TYPE frutasdentrodelacesta, s_kill);
signal(TYPE generador_de_nubes, s_kill);
signal(TYPE generadordecajas, s_kill);
signal(TYPE gravedad, s_kill);
signal(TYPE hojastrampa, s_kill);
signal(TYPE itemtiempo, s_kill);
signal(TYPE lanzadora_lineal, s_kill);
signal(TYPE lanzadora_parabola, s_kill);
signal(TYPE marcador, s_kill);
signal(TYPE marcador_icono, s_kill);
signal(TYPE mono, s_kill);
signal(TYPE mosquito, s_kill);
signal(TYPE nube, s_kill);
signal(TYPE objeto_troncoroto, s_kill);
signal(TYPE Objeto_spider, s_kill);
signal(TYPE Objeto_spiderseva, s_kill);
signal(TYPE piedra_grande, s_kill);
signal(TYPE pinchos, s_kill);
signal(TYPE ramaspalmera, s_kill);
signal(TYPE señalindicador, s_kill);
signal(TYPE sombra, s_kill);
signal(TYPE sombra_ramas, s_kill);
signal(TYPE sueloycielo, s_kill);
signal(TYPE tela_de_araña_que_no_se_va, s_kill);
signal(TYPE totem_final, s_kill);
signal(TYPE troncopalmera, s_kill);
signal(TYPE barra_energia_fondo, s_kill);

    frame;
end

   



process cuatrotransicion(graph, x, y);
private
  velocidadtransicion=25;
begin
  z=-100; 
  switch (graph)
    case 970: 
      loop
        if(x<0)   x=x+velocidadtransicion; end
        if(contadortransicion<1) break; end
      frame; 
      end 
    end   
    case 971: 
      loop
        if(x>0)   x=x-velocidadtransicion; ;end
        if(contadortransicion<1) break; end
      frame;  
      end
    end
    case 972: 
      loop
        if(x<0)   x=x+velocidadtransicion; end
        if(contadortransicion<1) break; end
      frame; 
      end 
    end
    case 973: 
      loop
        if(x>0)   x=x-velocidadtransicion; end
        if(contadortransicion<1) break; end
      frame; 
      end 
    end
  end
  frame;
end


process transicion(tipotransicion);
private
textonivel;
textovariablenivel;
mostrartextos=0;
begin
  SONGCHANNEL_FADE(cancionmenu, 0, 100); 
  switch(tipotransicion) 
    case 1: // transicion pasa de al siguiente nivel 
      nivel++;
      transicionactivada=1;
      contadortransicion=140;
      sound_play(pasonivel);
      cuatrotransicion(970,-800, 0);
      cuatrotransicion(971,800, 150);
      cuatrotransicion(972,-800, 300);
      cuatrotransicion(973,800, 450);
      loop
        contadortransicion--;
        if(contadortransicion<110 and mostrartextos==0)  
          mostrartextos=1;
        end
       if(mostrartextos==1) 
         mostrartextos=2;
         textonivel=write(2, 400, 280, 4, "NIVEL");
         textovariablenivel=write_int(2, 400, 350, 4, &nivel);
       end
       if(contadortransicion<=0) 
        delete_text(textonivel); 
        delete_text(textovariablenivel);
if(tipoinmortal==2 and nivel<17) 
  
  if(tipodetiempo>1)marcador(995,400,50); // corazones MARIOIDEACORAZONES en el centro 
  
  else
  
  marcador(995,650,50); // corazones MARIOIDEACORAZONES a la derecha
  end
  
  
  end
        marcador(909,150,50);
        if(tipodetiempo<>1 and nivel<17)
         marcador(908,650,50);
        end 
        transicionactivada=0;        
        break;
       end
     frame;
     end
    end
    case 2: // transicion tiempo agotado
delete_text(textofrutastengo); 
delete_text(textotiempo); 
      contadortransicion=140;
      sound_play(pasonivel);
      cuatrotransicion(970,-800, 0);
      cuatrotransicion(971,800, 150);
      cuatrotransicion(972,-800, 300);
      cuatrotransicion(973,800, 450);
      loop
        contadortransicion--;
        if(contadortransicion<110 and mostrartextos==0) 
          mostrartextos=1;
        end
       if(mostrartextos==1) 
      delete_text(textotiempo);
      delete_text(textofrutastengo);    
         eliminacosas(); 
         mostrartextos=2;
         texto4 = write(2, 410, 280, 1, "¡Se acabó el tiempo!");
         nivel = 0;
         
       end
       if(contadortransicion<=0) 
        delete_text(texto4); 
        transicionactivada=0;     
        logogemix();
        break;
       end
     frame;
     end
    end 
  end
end


process mosquito(retardo,x,y,velocidad)
private
  contador=0;
  distanciaconelmono;
  sonidomosquitoactivado=0;
  picadomono=0;

begin


           graph=975;
  y=y-110;
  z=-11;
  if(velocidad<0) flags=1; end

  loop

    distanciaconelmono = get_dist(idmono);

    contador++;
    if(contador>5) graph=976; else graph=975; end  
    if(contador>10) contador=0; end   
    if(retardo>=0)retardo--; end
    if(retardo<=0 or distanciaconelmono<120)  
      x=x-velocidad;   
      if(x<-100 or x>900) break; end
       if(distanciaconelmono<200)
         
       
          if(velocidad>0 and xmono<x ) y=y+1;  if(sonidomosquitoactivado==0)  sonidomosquitoactivado=1;   sound_play(sonidomosquito); end end
          if(velocidad>0 and xmono>x ) y=y-1;    end
          
          if(velocidad<0 and xmono<x ) y=y-1; end
          if(velocidad<0 and xmono>x ) y=y+1;    if(sonidomosquitoactivado==0)  sonidomosquitoactivado=1;  sound_play(sonidomosquito); end end
    
       if(collision (type coco_final)) mosquitomuerto(x, y);   //El mono mata al mosquito
                break; end

switch(estoypegando)
    case 1:  // Si el mono está pegando al mosquito
        if(collision(type mono) and picadomono == 0)   // Solo si el mosquito no ha picado aún
            if((x < xmono and flagsmono == 1) or (x > xmono and flagsmono == 0))
                mosquitomuerto(x, y);   //El mono mata al mosquito
                break;
            end
        end
        end
    
    case 0:   // Si el mono no está pegando al mosquito
        if(collision(type mono) and picadomono == 0)   // Si el mosquito aún no ha picado
            picadomono = 1;   // El mosquito pica al mono
            frame;  // Cambiar el frame para reflejar el picado
            salpiconsangre(x, y);   // Mostrar la salpicadura de sangre
        end
    end
    
  
end


    

          if(picadomono>=1) velocidad++; end          
       end

    end
  frame;
  end
end

process mosquitomuerto(x, y)
private
    contador = 0;
begin
    graph = 976;
    flags = 3;

    loop
        contador++;
        y += (contador < 5 ? -1 : 8);

        if(y >= 610) break; end

        frame;
    end
end


process Objeto_spider(retardo, xtela, ytela, velocidadspider);
private
    puestatela = 0;
    contador = 0;
    entroyaspider = 0;
    contadorentraspider = 0;
    contadorcambiagrafico = 0;
    misombra;
    toques = 1;
    xguardada;
    retardoenponerlatela = 0;
    telaquecuelga;

methods
    method callback finalize()
    begin
        signal(misombra, s_kill);
        signal(telaquecuelga, s_kill);
    end

begin
    graph = 977;
    x = xtela;
    xguardada = x;
    y = -50;
    z = -15;
    telaquecuelga = Objeto_telacuelga(x, y);
    //pruebameter misombra=Objeto_sombra_spider(xtela, ytela+70);

    loop
        contadorentraspider++;
        
        if(contadorcambiagrafico >= 20)
            graph = graph + 1; 
            contadorcambiagrafico = 0; 
        end

        if(graph > 980)  
            graph = 977; 
        end

        if(contadorentraspider >= retardo and entroyaspider == 0) 
            entroyaspider = 1; 
        end

        if(entroyaspider == 1)
            if(y < ytela and puestatela == 0) 
                y = y + velocidadspider; 
                contadorcambiagrafico++;
            end

            if(y >= ytela and puestatela == 0 and toques > 0)
                retardoenponerlatela++;
                if(retardoenponerlatela >= 20)
                    puestatela = 1; 
                    Objeto_tela_de_a(x, y, 0);  //(x, y, retardo ); 
                end
            end
        end

        if(puestatela == 1)
            contador++;
            if(contador >= 80)
                y = y - velocidadspider;
                contadorcambiagrafico++;
                if(y < -50) 
                    signal(misombra, s_kill);
                    break; 
                end
            end
        end

        frame;
    end
end

     
process Objeto_spiderseva(x, y, size, flags,direccion); // direccion 0 se va hacia la izquierda 1 se va hacia la derecha
 private

 begin
  graph=979;
  z=3;
  loop
   if(direccion==0)
 x=x-10; y=y+10; 
  end
  if(direccion==1)
 x=x+10; y=y+10; 
  end
  
  if(x<=-100 or x>=900)
   break;
  end
  frame; 
  end
end
     
     
     
     
process Objeto_telacuelga(x,y);

begin
 graph=981;

//write_int(1, 400, 400, 0, &y);
 loop
 
  y=father.y; 
  if(not collision(type Objeto_spider))  break; end
 frame;
 end
end     


 process Objeto_tela_de_a(x, y,retardo);
   private
   contador=0; parpadeo=0; contadorretardo=0;
begin

    graph=965;
  size=50;
//    write_int(1, x+100, y, 0, &y);
  //  write_int(1, x+100, y+100, 0, &contador);
  z=1;

   loop
   contadorretardo++;
   if(contadorretardo=>retardo)
   xteladea=x;
   contador++;
   if(contador<200 and size<100) size++; end

   if(contador>300)break; end
   if(contador>200)
    parpadeo++;
    if(parpadeo>10) flags=4; parpadeo=0; else flags= 0; end
   end
   
   end
 
            frame; 
            end 
        end
   




//-----------------------------------------------------------------------------
// procesos para las bolas de cambio de mono
//-----------------------------------------------------------------------------

process bola_cambio_mono(x, y, numerodemonovoyaser)
private
    misombra;
    miresplandor;
methods
    method callback finalize()
    begin
        signal(misombra, s_kill);
        signal(miresplandor, s_kill);
    end
begin
    y = y - 90;

    // asignar gráfico según número de mono
    graph = 896 + numerodemonovoyaser;

    misombra = sombra(x, y + 87, 70);
    miresplandor = resplandorazul(x, y);

    loop
        if(collision(type mono))
            sound_play(sonidocogidabola);
            establecenuevomono = numerodemonovoyaser;
            if(collision(type explosioncambiomono))
                break;
            end
        end

        frame;
    end
end

process resplandorazul(x, y);
 private
  paso=0;
 
begin
 graph=896;
 z=1;
y=y-20;
 size=50;
 loop
   if(paso==0)
     size++;
     if(size>=70)
       paso=1;
     end
   end
   if(paso==1)
     size--;
     if(size<50)
       paso=0;
     end
   end
 //  if(not collision(type bola_cambio_mono))  
  //   break;
  // end
  frame;
  end
end

process explosioncambiomono(x, y);
begin
 graph=887;
 y=y-70;
sound_play(sonidomonochange);   
 loop
  graph++;
  if(graph>=895) break; end
  frame;
  end
end



process prueba1();
begin


	ola(700,1);

	oleaje();

END

process oleaje()
private
    cont = 0;
    par = 0;
    sacatiburon = 0;
begin
    sound_play(sonidomar);
    palmera(400, alturaterrenoarriba, 0, 0, 0);
    piedra_grande(20, alturaterrenomedio, size, 1);
    aguila(300,200,5);
  

    
    loop
    
        cont++;
        sacatiburon++;

        // genera olas alternando direccion
           if(cont == 1)
            ola(700, par == 0 ? -1 : +1);
            par = 1 - par;
        end

        // reinicia contador
        if(cont >= 40) cont = 0; end

        // saca tiburon cada cierto tiempo con probabilidad
        if(sacatiburon > 200 and rand(0, 10) == 10)
            tiburon(900, 500, rand(200, 400));
            sacatiburon = 0;
        end

        frame;
    end
end

   

process ola(y, direccionola)
private
    estado = 0;    // 0 = sube, 1 = baja
    cont = 0;
begin
    graph = 996;
    fx.alpha = 95;
    x = 350;
    flags = rand(0, 1);

    LOOP
        cont++;

            // movimiento en X siempre
            x += direccionola;

            if(estado == 0) // subiendo
                y -= 2;
                fx.alpha += 1;
                if(y < 550) estado = 1; end
            else            // bajando
                y += 2;
                fx.alpha -= 5;
            end
      

        if(fx.alpha <= 30) break; end
        frame;
    END
end
   
    
 
 
    


process tiburon(x, y, ymaximasalto)
private
        estado = 0;          // 0 = nadando, 1 = subiendo, 2 = cayendo
        salpica = 0;
        y_base;          // altura de referencia
        salto_max = 0;       // altura máxima del salto
        salto_actual = 0;    // cuánto ha subido
        frame_cont = 0;      // animación de nado
begin
y_base = y; 
    loop
        // animación de nado
        frame_cont++;
        graph = 267 + (frame_cont / 3) % 3;

        switch(estado)
            case 0: // nadando
                salpica = 0;
                x -= rand(3, 5);
                if(rand(0, 100) < 3)  // probabilidad de saltar
                    estado = 1;
                    salto_max = rand(50, ymaximasalto);
                    salto_actual = 0;
                    y_base = y;
                end
            end

            case 1: // subiendo
                y -= 4; x -= 2;
                salto_actual += 4;
                if(salto_actual >= salto_max)
                    estado = 2;
                end
            end

            case 2: // cayendo
                y += 6; x -= 2;
                if (collision(type ola) and salpica==0) salpicon(4, x +15, y +30 ); salpicon(5, x -20, y +30 );salpica = 1; end
                if(y >= y_base)
                    y = y_base;
                    estado = 0;
                end
            end
        end

        if(x <= -100) break; end
        frame;
    end
end



process aguila(x, y, velocidad)
private
    estado = 0;
    frame_cont = 0;   // animación de volando
    subiendo = 0;
    bajando = 0;
    sonido = 0;
    toquesaguila=20;
    cazodamono=0;
begin
    graph = 270;
    y -= 110;
    z = -11;
    if (velocidad < 0) 
        flags = 1; 
    end

    loop
    
  if(collision(type coco_final)) toquesaguila=toquesaguila-1;  salpiconsangre(x,y); end
  if(toquesaguila<=0) break; end
    
        // Animación de volando
        frame_cont++;
        graph = 270 + (frame_cont / 3) % 3;
 
        switch (estado)
            case 0: // volando hacia la izquierda
                x -= abs(velocidad); 
                flags = 0;
                
            end

            case 1: // volando hacia la derecha
                x += abs(velocidad); 
                flags = 1;
            end

            case 2: // Atacando
                loop
                
                if(collision(type coco_final)) toquesaguila=toquesaguila-1;  salpiconsangre(x,y); end
  if(toquesaguila<=0) break; end
                
               
                    // Si no está bajando ni subiendo, empieza el ataque
                    if (bajando == 0 and subiendo == 0)
                        bajando = 1;
                    end

                    // Movimiento descendente
                    if (bajando == 1)
                        y += abs(velocidad) + 1;

                        // Reproducir sonido solo una vez al iniciar la bajada
                        if (sonido == 0)
                            sound_play(sonidoaguilaatacando);
                            sonido = 1;
                        end

                        // Cambiar a subida al llegar al suelo
                        if (y > 400)
                            bajando = 0;
                            subiendo = 1;
                        end
                    end

                    // Movimiento ascendente
                    if (subiendo == 1)
                        y -= abs(velocidad);
 if(flags==0) x -= abs(velocidad); else x += abs(velocidad); end
                        frame_cont++;
                        graph = 270 + ((frame_cont / 3) % 3);

                        // Si llega al límite superior, reinicia estado
                        if (y < 100)
                            bajando = 0;
                            subiendo = 0;
                            sonido = 0;
                            estado = rand(0,1); // volver a volar izquierda/derecha
                            break;
                        end
                    end

                    frame;
                end
            end
            
           
        end
        // Cambiar dirección en los bordes
        if (x <= 10)
            estado = 1;   // hacia la derecha
        end

        if (x >= 790)
            estado = 0;   // hacia la izquierda
        end

        // Probabilidad de ataque cuando está en zona central
        if (x > 1 and x < 500)
            if (rand(0,150) == 0)
                estado = 2; // atacar
            end
        end

 
        frame;
    end
end



// ============= PROCESO DEL TÓTEM =============
PROCESS totem_final()
private
// Colores para el tótem marrón al ser golpeado
// Colores del tótem al recibir un golpe tipo fuego
tablaColorTotemGolpeado[15] =
    0x9999FFFF, // amarillo pastel
    0x66EEFFFF, // amarillo más intenso
    0x33DDFFFF, // amarillo-naranja
    0x00CCFFFF, // naranja claro
    0x00B2FFFF, // naranja medio
    0x0099FFFF, // naranja fuerte
    0x0077FFFF, // rojo-anaranjado
    0x0055FFFF, // rojo más oscuro
    0x0033FFFF, // rojo intenso
    0x0011FFFF, // rojo muy intenso
    0x0000FFFF, // rojo puro
    0x0033FFFF, // rojo intenso (rebote)
    0x0055FFFF, // rojo más oscuro
    0x0077FFFF, // rojo-anaranjado
    0x0099FFFF; // naranja fuerte

    

contadortotem=0;
totemgolpeado; 
             
             
 toqueslanzadera=1000; tocado=0; tablacolorestocado[9] = 0x7FFFFF99, 2 dup(0x7FFF4500), 3 dup(0x7FFFFF99), 3 dup(0x7FFF4500);
fx_advancedtype_tint tint; // para tintar 
                     contadortintado=0;            
           tiempoexplotando=0;

BEGIN
 lanzaderastotales=0;
    totem_x_actual=600;
    totem_y=560;
    x = totem_x_actual;
    y = totem_y;
    graph = 273; // aquí pon el gráfico del tótem
      // Iniciar el sistema de disparo de estacas
   

// ======================================================
// ============= ACTIVACIÓN DE TODAS LAS LANZADORAS ====
// ======================================================
barra_energia();
lanzadora_parabola(14, 500, 320, 50, 510, 0);    // AlturaterrenoAbajo = 510
lanzadora_parabola(15, 575, 315, 200, 510, 100);
lanzadora_parabola(16, 650, 320, 250, 510, 200);


// Inferiores (lineales) con retardo escalonado lanzadora_lineal(tipo, x_lanzador, y_lanzador, vel_x, vel_y, retardo)
lanzadora_lineal(11, 550, 510, -10, 0, 0);
lanzadora_lineal(12, 600, 505, -10, 0, 100);
lanzadora_lineal(13, 650, 510, -10, 0, 200);

    LOOP

   //para probar eliminar el mostruo if(key(_w)) energia=0; end
//if(key(_w)) energia=0; end
    contadortotem++;
    if(energia<=60 and tiempoexplotando<150) explosiontotem(rand(450,700), rand(250,600));    tiempoexplotando++; end
    if(tiempoexplotando>=150) y=y+20;  end
    if(y>=1000)  break; end
    if(lanzaderastotales<=0 and collision (type coco_final)) energia -= 1; tocado=1;  end
    
   if(tocado>=1) tocado++;                    
           
     fx.mode = fx_advanced; // aplico un efecto avanzado mediante estructura TINT
     fx.fxref = &tint; 
    tint.color = tablacolorestocado[tocado];
 end
       if(tocado>=9)
      fx.mode = fx_solid; 
      tocado=0;
      end
    
    if(contadortotem==200)
    mosquito(5,500,AlturaTerrenoMedio,2);

   end  
    if(contadortotem==300)


    mosquito(5,500,AlturaTerrenoabajo,2);

    end
    
     if(contadortotem==400)


     bola_cambio_mono(30, AlturaTerrenoAbajo, 3);

    end
    
if(contadortotem==500)


       mosquito(5,500,AlturaTerrenoMedio,2);

    end

if(contadortotem==600)


      bola_cambio_mono(300, AlturaTerrenoMedio, 2);

    end

if(contadortotem==700)


      mosquito(5,500,AlturaTerrenoabajo,2);

    end

if(contadortotem==800)


      mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2);

    end

if(contadortotem==900)


      aguila(850,200,5);

    end

  if(contadortotem==1100)


      mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2); mosquito(5,570,AlturaTerrenoMedio,2);

    end   

  if(contadortotem==1200)


      mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2);

    end 
    
     if(contadortotem==1400)


      mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2);

    end 
      if(contadortotem==1600)


      mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2);

    end 
    
    
          if(contadortotem==1800)


      mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2);

    end 
    
    
          if(contadortotem==2000)


      mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2);

    end 
    
    if(contadortotem==2300)


      aguila(850,200,5);
 mosquito(5,500,AlturaTerrenoabajo,2);  mosquito(5,500,AlturaTerrenoMedio,2);
contadortotem=0;

    end
    
        
        FRAME;
    END
END


// ============= SISTEMA DE DISPARO DE COCOS =============
PROCESS coco_final(x_inicio, y_inicio, direccion)
PRIVATE
    vel_x, vel_y;
    gravedad_coco = 1;
    tiempo_vuelo = 0;
    distancia_x;
    x_destino; y_destino;
BEGIN
    x = x_inicio;
    y = y_inicio - 50;
    graph = 951; // gráfico del coco
    z=-10;
    if(direccion == 1)
        distancia_x = +580;
    else
        distancia_x = -580;
    end

    x_destino = x_inicio + distancia_x;
    y_destino = AlturaTerrenoAbajo;

    vel_x = distancia_x / 60;
    vel_y = -10; // <-- MÁS BAJO QUE ANTES

    LOOP
        tiempo_vuelo++;

        x += vel_x;
        y += vel_y;
        vel_y += gravedad_coco;
       
        if(y >= AlturaterrenoAbajo)
            y = y_destino;
            break;
        end

       if(collision(TYPE totem_final) and totemgolpeado==0)
  totemgolpeado=1; frame;
            break;
        end
        
        if(x < -50 OR x > 850 OR y > 600 OR y < 50)
            break;
        end
        
        FRAME;
    END
   
END




PROCESS plataforma(x, y);
PRIVATE
    id2 = 0;

BEGIN
    graph = 985;
fx.alpha = 0;
    LOOP
        // Movimiento
        y = father.y + 20;

        // Detección de colisión con el mono
        id2 = collision(TYPE mono);

        // Si colisiona con el mono
        IF (id2)
            IF (id2.y > y)  // y está por debajo de él
                id2.y = y ;              // lo sube un poco
                id2.en_suelo = true;         // le activa en_suelo
                id2.velocidad_gravedad = 0;  // y le quita la gravedad
            END
        END

        FRAME;
    END
END




process chorrodeagua()
private
    estado, contador, velocidad,frame_anim;
    sonidochorrosonando=0;
contador2=0;
begin
    x = 100;
    y = 540;
    graph=280;
  fx.alpha = 220;
    velocidad = 3; // píxeles por frame al subir/bajar
    estado = 0;    // 0 = abajo, 1 = subiendo, 2 = arriba, 3 = bajando
    contador = 0;
     frame_anim = 0; // Para animación 278-279-280
    basearribachorrodeagua(x, y-100); // Crear la base

    loop
     if(energia<=60) y++; if(y>650) signal(TYPE basearribachorrodeagua, s_kill); break; end end
      contador2++;
        if(contador2>=10)
        // --- ANIMACIÓN DEL GRÁFICO ---
         graph++;contador2=0;
         
         
end 
    if(graph==282) graph=280; end
        // -----------------------------
        switch(estado)

            // Estado 0: Quieto abajo
            case 0:
                contador++;
                if(contador >= 60*3) // 3 segundos
                    contador = 0;
                    estado = 1;
                end
            end

            // Estado 1: Subiendo
            case 1:
                y -= velocidad;
                if(sonidochorrosonando==0) sonidochorrosonando=1; sound_play(SonidoGeiser); end  
                if(y <= 395)
                    y = 395;
                    estado = 2;
                end
            end

            // Estado 2: Quieto arriba
            case 2:
            sonidochorrosonando=0;
                contador++;
                if(contador >= 60) 
                    contador = 0;
                    estado = 3;
                end
            end

            // Estado 3: Bajando
            case 3:
                y += velocidad;
                if(y >= 620)
                    y = 620;
                    estado = 0;
                end
            end

        end

        frame;
    end
end
  
PROCESS basearribachorrodeagua(x, y)
PRIVATE
    movx, dirx;
    contador = 0;
BEGIN
    graph = 277;

    plataforma(x, y);
    fx.alpha = 220;
    
    LOOP
        contador++;
        if (contador >= 10)
            graph++; 
            contador = 0;
        end

        if (graph == 279) graph = 277; end

        y = father.y - 50;

        movx += dirx;
        if (movx >= 2) dirx = -1; end
        if (movx <= -2) dirx = 1; end

        x = father.x + movx;

        frame;
    END
END


PROCESS estaca_parabola_final(tipo, x_inicio, y_inicio, x_destino, y_destino)
PRIVATE
    vel_x, vel_y;
    gravedad_estaca = 1;
    tiempo_vuelo = 0;
    distancia_x;
BEGIN
    x = x_inicio;
    y = y_inicio;
    graph = graficoEstaca;

    distancia_x = x_destino - x_inicio;
    vel_x = distancia_x / 60;
    vel_y = -15;

    LOOP
        if(collision(type coco_final))
            salpiconsangre(x, y);
            break;
        end

        tiempo_vuelo++;
        x += vel_x;
        y += vel_y;
        vel_y += gravedad_estaca;

        if(y >= y_destino)
            y = y_destino;
            break;
        end

        if(x < -50 OR x > 850 OR y > 600 OR y < 50)
            break;
        end

        FRAME;
    END

END

PROCESS estaca_linea_final(tipo, x_inicio, y_inicio, vel_x, vel_y)
BEGIN
    x = x_inicio;
    y = y_inicio;
    graph = graficoEstaca;

    LOOP
        if(collision(type coco_final))
            salpiconsangre(x, y);
            break;
        end

        x += vel_x;
        y += vel_y;

        if(x > 850 OR x < -50 OR y > 650 OR y < -50)
            break;
        end

        FRAME;
    END
END

PROCESS lanzadora_parabola(tipo, x_lanzador, y_lanzador, x_destino, y_destino, retardo)
PRIVATE
    tiempo_cooldown; 
    toqueslanzadera = 10; 
    tocado = 0; 
    tablacolorestocado[9] = 0x7FFFFF99, 2 dup(0x7FFF4500), 3 dup(0x7FFFFF99), 3 dup(0x7FFF4500);
    fx_advancedtype_tint tint;
    contadortintado = 0; 
BEGIN
  
    lanzaderastotales = lanzaderastotales + 1;
    x = x_lanzador;
    y = y_lanzador;
    tiempo_cooldown = retardo;
    LOOP
        graph = graficoLanzadora;
        if (collision(type coco_final)) 
            tipo = 0; 
            tocado = 1;
            salpiconsangre(x, y); 
            toqueslanzadera = toqueslanzadera - 1; 
            energia = energia -1;
        end

        if (toqueslanzadera <= 0)  
            lanzaderastotales = lanzaderastotales - 1; 
            break; 
        end

        if (tocado >= 1) 
            tocado++;                    
            fx.mode = fx_advanced;
            fx.fxref = &tint; 
            tint.color = tablacolorestocado[tocado];
        end

        if (tocado >= 9)
            fx.mode = fx_solid; 
            tocado = 0;
        end

        if (tiempo_cooldown > 0)
            tiempo_cooldown--;
        else
            if ((tipo == 14 AND lanzadorestacas4 == 1) OR 
                (tipo == 15 AND lanzadorestacas5 == 1) OR 
                (tipo == 16 AND lanzadorestacas6 == 1))
                estaca_parabola_final(tipo, x_lanzador, y_lanzador, x_destino, y_destino);
                tiempo_cooldown = tiempo_fijo_superiores;
            end 
        end

        FRAME;
    END
END

PROCESS lanzadora_lineal(tipo, x_lanzador, y_lanzador, vel_x, vel_y, retardo)
PRIVATE
    tiempo_cooldown; 
    toqueslanzadera = 10; 
    tocado = 0; 
    tablacolorestocado[9] = 0x7FFFFF99, 2 dup(0x7FFF4500), 3 dup(0x7FFFFF99), 3 dup(0x7FFF4500);
    fx_advancedtype_tint tint; // para tintar 
    contadortintado = 0; 
BEGIN
  
    lanzaderastotales = lanzaderastotales + 1;
    x = x_lanzador;
    y = y_lanzador;
    tiempo_cooldown = retardo;
    LOOP
        graph = graficoLanzadora; // dibuja la lanzadora
        if (collision(type coco_final)) 
            tipo = 0; 
            tocado = 1;
            salpiconsangre(x, y); 
            toqueslanzadera = toqueslanzadera - 1; 
            energia= energia -1;
        end

        if (toqueslanzadera <= 0) 
            lanzaderastotales = lanzaderastotales - 1; 
            break; 
        end

        if (tocado >= 1) 
            tocado++;                    
            fx.mode = fx_advanced; // aplico un efecto avanzado mediante estructura TINT
            fx.fxref = &tint; 
            tint.color = tablacolorestocado[tocado];
        end

        if (tocado >= 9)
            fx.mode = fx_solid; 
            tocado = 0;
        end

        if (tiempo_cooldown > 0)
            tiempo_cooldown--;
        else
            if ((tipo == 11 AND lanzadorestacas1 == 1) OR (tipo == 12 AND lanzadorestacas2 == 1) OR (tipo == 13 AND lanzadorestacas3 == 1))
                estaca_linea_final(tipo, x_lanzador, y_lanzador, vel_x, vel_y);
                tiempo_cooldown = tiempo_fijo_inferiores;
            end
        end

        FRAME;
    END
END

PROCESS barra_energia_fondo();
BEGIN
    graph = 276;
    x = 150;
    y = 550;
    z = -9;
    loop
        if (energia <= 60) y = y + 10; end
        if (energia <= 60 and y > 610) break; end
        frame;
    end
end

PROCESS barra_energia();
PRIVATE
    largo = 460;         // largo de la barra (ancho visible)
BEGIN
    region = 2;
    x = 150;
    y = 550;
    z = -10;
    graph = 275;           

    energia_totem = 460;    // antes tenia 46o
    energia = energia_totem;

    define_region(2, x, y, largo, 50);  

    LOOP
        if (energia <= 60) y = y + 10; end
        if (energia <= 60 and y > 610) break; end

        largo = (energia * energia_totem) / energia_totem; 
        if (largo < 0) largo = 0; end

        define_region(2, x, y, largo, 50); 

        FRAME;
    END
END


process explosiontotem(x, y);
begin
    graph = 887;
    if (rand(0,10) == 10) sound_play(sonidoexplosion); end

    loop
        if (not collision(type totem_final)) break; end
        graph++;
        if (graph >= 895) break; end
        frame;
    end
end



PROCESS confeti()
PRIVATE
    velx, vely;
BEGIN
    signal(TYPE totem_final, s_kill);
    signal(TYPE marcador, s_kill);
    signal(TYPE marcador_icono, s_kill);
    signal(TYPE bola_cambio_mono, s_kill);
    signal(TYPE aguila, s_kill);

    signal(TYPE barra_energia, s_kill);

    signal(TYPE dureza_del_tronco, s_kill);
    signal(TYPE estatua_mono_oro, s_kill);
    signal(TYPE estaca_linea_final, s_kill);
    signal(TYPE estaca_parabola_final, s_kill);

    signal(TYPE lanzadora_lineal, s_kill);
    signal(TYPE lanzadora_parabola, s_kill);

    signal(TYPE mosquito, s_kill);

    x = rand(0,800);
    y = -10; 

    velx = rand(-2,2);
    vely = rand(2,6);

    graph = rand(285,287);

    LOOP
        x += velx;
        y += vely;
        if (rand(0,20) == 20) 
            if (flags == 1) flags = 0; else flags = 1; end 
        end

        IF (y > 610 or x < -10 or x > 810)
            signal(id, s_kill);
        END

        FRAME;
    END
END


PROCESS generador_confeti()
PRIVATE
    tiempo = 0; 
BEGIN
    final_juego();

    LOOP
        tiempo++;

        IF(tiempo MOD 3 == 0)
            confeti();
        END

        FRAME;
    END
END


PROCESS final_juego()
private
    textocambia;
    textofijo;
    tiempotextocambia = 0;
BEGIN
    juegofinalizado = 1;

    textofijo = write(2, 400, 110, 4, "¡¡ENHORABUENA!!");

    LOOP
        tiempotextocambia++;   

        switch (tiempotextocambia)
            case 100:
                textocambia = write(2, 400, 200, 4, "Juego realizado por");
            end

            case 200:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "Mario Gómez");
            end

            case 300:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "Ana Gómez");
            end

            case 400:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "Adrián Gómez");
            end

            case 500:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "Agradecimientos a");
            end

            case 600:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "CicTec");
            end

            case 650:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "TYCO");
            end

            case 700:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "Nightwolf");
            end

            case 750:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "oskarg");
            end

            case 800:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "DoZ");
            end

            case 850:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "Nowy");
            end

            case 900:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "vortigano");
            end

            case 950:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "AmakaSt");
            end      

            case 1000:
                delete_text(textocambia);
                textocambia = write(2, 400, 200, 4, "¡Gracias por jugar!");
            end
        end

        FRAME;
    END
END



process monofinal(x, y, flags, numeromono);
private
    estado = 0;

    fueradepantalla = 0;

    primeraimagenandando;    
    ultimaimagenandando;    
                 
    graficomonosaltando;
                  
    primeraimagenrespirando;  
    ultimaimagenrespirando;      
          
    velocidadmono;          

begin
    if(numeromono == 1) monofinalizquierda(-50, AlturaTerrenoAbajo, 2); monofinalderecha(850, AlturaTerrenoAbajo, 3); end
    if(numeromono == 2) monofinalizquierda(-50, AlturaTerrenoAbajo, 1); monofinalderecha(850, AlturaTerrenoAbajo, 3); end
    if(numeromono == 3) monofinalizquierda(-50, AlturaTerrenoAbajo, 1); monofinalderecha(850, AlturaTerrenoAbajo, 2); end

    switch(numeromono)
        case 1: 
            primeraimagenandando = 1;
            ultimaimagenandando  = 32;
            graficomonosaltando  = 7;
            primeraimagenrespirando = 33;    
            ultimaimagenrespirando  = 40;    
            velocidadmono = 5;   
        end

        case 2: 
            primeraimagenandando = 101;
            ultimaimagenandando  = 132;    
            graficomonosaltando  = 107;
            primeraimagenrespirando = 134;    
            ultimaimagenrespirando  = 144;  
            velocidadmono = 3;
        end

        case 3: 
            primeraimagenandando = 200;
            ultimaimagenandando  = 231;    
            graficomonosaltando  = 207;
            primeraimagenrespirando = 232;    
            ultimaimagenrespirando  = 239;  
            velocidadmono = 3;     
        end
    end

    graph = primeraimagenandando;

    loop
        if(estado == 0) 
            graph = graph + 1;
            if(graph >= ultimaimagenandando) graph = primeraimagenandando; end

            if(x < 400)

                if(400 - x <= velocidadmono) 
                    x = 400; 
                    graph = primeraimagenrespirando;
                    estado = 1;
                else
                    x = x + velocidadmono;
                    flags = 0;
                end
            end

            if(x > 400)
                if(x - 400 <= velocidadmono) 
                    x = 400;
                    graph = primeraimagenrespirando;
                    estado = 1;
                else
                    x = x - velocidadmono;
                    flags = 1;
                end
            end
        end

        if(estado == 1)
            graph = graph + 1;
            if(graph >= ultimaimagenrespirando) graph = primeraimagenrespirando; end
        end
        
        frame;
    end
end

process monofinalizquierda(x, y, numeromono);
private
    estado = 0;
    fueradepantalla = 0;
    primeraimagenandando;    
    ultimaimagenandando;                        
    graficomonosaltando;                  
    primeraimagenrespirando;  
    ultimaimagenrespirando;                   
    velocidadmono;          

begin
    switch(numeromono)
        case 1: 
            primeraimagenandando = 1;
            ultimaimagenandando  = 32;
            graficomonosaltando  = 7;
            primeraimagenrespirando = 33;    
            ultimaimagenrespirando  = 40;    
            velocidadmono = 5;   
        end

        case 2: 
            primeraimagenandando = 101;
            ultimaimagenandando  = 132;    
            graficomonosaltando  = 107;
            primeraimagenrespirando = 134;    
            ultimaimagenrespirando  = 144;  
            velocidadmono = 3;
        end

        case 3: 
            primeraimagenandando = 200;
            ultimaimagenandando  = 231;    
            graficomonosaltando  = 207;
            primeraimagenrespirando = 232;    
            ultimaimagenrespirando  = 239;  
            velocidadmono = 3;     
        end
    end

    graph = primeraimagenandando;

    loop
        if(estado == 0) // va al centro
            graph = graph + 1;
            if(graph >= ultimaimagenandando) graph = primeraimagenandando; end

            // si aún no ha llegado al centro
            if(x < 300)
                // si está cerca, ajustar para que llegue exacto
                if(300 - x <= velocidadmono)
                    x = 300;
                    graph = primeraimagenrespirando;
                    estado = 1;
                else
                    x = x + velocidadmono;
                    flags = 0;
                end
            end
        end

        if(estado == 1) // respira
            graph = graph + 1;
            if(graph >= ultimaimagenrespirando) graph = primeraimagenrespirando; end
        end
        
        frame;
    end
end

process monofinalderecha(x, y, numeromono);
private
    estado = 0;
    fueradepantalla = 0;
    primeraimagenandando;    
    ultimaimagenandando;                       
    graficomonosaltando;                 
    primeraimagenrespirando;  
    ultimaimagenrespirando;                   
    velocidadmono;          

begin
    switch(numeromono)
        case 1: 
            primeraimagenandando = 1;
            ultimaimagenandando  = 32;
            graficomonosaltando  = 7;
            primeraimagenrespirando = 33;    
            ultimaimagenrespirando  = 40;    
            velocidadmono = 5;   
        end

        case 2: 
            primeraimagenandando = 101;
            ultimaimagenandando  = 132;    
            graficomonosaltando  = 107;
            primeraimagenrespirando = 134;    
            ultimaimagenrespirando  = 144;  
            velocidadmono = 3;
        end

        case 3: 
            primeraimagenandando = 200;
            ultimaimagenandando  = 231;    
            graficomonosaltando  = 207;
            primeraimagenrespirando = 232;    
            ultimaimagenrespirando  = 239;  
            velocidadmono = 3;     
        end
    end

    graph = primeraimagenandando;

    loop
        if(estado == 0)
            graph = graph + 1;
            if(graph >= ultimaimagenandando) graph = primeraimagenandando; end

            if(x > 500)

                if(x - 500 <= velocidadmono)
                    x = 500;
                    graph = primeraimagenrespirando;
                    estado = 1;
                else
                    x = x - velocidadmono;
                    flags = 1;             
                end
            end
        end

        if(estado == 1) 
            graph = graph + 1;
            if(graph >= ultimaimagenrespirando) graph = primeraimagenrespirando; end
        end
        
        frame;
    end
end

process pausa(numeromono)
begin
    graph = 287 + numeromono;
    x     = 400;
    y     = 250;
    z     = -384;

    signal(all_process, s_freeze);
    zzz(380, 240);

    repeat
        frame;
    until(keydown(_p));
    while(keydown(_p)) frame; end

    signal(all_process, s_wakeup);
    signal(TYPE zzz, s_kill);
end

process zzz(x, y)
private
    contador = 0;
begin
    z = -384;
    
    loop
        contador++;

        if (contador < 30)
            graph = 291;
        elseif (contador < 70)
            graph = 292;
        else
            graph = 293;
        end

        y = y + rand(-1,1);
        x = x + 1;

        if (contador > 100)
            signal(id, s_kill);
            zzz(380, 240);
        end

        frame;
    end
end