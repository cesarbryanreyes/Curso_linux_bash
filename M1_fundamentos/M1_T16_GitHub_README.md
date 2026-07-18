# M1 · Tema 1.6 — Flujos Estándar, Redirecciones y Pipes

> **CEM-BIO-101** · Módulo 1 · Asincrónica · ≈ 18 minutos · **Cierre del Módulo 1**
> **Nivel:** 0 · **Prerequisito:** Temas 1.1 a 1.5

---

## ¿Qué aprenderás en este tema?

Al terminar este tema serás capaz de:

- Explicar los 3 canales de comunicación de todo comando: stdin, stdout, stderr
- Redirigir una salida a un archivo con `>` (sobreescribir) y `>>` (añadir)
- Separar los mensajes de error con `2>`
- Encadenar comandos con pipes (`|`)
- Entender exactamente cómo se calculó `4641652` en el Tema 1.3

---

## 1. Todo comando tiene tres canales de comunicación

Hasta ahora, la salida de cada comando aparece en tu pantalla. Pero la pantalla es solo el destino **por defecto** — puedes redirigirla a otro lugar.

| Canal | Número | ¿Qué es? | Por defecto |
|-------|--------|----------|-------------|
| **stdin** | 0 | Entrada — lo que el comando recibe | tu teclado |
| **stdout** | 1 | Salida normal — el resultado del comando | tu pantalla |
| **stderr** | 2 | Salida de error — los mensajes de error | tu pantalla |

---

## 2. `>` y `>>` — redirigir la salida a un archivo

### El ejemplo más básico

```bash
$ echo "Hola Bash" > saludo.txt
$ cat saludo.txt
Hola Bash

$ echo "Segunda línea" >> saludo.txt
$ cat saludo.txt
Hola Bash
Segunda línea
```

| Operador | ¿Qué hace? |
|----------|-----------|
| `>` (un solo signo) | **Sobreescribe** el archivo completo. Si ya tenía contenido, lo pierde. |
| `>>` (doble signo) | **Añade** al final del archivo, conservando lo que ya había. |

> ⚠ Cuidado: `>` sin querer sobre un archivo importante lo borra sin avisar. Si dudas, usa `>>`.

### No son exclusivos de `echo`

```bash
$ ls -lh data/reference/ > doc/inventario.txt
$ cat doc/inventario.txt
-rw-r--r-- 1 cesar cesar 4.5M Jul 11 19:40 GCF_000005845.2_ASM584v2_genomic.fna

$ date >> doc/inventario.txt
$ cat doc/inventario.txt
-rw-r--r-- 1 cesar cesar 4.5M Jul 11 19:40 GCF_000005845.2_ASM584v2_genomic.fna
Sat Jul 11 19:45:00 -05 2026
```
→ Cualquier comando que normalmente imprime en pantalla (`ls`, `date`, `wc`, `grep`...) puede redirigirse igual que `echo`. `>` y `>>` no le preguntan al comando qué es — solo capturan su salida.

---

## 3. `2>` — separar los errores

```bash
$ ls carpeta_inexistente 2> errores.log
# → sin nada en pantalla: el error fue a errores.log, no a stdout

$ cat errores.log
ls: cannot access 'carpeta_inexistente': No such file or directory

$ ls -lh data/reference/ > doc/inventario.txt 2>&1
# → junta stdout Y stderr en el mismo archivo
```
→ Como stdout y stderr son canales independientes, puedes mandar cada uno a un lugar distinto. Muy útil para separar resultados válidos de mensajes de error al correr análisis largos (por ejemplo, un FastQC sobre cientos de archivos).

---

## 4. Pipes (`|`) — empezar simple

Antes de aplicarlo a tu genoma, practica con comandos que ya conoces:

```bash
$ echo "hola mundo bioinformática" | wc -w
3
# cuenta cuántas PALABRAS produjo echo

$ ls data/reference/ | wc -l
1
# cuenta cuántos ARCHIVOS hay en esa carpeta

$ history | tail -5
# tus últimos 5 comandos
```

> ¿Recuerdas que en el Tema 1.2 dijimos que esto se vería en el 1.6? Es ahora.

### `|` aplicado a tu genoma

```bash
$ grep ">" data/reference/GCF_000005845.2_ASM584v2_genomic.fna | wc -l
1
# grep encuentra el header, wc -l cuenta cuántas líneas le llegaron
```

> **Analogía:** como una vía metabólica, donde el producto de una reacción enzimática es el sustrato de la siguiente. `grep ">"` produce el "metabolito" (las líneas con header). `wc -l` lo consume y produce el conteo. Ninguno de los dos necesita saber cómo funciona el otro — solo pasan el producto por la tubería.

---

## 5. Cumpliendo la promesa del Tema 1.3

Esta es exactamente la pipe de 3 pasos que usaste para verificar el genoma en el Tema 1.3 — ahora sabes cómo funciona cada parte:

```bash
$ grep -v ">" data/reference/GCF_000005845.2_ASM584v2_genomic.fna \
  | tr -d '\n' | wc -c
4641652
```

| Paso | Comando | ¿Qué hace? |
|------|---------|-----------|
| 1 | `grep -v ">"` | Toma TODAS las líneas EXCEPTO la cabecera — solo queda la secuencia |
| 2 | `tr -d '\n'` | Elimina los saltos de línea: une toda la secuencia en un solo bloque |
| 3 | `wc -c` | Cuenta los caracteres restantes = las bases del genoma |

**4,641,652 bp ≈ 4.64 Mbp** — el mismo número que ya verificaste en el Tema 1.3.

---

## Referencia rápida — todos los comandos del Tema 1.6

```bash
# ── Redirección de salida ──────────────────────────
cmd > archivo          # sobreescribir
cmd >> archivo         # añadir
cmd 2> archivo         # redirigir solo errores
cmd > out 2>&1         # stdout y stderr juntos

# ── Pipes ───────────────────────────────────────────
cmd1 | cmd2            # encadenar: salida de cmd1 = entrada de cmd2
echo "..." | wc -w     # contar palabras
ls carpeta/ | wc -l    # contar archivos
grep -v ">" archivo.fna | tr -d '\n' | wc -c   # contar bases de un FASTA
```

---

## Glosario de términos nuevos

| Término | Definición en español llano |
|---------|------------------------------|
| **stdin** | Canal de entrada de un comando (por defecto, el teclado) |
| **stdout** | Canal de salida normal de un comando (por defecto, la pantalla) |
| **stderr** | Canal de salida de errores de un comando (por defecto, también la pantalla) |
| **redirección** | Cambiar el destino por defecto de stdout o stderr, usando `>`, `>>` o `2>` |
| **`>`** | Redirige y sobreescribe el archivo destino |
| **`>>`** | Redirige y añade al final del archivo destino |
| **`2>`** | Redirige solo los mensajes de error |
| **`2>&1`** | Une stderr con stdout en el mismo destino |
| **pipe (`\|`)** | Conecta la salida de un comando con la entrada del siguiente |

---

## Tu bitácora — preguntas guía para documentar este tema

Usa la plantilla en `plantillas_estudiante/bitacora_T16.md` para documentar tu aprendizaje:


---

## Referencias

- Noble, W.S. (2009). A quick guide to organizing computational biology projects. *PLoS Computational Biology*, 5(7), e1000424.

---

*CEM-BIO-101 · Centro de Especialización Multidisciplinario · 2026*
