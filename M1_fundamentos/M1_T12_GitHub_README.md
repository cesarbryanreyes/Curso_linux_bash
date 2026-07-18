# M1 · Tema 1.2 — La Terminal, Shell y Bash

> **CEM-BIO-101** · Módulo 1 · Asincrónica · 15 minutos
> **Nivel:** 0 — sin experiencia previa
> **Prerequisito:** Tema 1.1 completado

---

## ¿Qué aprenderás en este tema?

- Leer y entender cada parte del **prompt**
- Escribir comandos con la sintaxis correcta
- Usar Tab y Ctrl+C — los dos atajos de supervivencia, antes de escribir nada
- Ejecutar tus primeros comandos
- Usar el historial para no reescribir comandos
- Pedir ayuda con `man`, `--help` y `whatis`
- Usar el resto de atajos esenciales: Ctrl+L, Ctrl+D, Ctrl+A/E, Ctrl+Z
- Interpretar el código de salida `$?`

---

## 1. El prompt — lo que ves al abrir la terminal

El **prompt** es la línea de texto que espera tus comandos. Es la señal de que Linux está listo.

```
cesar @ ubuntu : ~ $
  ↑       ↑     ↑  ↑
  │       │     │  └── Señal de que Linux espera tu orden
  │       │     └───── Carpeta donde estás (~ = tu home)
  │       └─────────── Nombre de tu computadora
  └─────────────────── Tu nombre de usuario
```

### $ vs # — diferencia crítica

| Símbolo | Significa | ¿Qué hacer? |
|---------|-----------|-------------|
| `$` | Usuario normal | Trabajar normalmente |
| `#` | Root — administrador total | ⚠ Mucho cuidado · escribe `exit` para salir |

> El prompt cambia automáticamente cuando cambias de carpeta — es el GPS de la terminal.

### Cómo luce en diferentes entornos

```
Ubuntu en WSL2 (Windows):
cesar@DESKTOP-XYZ:/mnt/c/Users/cesar$

Ubuntu nativo / macOS:
cesar@ubuntu:~$

Servidor remoto (SSH):
cesar@servidor-hpc:/data/proyectos$
```

> `~` (virgulilla) = tu carpeta personal — el mismo `$HOME`. El cursor parpadeante indica que Linux está LISTO y esperando que escribas.

---

## 2. Cómo escribir un comando — la sintaxis

```
comando  [opciones]  [argumento]
   ↑          ↑           ↑
Obligatorio  Modifica   Sobre qué
             el cmd     actúa
```

### Ejemplo desglosado

```bash
ls  -lh  /home/cesar
#   ↑     ↑      ↑
#  cmd  opciones  argumento
#
# ls   → listar archivos
# -lh  → -l (formato largo) + -h (tamaño legible: KB/MB/GB)
# /home/cesar → la carpeta que quiero listar
```

### ⚠ Reglas que debes memorizar

```
❌ ls-lh          → ERROR: falta el espacio
✅ ls -lh         → CORRECTO

❌ LS -lh         → ERROR: LS no existe, ls sí
✅ ls -lh         → CORRECTO

❌ -lh ls         → ERROR: el comando va primero
✅ ls -lh         → CORRECTO
```

### Ejemplos reales

```bash
echo "Hola bioinformática"    # echo = comando, texto entre comillas = argumento
ls -la ~                      # -l=largo, -a=ocultos, ~=home
sudo apt update                # sudo = comando, apt update = argumento
```

---

## 3. Antes de escribir tu primer comando: Tab y Ctrl+C

> ⭐ Aprende estos DOS atajos AHORA, antes de escribir cualquier comando. Los usarás miles de veces.

### Tab — autocompletar

Tab es como la ADN Polimerasa: tú das el cebador (primeras letras) y Linux sintetiza y completa el resto de la secuencia. Si hay ambigüedad (varios archivos), Tab Tab muestra todas las opciones.

```bash
$ ls /home/ce[Tab]
$ ls /home/cesar/          ← completado

$ ls ~/Do[Tab][Tab]
Documents/   Downloads/    ← opciones
```

> ⭐ Hábito desde hoy: escribe 3-4 letras y presiona Tab. Nunca termines de escribir un nombre a mano. Evita el 90% de errores de escritura.

### Ctrl+C — el botón de pánico

Sirve para DOS situaciones distintas:

**① Detener un proceso que está corriendo** — si un análisis tarda demasiado o algo no responde → Ctrl+C lo detiene inmediatamente. No daña archivos.

**② Escapar de un prompt extraño** — si el prompt cambia a `>` (mayor que), Linux está esperando que cierres algo (comillas, paréntesis). Ctrl+C te devuelve al prompt normal `$`.

```bash
$ echo "texto sin cerrar
>                  ← prompt extraño
^C                 ← Ctrl+C → vuelve a $
```

---

## 4. Tus primeros comandos — con salida explicada

Ejecútalos ahora mismo en tu terminal:

```bash
$ echo "Hola bioinformática"
Hola bioinformática
# → Imprime texto en pantalla. Las comillas son necesarias si el texto tiene espacios.

$ date
Sat Jul 11 10:32:15 -05 2026
# → Fecha y hora del sistema. Muy útil para registrar cuándo ejecutaste un análisis.

$ cal
July 2026
Su Mo Tu We Th Fr Sa
      1  2  3  4
5  6  7  8  9 10 11
# → Calendario del mes actual. Sin argumentos = mes actual. 'cal 2026' = año completo.

$ pwd
/home/cesar
# → Print Working Directory = ruta completa de dónde estás ahora mismo.

$ ls
Desktop  Documents  Downloads  Music  Videos
# → Lista los archivos de la carpeta actual.

$ echo $?
0
# → Código de salida del ÚLTIMO comando ejecutado. 0 = éxito (lo vemos a fondo en la sección 7).

$ clear
(pantalla limpia)
# → Limpia la pantalla. Atajo equivalente: Ctrl+L. El historial NO se borra.
```

---

## 5. El historial de comandos

Linux guarda todos tus comandos. Aprende a reutilizarlos — en bioinformática ejecutas comandos muy largos, y el historial te ahorra reescribir pipelines de decenas de caracteres.

```bash
↑ (flecha arriba)     # comando anterior — el más usado
↓ (flecha abajo)      # avanzar en el historial
Ctrl+R                # búsqueda inversa — escribe parte del cmd
history               # ver lista numerada de todos los comandos
history | tail -20    # ver solo los últimos 20
!498                  # ejecutar el comando número 498 del historial
!!                    # repetir el ÚLTIMO comando ejecutado
```

> 💡 Truco: `sudo !!` — si un comando falló por falta de sudo, esto lo repite con sudo sin reescribirlo.

---

## 6. Cómo pedir ayuda — 3 herramientas integradas

> 💡 Regla de oro: antes de buscar en Google, pregúntale al propio Linux.

```bash
# 1. Manual completo
man ls
# Navega con ↑↓ · busca con /palabra · sal con q

# 2. Resumen rápido de opciones
ls --help
fastqc --help      # funciona con herramientas bioinformáticas

# 3. Descripción en una línea
whatis ls          # ls (1) - list directory contents
whatis grep        # grep (1) - print lines that match patterns
```

| Herramienta | Cuándo usarla |
|-------------|--------------|
| `man comando` | Quieres entender en profundidad cómo funciona |
| `comando --help` | Quieres ver rápidamente qué opciones tiene |
| `whatis comando` | No recuerdas para qué sirve exactamente |

> Si `whatis` da error, ejecuta primero `sudo mandb` (genera la base de datos de manuales).

---

## 7. Atajos de teclado esenciales

| Atajo | ¿Qué hace? |
|-------|-----------|
| **Tab** | ⭐ Autocompletar nombres de archivos/carpetas/comandos (ver sección 3) |
| **Ctrl+C** | Detener el proceso que está corriendo (ver sección 3) |
| **Ctrl+L** | Limpiar la pantalla — equivale a `clear` (el historial no se borra) |
| **Ctrl+D** | Cerrar la terminal (equivale a `exit`) |
| **Ctrl+R** | Búsqueda inversa en el historial |
| **Ctrl+A** | Ir al inicio de la línea |
| **Ctrl+E** | Ir al final de la línea |
| **Ctrl+Z** | Pausar proceso (`fg` para recuperar, `bg` para segundo plano) |

---

## 8. El código de salida ($?)

Cada comando termina enviando un número. Es la forma que tiene Linux de decir si algo funcionó o falló.

```bash
$ whoami
cesar
$ echo $?
0          ← 0 = ÉXITO

$ ls carpeta_que_no_existe
ls: cannot access...: No such file or directory
$ echo $?
2          ← 2 = ERROR (la carpeta no existe)
```

| Código | Significado |
|--------|------------|
| `0` | ✅ Éxito — todo funcionó |
| `1` | ❌ Error general |
| `2` | ❌ Error de sintaxis / argumento incorrecto |
| `126` | ❌ Sin permisos para ejecutar |
| `127` | ❌ Comando no encontrado (`command not found`) |
| `130` | ℹ️ Proceso interrumpido con Ctrl+C |

---

## Referencia rápida — todos los comandos del Tema 1.2

```bash
# ── Comandos básicos ───────────────────────────────
echo "texto"          # imprimir texto en pantalla
date                  # fecha y hora del sistema
cal                    # calendario del mes
pwd                    # ¿dónde estoy? (ruta actual)
ls                     # listar archivos del directorio actual
clear                  # limpiar la pantalla (= Ctrl+L)

# ── Atajos de supervivencia ────────────────────────
Tab                    # autocompletar (úsalo siempre)
Ctrl+C                 # detener proceso / escapar de prompt extraño

# ── Historial ──────────────────────────────────────
history                # lista todos los comandos anteriores
history | tail -20     # solo los últimos 20
!498                    # ejecutar número 498 del historial
!!                      # repetir el último comando
sudo !!                 # repetir el último con sudo

# ── Pedir ayuda ────────────────────────────────────
man ls                  # manual completo (salir: q)
ls --help                # resumen rápido de opciones
whatis ls                 # descripción en una línea

# ── Código de salida ───────────────────────────────
echo $?                  # ver si el último comando tuvo éxito (0) o error

# ── Resto de atajos de teclado ─────────────────────
Ctrl+L                    # limpiar pantalla
Ctrl+R                    # buscar en historial
Ctrl+D                    # cerrar terminal
Ctrl+A / Ctrl+E            # inicio / fin de línea
Ctrl+Z                     # pausar proceso (fg / bg)
```

---

## Tu bitácora — preguntas guía para este tema

```markdown
## Tema 1.2 — La Terminal, Shell y Bash

¿Cuáles son las partes de tu prompt?
→ usuario: ___ · máquina: ___ · directorio inicial: ___

¿Qué completó Tab cuando probaste ls /ho[Tab]?
→

¿En qué situación usaste Ctrl+C?
→

Ejecuta echo $? después de un comando exitoso y uno fallido:
→ Exitoso: ___ · Fallido: ___

¿Qué encontraste útil en man ls que no conocías?
→

¿Cuántos comandos tienes en tu historial? (history | wc -l)
→

¿Qué fue lo más difícil de este tema?
→

¿Qué pregunta te quedó pendiente?
→
```

---

## Glosario de términos nuevos

| Término | Definición |
|---------|-----------|
| **prompt** | Línea de texto que indica que la terminal está lista para recibir comandos |
| **sintaxis** | La gramática de los comandos: qué va primero, cómo se separa, qué es obligatorio |
| **opción / flag** | Modificador de un comando, empieza con `-` o `--` |
| **argumento** | El objeto sobre el que actúa el comando (archivo, carpeta, texto) |
| **autocompletado** | Función de Tab que completa nombres automáticamente |
| **man** | Sistema de manuales integrado en Linux |
| **historial** | Registro de todos los comandos ejecutados, guardado en `~/.bash_history` |
| **código de salida** | Número que indica si un comando tuvo éxito (0) o falló (≠0) |
| **`$?`** | Variable especial que guarda el código de salida del último comando |

---

*CEM-BIO-101 · Centro de Especialización Multidisciplinario · 2026*
