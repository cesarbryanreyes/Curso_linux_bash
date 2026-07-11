# M1 · Tema 1.4 — Creación, Copia, Movimiento y Eliminación de Archivos

> **CEM-BIO-101** · Módulo 1 · Asincrónica · 15 minutos
> **Nivel:** 0 · **Prerequisito:** Temas 1.1, 1.2 y 1.3
> **Hito:** Organizar y respaldar el genoma de *E. coli* K-12 MG1655 sin alterar el archivo original

---

## Contexto — de organizar a manipular

En el Tema 1.3 creaste la estructura de tu proyecto y descargaste tu primer archivo real: el genoma de *E. coli* K-12 MG1655, en `data/reference/`. Ahora que existe, vas a aprender a manipularlo — copiarlo, moverlo, eliminarlo cuando corresponda — sin arriesgar nunca el original.

> 🔬 **Recordando el Tema 1.3:** es como el tejido original en histología o la muestra de suelo en ecología: solo haces cortes o alícuotas de la muestra original, nunca alteras el bloque o la muestra primaria. Hoy vas a practicar exactamente eso con `cp`.

---

## 1. touch — crear un archivo vacío

```bash
$ touch doc/notas_M1.txt
# → sin salida: si no hay error, funcionó

$ ls -lh doc/
-rw-r--r-- 1 cesar cesar   0 Jul 11 19:40 notas_M1.txt
```
→ El archivo se crea con 0 bytes. Si el archivo YA existe, `touch` no lo borra ni lo vacía — solo actualiza su fecha de modificación.

---

## 2. cp — copiar sin alterar el original

```bash
$ cp data/reference/GCF_000005845.2_ASM584v2_genomic.fna \
      results/copia_prueba.fna

$ ls -lh data/reference/ results/
# → ambos archivos: 4.5M — el original y la copia coexisten
```
→ `cp origen destino` copia el contenido. El original en `data/reference/` no se mueve, no se modifica.

Para copiar una carpeta completa (con todo su contenido) hace falta la bandera `-r` (recursivo):

```bash
$ cp -r plantillas_estudiante/ backup_plantillas/
```
> ⚠ Sin `-r`, `cp` se niega con el mensaje "omitiendo directorio".

---

## 3. mv — mover y renombrar

```bash
# Renombrar (mismo lugar, otro nombre)
$ mv results/copia_prueba.fna results/genoma_backup.fna

# Mover (otro lugar)
$ mv results/genoma_backup.fna data/reference/
```
→ `mv` no duplica: es el mismo archivo, solo cambia de nombre y/o ubicación. Usa la misma sintaxis para ambas operaciones porque, para el sistema de archivos, renombrar ES mover dentro del mismo directorio.

---

## 4. rm y rmdir — eliminar, con cuidado

> ⚠ **Advertencia importante:** a diferencia de arrastrar un archivo a la papelera en Windows o Mac, `rm` en la terminal borra de forma inmediata y permanente. No existe un botón de "deshacer".

```bash
$ rm results/copia_prueba.fna
# → sin salida: se eliminó de forma permanente

$ rm -i results/genoma_backup.fna
→ rm: ¿eliminar results/genoma_backup.fna? (escribe 'y' o 'n')

$ rmdir carpeta_vacia
# → solo funciona si la carpeta está vacía
```
> 🔬 Analogía: `rm` es como desechar una muestra en el contenedor de bioseguridad. Una vez que la tiras ahí, no hay marcha atrás. Usa `-i` (interactivo) mientras te familiarizas con el comando — te pide confirmación antes de borrar.

---

## 5. find — buscar un archivo perdido

```bash
$ find . -name "*.fna"
→ ./data/reference/GCF_000005845.2_ASM584v2_genomic.fna
```
→ `find .` busca a partir del directorio actual, incluyendo todas las subcarpetas. `-name "*.fna"` filtra por nombre, donde `*` es un comodín que significa "cualquier texto".

---

## Referencia rápida

```bash
# ── Crear ──────────────────────────────────────
touch archivo.txt              # crear archivo vacío (o actualizar fecha)

# ── Copiar ─────────────────────────────────────
cp origen destino               # copiar; el original queda intacto
cp -r carpeta/ destino/         # copiar carpeta completa

# ── Mover / renombrar ──────────────────────────
mv origen destino                # mover o renombrar (no duplica)

# ── Eliminar ───────────────────────────────────
rm -i archivo                    # eliminar con confirmación
rmdir carpeta_vacia              # eliminar carpeta vacía

# ── Buscar ─────────────────────────────────────
find . -name "*.ext"             # buscar por nombre desde el directorio actual
```

---

## ✅ Checklist de verificación

- [ ] Creaste `doc/notas_M1.txt` con `touch`
- [ ] Copiaste el genoma a `results/` con `cp`, sin alterar `data/reference/`
- [ ] Renombraste y moviste el archivo copiado con `mv`
- [ ] Eliminaste el archivo de prueba con `rm -i`, confirmando antes de borrar
- [ ] Encontraste el genoma con `find . -name "*.fna"`

---

## Glosario de términos nuevos

| Término | Definición |
|---------|-----------|
| **touch** | Crea un archivo vacío, o actualiza su fecha de modificación si ya existe |
| **cp** | Copy — copia un archivo o carpeta; el original permanece intacto |
| **cp -r** | Copia recursiva — copia una carpeta completa con todo su contenido |
| **mv** | Move — mueve o renombra un archivo o carpeta (no duplica) |
| **rm** | Remove — elimina un archivo de forma permanente (sin papelera) |
| **rm -i** | Elimina pidiendo confirmación antes de cada archivo |
| **rmdir** | Elimina una carpeta, solo si está vacía |
| **find** | Busca archivos y carpetas según criterios como el nombre |
| **comodín (\*)** | Símbolo que representa "cualquier texto" en patrones de búsqueda |

---

## Tu bitácora — preguntas guía

```markdown
## Tema 1.4 — Manipulando archivos sin alterar el original

¿Qué comando usaste para respaldar el genoma sin tocar el archivo original?
→

¿Qué pasó cuando intentaste rmdir sobre una carpeta que no estaba vacía?
→

Resultado de find . -name "*.fna" en tu proyecto:
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
