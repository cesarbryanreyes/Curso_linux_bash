# M1 · Tema 1.2 — La Terminal, Shell y Bash

> **CEM-BIO-101** · Módulo 1 · Asincrónica · 15 minutos  
> **Nivel:** 0 — sin experiencia previa  
> **Prerequisito:** Tema 1.1 completado

---

## ¿Qué aprenderás en este tema?

- Leer y entender cada parte del **prompt**
- Escribir comandos con la sintaxis correcta
- Pedir ayuda con `man`, `--help` y `whatis`
- Usar el historial para no reescribir comandos
- Usar atajos esenciales: Tab, Ctrl+C, Ctrl+L, Ctrl+R
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

---

## 3. Tus primeros 6 comandos

```bash
$ echo "Hola bioinformática"
Hola bioinformática
# → Imprime texto en pantalla

$ date
Sat Jul 11 10:32:15 -05 2026
# → Fecha y hora del sistema

$ cal
# → Calendario del mes actual (cal 2026 = año completo)

$ pwd
/home/cesar
# → ¿Dónde estoy? Print Working Directory = ruta actual

$ ls
Desktop  Documents  Downloads  Music  Videos
# → Lista los archivos de la carpeta actual

$ echo $?
0
# → Código de salida del último comando (0 = éxito)
```

---

## 4. Cómo pedir ayuda — 3 herramientas integradas

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

---

## 5. El historial de comandos

Linux guarda todos tus comandos. Aprende a reutilizarlos:

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

## 6. Atajos de teclado esenciales

| Atajo | ¿Qué hace? |
|-------|-----------|
| **Tab** | ⭐ Autocompletar nombres de archivos/carpetas/comandos |
| **Ctrl+C** | Detener el proceso que está corriendo |
| **Ctrl+L** | Limpiar la pantalla (el historial no se borra) |
| **Ctrl+D** | Cerrar la terminal (equivale a `exit`) |
| **Ctrl+R** | Búsqueda inversa en el historial |
| **Ctrl+A** | Ir al inicio de la línea |
| **Ctrl+E** | Ir al final de la línea |
| **Ctrl+Z** | Pausar proceso (`fg` para recuperar, `bg` para segundo plano) |

### Tab — el atajo más importante

```bash
# Antes de Tab:
$ ls /home/ce

# Después de Tab:
$ ls /home/cesar/   ← completado automáticamente

# Tab Tab — ver todas las opciones:
$ ls ~/Do
Documents/   Downloads/
```

> ⭐ Hábito: escribe las primeras 3-4 letras de cualquier nombre y presiona Tab. Siempre.

---

## 7. El código de salida ($?)

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
cal                   # calendario del mes
pwd                   # ¿dónde estoy? (ruta actual)
ls                    # listar archivos del directorio actual

# ── Pedir ayuda ────────────────────────────────────
man ls                # manual completo (salir: q)
ls --help             # resumen rápido de opciones
whatis ls             # descripción en una línea

# ── Historial ──────────────────────────────────────
history               # lista todos los comandos anteriores
history | tail -20    # solo los últimos 20
!498                  # ejecutar número 498 del historial
!!                    # repetir el último comando
sudo !!               # repetir el último con sudo

# ── Código de salida ───────────────────────────────
echo $?               # ver si el último comando tuvo éxito (0) o error

# ── Atajos de teclado ──────────────────────────────
Tab                   # autocompletar (úsalo siempre)
Ctrl+C                # detener proceso
Ctrl+L                # limpiar pantalla
Ctrl+R                # buscar en historial
Ctrl+A / Ctrl+E       # inicio / fin de línea
```

---

## Tu bitácora — preguntas guía para este tema

```markdown
## Tema 1.2 — La Terminal, Shell y Bash

¿Cuáles son las partes de tu prompt?
→ usuario: ___ · máquina: ___ · directorio inicial: ___

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
| **man** | Sistema de manuales integrado en Linux |
| **historial** | Registro de todos los comandos ejecutados, guardado en `~/.bash_history` |
| **autocompletado** | Función de Tab que completa nombres automáticamente |
| **código de salida** | Número que indica si un comando tuvo éxito (0) o falló (≠0) |
| **`$?`** | Variable especial que guarda el código de salida del último comando |

---

*CEM-BIO-101 · Centro de Especialización Multidisciplinario · 2026*
