# M1 · Tema 1.5 — Permisos de Ejecución para tus Propios Scripts

> **CEM-BIO-101** · Módulo 1 · Asincrónica · ≈ 21 minutos (13 min núcleo + 8 min de profundización en permisos)
> **Nivel:** 0 · **Prerequisito:** Temas 1.1, 1.2, 1.3 y 1.4
> **Hito:** Crear, escribir, verificar y ejecutar tu primer script `.sh` propio, dándole el permiso de ejecución que le falta

---

## 1. Crear tu primer script: touch, nano y cat

### touch — crear el archivo

Antes de poder ejecutar un script, primero tiene que existir. `touch` crea un archivo vacío — el mismo comando que ya usaste en el Tema 1.4, ahora aplicado a tu primer script.

```bash
$ touch scripts/saludo.sh
$ ls -l scripts/saludo.sh
-rw-r--r-- 1 cesar cesar   0 Jul 11 19:38 scripts/saludo.sh
# → el archivo existe, pero está vacío (0 bytes) y sin permiso de ejecución (x)
```

### nano — escribir, guardar y salir

`nano` es un editor de texto que corre directo en la terminal, sin salir de ella.

```bash
$ nano scripts/saludo.sh

#!/bin/bash
echo "Hola, soy tu primer script"

# Ctrl+O (guardar) → Enter (confirmar nombre) → Ctrl+X (salir de nano)
```
→ Escribe las dos líneas dentro de nano. **Ctrl+O** guarda el archivo (nano te confirma el nombre, presiona Enter). **Ctrl+X** cierra nano y te regresa a la terminal — el archivo queda guardado en disco.

### cat — verificar el contenido

Antes de intentar ejecutar nada, conviene revisar que el archivo tiene exactamente el contenido que escribiste.

```bash
$ cat scripts/saludo.sh
→ #!/bin/bash
→ echo "Hola, soy tu primer script"
# → si ves exactamente estas dos líneas, el guardado funcionó
```

---

## 2. Escribiste tu primer script. Y no se ejecuta

Con el archivo ya creado, escrito y verificado, lo intentas ejecutar:

```bash
$ ./scripts/saludo.sh
bash: ./scripts/saludo.sh: Permiso denegado
```

> ❓ **¿Por qué pasa esto?** Crear un archivo (Tema 1.4) no es lo mismo que darle permiso para ejecutarse. Aunque el contenido sea código válido, Linux no lo va a correr hasta que tú, explícitamente, le des permiso de ejecución.

---

## 3. ls -l — leer los permisos a fondo

```bash
$ ls -l scripts/saludo.sh
-rw-r--r-- 1 cesar cesar  45 Jul 11 19:40 scripts/saludo.sh
```

### Una línea, siete datos

| Columna | Valor en el ejemplo | Qué significa |
|---|---|---|
| Tipo y permisos | `-rw-r--r--` | Tipo de archivo + permisos de los 3 niveles |
| Enlaces | `1` | Número de enlaces duros al archivo |
| Propietario | `cesar` | Usuario dueño del archivo |
| Grupo | `cesar` | Grupo asignado al archivo |
| Tamaño | `45` | Tamaño en bytes |
| Modificado | `Jul 11 19:40` | Fecha de la última modificación |
| Ruta | `scripts/saludo.sh` | Nombre y ubicación del archivo |

### Anatomía del bloque -rw-r--r--

| Posición | Nombre | Significado |
|---|---|---|
| 1 carácter (`-`) | Tipo de archivo | `-` = archivo regular. Si fuera `d`, sería un directorio. |
| caracteres 2-4 (`rw-`) | Propietario | cesar → lectura (r) y escritura (w). Sin permiso de ejecución. |
| caracteres 5-7 (`r--`) | Grupo | grupo cesar → solo lectura (r). |
| caracteres 8-10 (`r--`) | Otros | cualquier otro usuario del sistema → solo lectura (r). |

r = read (leer) · w = write (escribir) · x = execute (ejecutar). Mnemónico: **P-G-O** (Propietario-Grupo-Otros).

> 🔍 Ninguna de las tres posiciones tiene `x` — por eso `scripts/saludo.sh` no se ejecuta todavía.

### ¿Por qué "cesar" aparece dos veces?

Columna 3 (Propietario) y columna 4 (Grupo) muestran "cesar" en este ejemplo, pero no son lo mismo:

- **Propietario**: el usuario dueño del archivo — la cuenta que lo creó. Sobre él se aplican los permisos de las posiciones 2-4 (`rw-`).
- **Grupo**: el grupo asignado al archivo. En Ubuntu/Debian, cada usuario nuevo recibe por defecto un grupo personal con su mismo nombre ("user private group"). Por eso ambas columnas dicen "cesar" sin ser lo mismo.
- **Otros**: está implícito — son los demás usuarios del sistema, distintos a "cesar".

### Permisos base: ¿qué significa cada letra?

| Letra | Nombre | Qué permite |
|---|---|---|
| r | read (lectura) | Abrir y ver el contenido del archivo, o listar el contenido si es un directorio |
| w | write (escritura) | Modificar, sobrescribir o borrar el archivo |
| x | execute (ejecución) | Correr el archivo como programa o script, o "entrar" a un directorio |

### Precisión terminológica: archivo, directorio y carpeta

| Término | En ls -l | Qué es |
|---|---|---|
| Archivo (file) | `-rw-r--r--` | Unidad básica que almacena datos reales: el código de un script, texto, una imagen |
| Directorio (directory) | `drwxr-xr-x` | Término técnico de Linux/Unix: un archivo especial que solo contiene una lista de nombres y sus direcciones en el disco |
| Carpeta (folder) | N/A en ls -l | Representación visual de un directorio en una interfaz gráfica (explorador de Windows, escritorio de Ubuntu) |

"Directorio" y "carpeta" se refieren a lo mismo en la práctica, pero "directorio" es el término correcto en la terminal; "carpeta" es su representación gráfica.

> 🧬 **Principio Unix/Linux — "todo es un archivo":** un directorio no es un contenedor físico: es un archivo especial que guarda una tabla con los nombres de lo que "vive" dentro de él y la dirección en disco (inodo) de cada uno. Un archivo regular guarda el contenido que tú escribes; un archivo de directorio guarda la lista de archivos que contiene y dónde encontrarlos. Por eso comandos como `rm`, `ls` o `cp` simplemente manipulan archivos en ambos casos, solo que con comportamientos distintos según el tipo (el carácter `d` al inicio de `ls -l`).

---

## 4. chmod +x — activar la ejecución (forma simbólica)

> 🔬 **Analogía:** un proceso es como una reacción enzimática activa — la enzima solo cataliza si tiene la conformación correcta. `chmod +x` le da a tu script esa "conformación activa".

```bash
$ chmod +x scripts/saludo.sh

$ ls -l scripts/saludo.sh
-rwxr-xr-x 1 cesar cesar  45 Jul 11 19:40 scripts/saludo.sh
#          ↑ ahora las tres posiciones tienen x
```
→ `chmod` ("change mode") modifica los permisos. `+x` agrega permiso de ejecución para el propietario, el grupo y otros a la vez.

---

## 5. chmod 755 — el mismo resultado, en números

| Permiso | Valor |
|---|---|
| r | 4 |
| w | 2 |
| x | 1 |

Se suman por grupo: `rwx` = 4+2+1 = **7** · `r-x` = 4+0+1 = **5**

```bash
$ chmod 755 scripts/saludo.sh
# 7 → rwx (Propietario)
# 5 → r-x (Grupo)
# 5 → r-x (Otros)
```
→ `755` y `+x` llegan al mismo resultado para este caso. `755` te da control exacto sobre los tres niveles a la vez; `+x` es el atajo rápido más usado.

---

## 6. ./script.sh — por qué el "./" es obligatorio

```bash
$ ./scripts/saludo.sh
→ Hola, soy tu primer script
```

> 🧭 **¿Recuerdas $PATH del Tema 1.1?** Comandos como `ls` o `cd` funcionan sin `./` porque viven en carpetas listadas en `$PATH` — el inventario oficial de reactivos del laboratorio. Tu script vive en tu propia carpeta, que NO está en ese inventario. El `./` le dice a Bash: "busca aquí mismo, en el directorio actual".

---

## Referencia rápida

```bash
touch archivo.sh        # crear un archivo vacío
nano archivo.sh          # abrir el editor de texto (Ctrl+O guarda, Ctrl+X sale)
cat archivo.sh            # ver el contenido completo del archivo
ls -l archivo            # ver permisos, propietario, grupo, tamaño y fecha
chmod +x script.sh       # dar permiso de ejecución (símbolo)
chmod 755 script.sh      # dar permiso de ejecución (número)
./script.sh              # ejecutar un script en el directorio actual
```

---

## ✅ Checklist de verificación

- [ ] Creaste `scripts/saludo.sh` con `touch`, escribiste su contenido con `nano` y lo verificaste con `cat`
- [ ] Leíste los permisos de `scripts/saludo.sh` con `ls -l` e identificaste las 7 columnas
- [ ] Diste permiso de ejecución con `chmod +x` (o `chmod 755`)
- [ ] Ejecutaste tu script con `./scripts/saludo.sh` y viste el mensaje en pantalla

---

## Glosario de términos nuevos

| Término | Definición |
|---------|-----------|
| **touch** | Crea un archivo vacío (repaso del Tema 1.4) |
| **nano** | Editor de texto que corre dentro de la terminal |
| **cat** | Muestra el contenido completo de un archivo de texto |
| **permisos** | Reglas que definen quién puede leer, escribir o ejecutar un archivo |
| **rwx** | read (leer), write (escribir), execute (ejecutar) |
| **P-G-O** | Propietario / Grupo / Otros — los tres niveles de permisos |
| **user private group** | Esquema de Ubuntu/Debian donde cada usuario recibe un grupo personal con su mismo nombre |
| **directorio** | Término técnico de un archivo especial que lista otros archivos (equivale a "carpeta" en interfaz gráfica) |
| **inodo** | Dirección en disco donde vive el contenido real de un archivo |
| **chmod** | "change mode" — comando para modificar permisos |
| **chmod +x** | Agrega permiso de ejecución (forma simbólica) |
| **chmod 755** | Agrega permiso de ejecución (forma numérica: rwx=7, r-x=5) |
| **./** | Prefijo que indica "en el directorio actual", necesario porque tu carpeta no está en $PATH |
| **Permiso denegado** | Mensaje de error cuando intentas ejecutar un archivo sin permiso de ejecución |

---

## Tu bitácora — preguntas guía

```markdown
## Tema 1.5 — Permisos de ejecución

Contenido que escribiste en scripts/saludo.sh con nano:
→

¿Qué mostró ls -l antes de darle permiso de ejecución a tu script?
→

¿Qué comando usaste para darle permiso: chmod +x o chmod 755?
→

Salida de tu script al ejecutarlo con ./:
→

¿Qué fue lo más difícil de esta lección?
→

¿Qué pregunta te quedó pendiente?
→
```

---

## Referencias

- Noble, W.S. (2009). A quick guide to organizing computational biology projects. *PLoS Computational Biology*, 5(7), e1000424.
- Brandies, P.A., & Hogg, C.J. (2021). Ten simple rules for getting started with command-line bioinformatics. *PLoS Computational Biology*, 17(6), e1009256.

---

*CEM-BIO-101 · Centro de Especialización Multidisciplinario · 2026*
