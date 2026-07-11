# M1 · Tema 1.1 — Fundamentos del Sistema Operativo Linux

> **CEM-BIO-101** · Módulo 1 · Asincrónica · 12 minutos  
> **Nivel:** 0 — sin experiencia previa requerida  
> **Docente:** Mg(c). César Bryan Reyes Moreno

---

## ¿Qué aprenderás en este tema?

Al terminar este tema serás capaz de:

- Explicar cómo está organizado Linux por dentro (las 4 capas)
- Entender qué son el UID y el GID — tu identidad en el sistema
- Distinguir entre **Terminal** (la ventana) y **Shell/Bash** (el intérprete)
- Explicar qué es el `$PATH` y por qué causa el error `command not found`
- Saber para qué sirve `~/.bashrc` y cómo recargarlo con `source`
- Evitar el error #2 más frecuente: la sensibilidad a mayúsculas

---

## 0. ¿Qué es un Sistema Operativo?

Un **Sistema Operativo (S.O.)** es el programa principal que hace funcionar tu computadora. Es el intermediario entre tú y el hardware (pantalla, teclado, disco duro, procesador).

| S.O. | Desarrollado por | ¿Relevante para nosotros? |
|------|-----------------|--------------------------|
| Windows | Microsoft | Sí — muchos lo tienen |
| macOS | Apple | Sí — compatible con Linux |
| **Linux** | Comunidad global | ✅ El que usaremos |

> 💡 **¿Tienes Windows?** No necesitas desinstalarlo. Con **WSL2** puedes tener Linux funcionando DENTRO de Windows, en paralelo.

---

## 1. Cómo está organizado Linux: las 4 capas

Linux funciona en capas apiladas. Cada capa se comunica solo con la que tiene encima y la de abajo.

```
┌──────────────────────────────────────────────────┐
│  TÚ (el usuario — la persona frente a la pantalla)│
│  Escribes comandos · recibes resultados           │
│  🔬 El investigador que da la orden               │
├──────────────────────────────────────────────────┤
│  SHELL · BASH                                    │
│  El programa que lee lo que escribes             │
│  y se lo comunica al kernel                      │
│  🔬 El receptor de membrana / ARN mensajero      │
├──────────────────────────────────────────────────┤
│  KERNEL (núcleo del S.O.)                        │
│  Administra la memoria, el disco, el procesador  │
│  🔬 El núcleo celular (ADN) — controla todo      │
├──────────────────────────────────────────────────┤
│  HARDWARE                                        │
│  CPU · RAM · Disco duro · Pantalla · Teclado     │
│  🔬 Los orgánulos — ejecutan el trabajo físico   │
└──────────────────────────────────────────────────┘
```

### ⚠ Terminal ≠ Shell — distinción fundamental

La **"pantalla negra"** no es una sola cosa. Son dos cosas distintas:

| Concepto | ¿Qué es? | Analogía |
|----------|----------|----------|
| **Terminal** | Solo la VENTANA que ves — la interfaz gráfica | La pantalla del microscopio |
| **Shell (Bash)** | El PROGRAMA que vive dentro e interpreta tus comandos | El sistema óptico que analiza |

> Sin Shell, la terminal es solo una caja vacía que no hace nada.

### ¿Qué pasa cuando escribes `ls` y presionas Enter?

```
① Bash (el Shell) recibe el texto "ls"
② Bash busca el programa ls en las carpetas del $PATH
③ Bash le pide al kernel que lo ejecute
④ El kernel accede al disco y devuelve la lista de archivos
```

```bash
# Comandos de esta sección:
whoami          # ¿quién soy en este sistema?
id              # muestra UID, GID y grupos
```

**Salida esperada de `id`:**
```
uid=1000(cesar) gid=1000(cesar) groups=1000(cesar),4(adm),27(sudo)
#    ↑UID              ↑GID           ↑grupos a los que perteneces
```

---

## 2. ¿Quién eres tú en Linux? UID, GID y permisos

Linux fue diseñado para ser **multiusuario**: múltiples personas pueden usar la misma computadora al mismo tiempo, con sus propios archivos y permisos independientes.

### UID — User ID (Identificador de Usuario)

El **UID** es un número entero único que Linux le asigna a cada usuario. Como tu DNI digital — nadie más tiene el mismo número.

| Rango de UID | ¿A quién corresponde? |
|-------------|----------------------|
| **0** | `root` — el superusuario con acceso total |
| 1 – 999 | Usuarios internos del sistema (servicios automáticos) |
| **1000 en adelante** | Usuarios normales — tú |

### GID — Group ID (Identificador de Grupo)

El **GID** es un número que identifica el grupo al que perteneces. Los grupos permiten compartir permisos entre varios usuarios.

> 🔬 El UID es tu código de investigador personal. El GID es el código de tu laboratorio. Puedes pertenecer a varios grupos, como un investigador en varios proyectos.

### Los tres tipos de identidad

| Tipo | UID | ¿Qué puede hacer? |
|------|-----|-------------------|
| **Usuario normal** | ≥ 1000 | Solo sus archivos y carpetas. No instala software globalmente. |
| **root** | 0 | Acceso total. Un error puede dejar el sistema inutilizable. |
| **sudo** | (no es usuario) | Ejecuta UN comando con permisos de root, temporalmente. |

> ⚠ **En Ubuntu y WSL2:** la cuenta root está bloqueada por defecto. `su -` dará error de autenticación. **Usa siempre: `sudo + el comando`**

```bash
# Comandos de esta sección:
whoami                # imprime: cesar
id                    # uid=1000(cesar) gid=1000(cesar) groups=...
sudo apt update       # actualizar paquetes (estándar Ubuntu/WSL2)
sudo whoami           # imprime: root  ← confirma que sudo funciona
```

---

## 3. ¿Qué es un proceso?

Un **proceso** es un programa que está corriendo en este momento en la memoria de la computadora (RAM).

> 🔬 Cada proceso es como una reacción enzimática activa: tiene un número de identificación (PID), consume recursos (RAM = sustrato, CPU = actividad enzimática), puede correr en paralelo con otras, y puede detenerse.

### Conceptos clave

| Concepto | Definición | Analogía |
|----------|-----------|----------|
| **PID** (Process ID) | Número único de cada proceso | Número de tubo de la reacción |
| **%CPU** | Porcentaje del procesador en uso | Actividad enzimática |
| **%MEM** | Porcentaje de RAM en uso | Consumo de sustrato |

```bash
# Comandos de esta sección:
ps                      # tus procesos en esta terminal
ps aux                  # TODOS los procesos del sistema
top                     # monitor en tiempo real (salir: q)
ps aux | grep fastqc    # ¿sigue corriendo mi análisis?
```

**Salida de `ps aux` (columnas clave):**
```
USER      PID  %CPU %MEM  COMMAND
cesar    1234  85.3  4.2  fastqc sample.fastq
cesar    1235   0.0  0.1  bash
```

> 💡 En análisis de horas en servidores: `ps aux | grep nombre_herramienta` para verificar que sigue activo.

---

## 4. Variables de entorno y el $PATH

### ¿Qué es una variable de entorno?

Una **variable de entorno** es un valor con nombre guardado en la memoria del sistema que todos los programas pueden leer.

El símbolo `$` delante del nombre indica que es una variable: `$PATH`, `$HOME`, `$USER`.

> 🔬 Son como las condiciones ambientales del laboratorio (temperatura, pH) — configuradas y afectan todo lo que ocurre ahí.

### Las variables más importantes

| Variable | ¿Qué contiene? | Ejemplo |
|----------|---------------|---------|
| `$PATH` | Lista de carpetas donde Linux busca programas | `/usr/bin:/usr/local/bin:/home/cesar/miniconda3/bin` |
| `$HOME` | Tu carpeta personal | `/home/cesar` (equivale a `~`) |
| `$USER` | Tu nombre de usuario | `cesar` |
| `$SHELL` | El shell que estás usando | `/bin/bash` |

### El $PATH explicado a fondo

> ⚠ **El 80% de los errores `command not found` tienen una sola causa:** el programa está instalado, pero su carpeta no está en el `$PATH`.

Cuando escribes `fastqc`, Linux **no** busca en toda la computadora. Solo busca en las carpetas del `$PATH`, una por una, en orden.

```
$PATH = /usr/bin : /usr/local/bin : /home/cesar/miniconda3/bin
          ↑              ↑                    ↑
     Busca aquí    luego aquí         luego aquí
     (y para si lo encuentra)
```

> 🔬 El $PATH es el inventario de estanterías del laboratorio. Si instalaste fastqc en el sótano pero el sótano no está en el inventario → "enzima no encontrada", aunque el frasco esté ahí.

**¿Cómo solucionar `command not found` después de instalar una herramienta?**
```bash
# 1. Agregar la carpeta al $PATH en ~/.bashrc:
export PATH="/ruta/de/la/herramienta:$PATH"

# 2. Recargar:
source ~/.bashrc

# 3. Intentar de nuevo
```

```bash
# Comandos de esta sección:
echo $PATH          # ver el inventario de carpetas habilitadas
echo $HOME          # ver tu carpeta personal
echo $USER          # ver tu nombre de usuario
```

### ⚡ MAYÚSCULAS — error #2 más frecuente

```
fastqc ≠ FastQC ≠ FASTQC    (tres comandos distintos para Linux)
$PATH  ≠ $path  ≠ $Path     (tres variables distintas)
datos/ ≠ Datos/              (dos carpetas distintas)
```

**Si algo no funciona → lo primero que revisas son las mayúsculas.**

---

## 5. El archivo ~/.bashrc

### ¿Qué es?

El `.bashrc` es un archivo de texto que Linux lee y ejecuta **automáticamente** cada vez que abres una nueva terminal.

- **bash** = el shell que usa
- **rc** = *run commands* = comandos que se ejecutan al inicio

> 🔬 Es el protocolo de apertura del laboratorio: enciendes equipos, preparas soluciones, calibras instrumentos — automáticamente, cada vez que llegas.

### ¿Por qué el punto al inicio (.bashrc)?

El punto indica que es un **archivo oculto**. `ls` normal no lo muestra. Necesitas `ls -a` para verlo.

```bash
ls ~          # NO muestra .bashrc
ls -a ~       # SÍ muestra .bashrc (y todos los archivos ocultos)
```

### ¿Dónde está?

Siempre en tu carpeta personal: `~/.bashrc` = `/home/tu_usuario/.bashrc`

### ¿Qué se pone dentro?

```bash
# ── Alias (atajos de comandos) ─────────────────────
alias ll='ls -lh'          # ll ahora equivale a ls -lh
alias la='ls -la'          # la muestra archivos ocultos
alias ..='cd ..'           # .. sube un directorio

# ── Agregar herramientas bioinformáticas al PATH ───
export PATH="$HOME/miniconda3/bin:$PATH"

# ── Variables del proyecto ─────────────────────────
export PROYECTO="$HOME/curso_linux_bash"
```

### ¿Cómo ver y recargar?

```bash
cat ~/.bashrc          # ver el contenido completo
source ~/.bashrc       # recargar sin cerrar la terminal
. ~/.bashrc            # equivalente más corto
```

> ⚠ **Sin `source`:** los cambios que hiciste en el `.bashrc` NO tienen efecto hasta que cierres y abras una nueva terminal. Usa `source` siempre después de editar.

---

## Referencia rápida — todos los comandos del Tema 1.1

```bash
# ── Identidad ──────────────────────────────────────
whoami                    # tu nombre de usuario
id                        # UID, GID y todos tus grupos

# ── Permisos temporales ────────────────────────────
sudo comando              # ejecutar un comando como root
sudo apt update           # actualizar lista de paquetes

# ── Variables de entorno ───────────────────────────
echo $PATH                # ver carpetas donde Linux busca programas
echo $HOME                # ver tu carpeta personal
echo $USER                # ver tu nombre de usuario

# ── Configuración ──────────────────────────────────
ls -a ~                   # ver archivos ocultos (incluye .bashrc)
cat ~/.bashrc             # ver el contenido del .bashrc
source ~/.bashrc          # recargar configuración sin cerrar terminal

# ── Procesos ───────────────────────────────────────
ps                        # tus procesos activos
ps aux                    # TODOS los procesos del sistema
ps aux | grep fastqc      # buscar un proceso específico
top                       # monitor en tiempo real (salir: q)
```

---

## Glosario de términos nuevos

| Término | Definición en español llano |
|---------|----------------------------|
| **UID** | Número de identidad único de tu usuario (como un DNI digital) |
| **GID** | Número de identificación de tu grupo |
| **root** | Usuario administrador con acceso total (UID=0) |
| **sudo** | Comando que da permisos temporales de root para una acción |
| **$PATH** | Lista de carpetas donde Linux busca los programas |
| **proceso** | Programa que está corriendo en este momento en la RAM |
| **PID** | Número único que identifica a cada proceso activo |
| **kernel** | Núcleo del S.O. que controla el hardware |
| **shell** | Programa que interpreta los comandos que escribes (Bash es el shell más común) |
| **terminal** | La ventana de texto donde escribes — no es el shell |
| **variable de entorno** | Valor guardado en la memoria del sistema que todos los programas pueden leer |
| **archivo oculto** | Archivo cuyo nombre empieza con punto (.) — ls normal no lo muestra |
| **~/.bashrc** | Archivo de configuración que se ejecuta al abrir cada terminal |
| **source** | Comando que recarga un archivo de configuración sin cerrar la terminal |

---

## Tu bitácora — preguntas guía para documentar este tema

Usa la plantilla en `plantillas_estudiante/bitacora_T11.md` para documentar tu aprendizaje:

```markdown
## Tema 1.1 — Lo que aprendí hoy

**¿Cuál es tu UID?** (resultado de `id`)
→

**¿Aparece "sudo" en tus grupos?** (resultado de `id`)
→ Sí / No

**¿Qué directorios tiene tu $PATH?** (resultado de `echo $PATH`, cuenta los ":")
→

**¿Qué alias agregarías a tu .bashrc y por qué?**
→

**Explica con tus propias palabras: ¿qué es el $PATH?**
→

**¿Qué fue lo más difícil de entender en este tema?**
→

**¿Qué pregunta te quedó pendiente?**
→
```

---

## Referencias

- Noble, W. S. (2009). A quick guide to organizing computational biology projects. *PLoS Computational Biology*, 5(7), e1000424.
- Brandies, P. A., & Hogg, C. J. (2021). Ten simple rules for getting started with command-line bioinformatics. *PLoS Computational Biology*, 17(6), e1009256.
- Perkel, J. M. (2021). Five reasons why researchers should learn to love the command line. *Nature*, 590(7844), 173–174.

---

*CEM-BIO-101 · Centro de Especialización Multidisciplinario · 2026*
