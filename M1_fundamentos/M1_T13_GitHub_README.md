# M1 · Tema 1.3 — Navegación del Sistema de Archivos

> **CEM-BIO-101** · Módulo 1 · Asincrónica · 20 minutos  
> **Nivel:** 0 · **Prerequisito:** Temas 1.1 y 1.2  
> **Hito:** Descargar y verificar el genoma de *E. coli* K-12 MG1655 (GCF_000005845.2)

---

## Contexto — tu primera tarea real

En este tema descargas el **genoma de referencia de *Escherichia coli* K-12 MG1655** desde NCBI RefSeq. Es el organismo modelo de la biología molecular — ideal para aprender navegación sin los tamaños intimidantes de los genomas eucariotas.

| Dato | Valor |
|------|-------|
| Ensamblaje | GCF_000005845.2 (ASM584v2) |
| Accesión | NC_000913.3 |
| Tamaño | 4,641,652 bp ≈ 4.64 Mbp |
| Cromosomas | 1 (circular, sin plásmidos) |
| Formato | FASTA (.fna.gz comprimido) |

---

## 1. El sistema de archivos de Linux

Linux organiza todo en un árbol único que empieza en `/` (la raíz):

```
/                          ← la RAÍZ — punto de partida de todo
├── bin/                   ← programas esenciales (ls, grep, cat...)
├── home/                  ← carpetas personales de usuarios
│   └── cesar/             ← TU carpeta (= $HOME = ~)
│       └── curso_linux_bash/
├── usr/bin/                ← software instalado (fastqc, bwa...)
└── tmp/                   ← archivos temporales
```

> 🔬 **Analogía biológica:** el sistema de archivos es como la taxonomía. `/` es el dominio Biota, `/home` es un phylum, `/home/cesar` es tu especie. Todo tiene una posición única y definida.

---

## 2. Rutas absolutas y relativas

```
Ruta ABSOLUTA — empieza con /
/home/cesar/curso_linux_bash/data/reference/GCF_000005845.2_ASM584v2_genomic.fna
↑ funciona desde cualquier carpeta donde estés

Ruta RELATIVA — sin /
data/reference/GCF_000005845.2_ASM584v2_genomic.fna
↑ solo funciona si estás en /home/cesar/curso_linux_bash/
```

### Atajos especiales

| Atajo | Significa |
|-------|-----------|
| `.` | La carpeta actual (aquí mismo) |
| `..` | La carpeta padre (un nivel arriba) |
| `~` | Tu carpeta personal ($HOME) |
| `/` | La raíz del sistema |

---

## 3. Navegar con pwd, ls y cd

```bash
# ¿Dónde estoy?
$ pwd
/home/cesar/curso_linux_bash/data/reference

# ¿Qué hay aquí?
$ ls
GCF_000005845.2_ASM584v2_genomic.fna

$ cd ~/curso_linux_bash/
$ ls
data/  doc/  results/  scripts/

$ ls -lh data/reference/
-rw-r--r-- 1 cesar cesar 4.5M Jul 11 GCF_000005845.2_ASM584v2_genomic.fna
#          ↑permisos ↑propietario ↑tamaño ↑fecha ↑nombre

# Moverme
$ cd ~/curso_linux_bash/data/reference/   # ir a data/reference/
$ cd ..                                   # subir un nivel (a data/)
$ cd ~                                    # ir a mi home (siempre funciona)
$ cd -                                    # volver a la carpeta anterior
```

> 💡 Si te pierdes: `cd` sin argumentos siempre te lleva a tu home. Luego `pwd` para confirmar.

---

## 4. Crear la estructura del proyecto — Noble (2009)

```bash
$ mkdir -p ~/curso_linux_bash/{data/raw_reads,data/reference,scripts,results,doc}
$ ls ~/curso_linux_bash/
data/  doc/  results/  scripts/

$ ls ~/curso_linux_bash/data/
raw_reads/  reference/
```

**Estructura resultante:**
```
~/curso_linux_bash/
├── data/               ← datos CRUDOS (solo lectura — nunca modificar)
│   ├── raw_reads/      ← lecturas FASTQ crudas (se usan desde el Módulo 4)
│   └── reference/       ← genoma(s) de referencia
│       └── GCF_000005845.2_ASM584v2_genomic.fna
├── scripts/            ← tus scripts .sh
├── results/             ← salidas de análisis
└── doc/                ← notas y documentación
```

> ⚠ **Regla de oro:** la carpeta `data/` es solo lectura. Tus análisis leen de `data/` y escriben en `results/`. Si dañas los datos originales, tendrás que descargarlos de nuevo.

> 🔬 Como el tejido original en histología: haces cortes de la muestra, nunca alteras el bloque primario.

> 💡 **Sobre `raw_reads/` y `reference/`:** separar `data/` en subcarpetas por tipo de dato es una extensión práctica de Noble (2009) — mantiene los genomas de referencia y las lecturas de secuenciación crudas claramente diferenciados a medida que el proyecto crece. En este tema solo usarás `reference/`; `raw_reads/` ya trae un FASTQ de ejemplo que trabajaremos en el Módulo 4 (FastQC).

---

## 5. Descargar el genoma con wget

```bash
# Paso 1 — posicionarse en la subcarpeta correcta
$ cd ~/curso_linux_bash/data/reference/

# Paso 2 — descargar
$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
```

**Salida esperada al terminar:**
```
'GCF_000005845.2_ASM584v2_genomic.fna.gz' saved [1477302/1477302]
```

> ⚠ El archivo termina en `.gz` — está comprimido. No puedes leerlo directamente. Descomprímelo con `gunzip`.

---

## 6. Descomprimir e inspeccionar

Formato: **comando → salida esperada → explicación**

### Comando 3 — Descomprimir

```bash
$ gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz
$ ls -lh
```
**Salida esperada:**
```
-rw-r--r-- 1 cesar cesar 4.5M ... GCF_000005845.2_ASM584v2_genomic.fna
```
→ El archivo ahora mide 4.5 MB (era 1.4 MB comprimido).

---

### Comando 4 — Ver la cabecera del FASTA

```bash
$ head -1 GCF_000005845.2_ASM584v2_genomic.fna
```
**Salida esperada:**
```
>NC_000913.3 Escherichia coli str. K-12 substr. MG1655, complete genome
```
→ Las líneas que empiezan con `>` en FASTA son cabeceras. `NC_000913.3` es el número de accesión RefSeq del cromosoma.

---

### Comando 5 — ¿Cuántas secuencias tiene?

```bash
$ grep -c ">" GCF_000005845.2_ASM584v2_genomic.fna
```
**Salida esperada:**
```
1
```
→ `grep -c` cuenta las líneas que contienen `>`. Resultado `1` = un solo cromosoma circular, sin plásmidos.

---

### Comando 6 — Longitud del genoma

```bash
$ grep -v ">" GCF_000005845.2_ASM584v2_genomic.fna | tr -d '\n' | wc -c
```
**Salida esperada:**
```
4641652
```
→ Pipe de 3 comandos: excluye cabeceras → une todo → cuenta caracteres (bases). Resultado: **4,641,652 bp ≈ 4.64 Mbp** ✅

---

## 7. Un vistazo a raw_reads/ (adelanto del Módulo 4)

```bash
$ cd ~/curso_linux_bash/data/raw_reads/
$ ls -lh
```
**Contenido que verás:**
```
SRR2589044_1.trim.sub.fastq
sub.tar
```
→ No los modifiques aún: son las lecturas crudas de secuenciación que usaremos al llegar al control de calidad con FastQC (Módulo 4). Por ahora, basta con saber dónde viven dentro de la estructura del proyecto.

---

## Referencia rápida

```bash
# ── Navegación ────────────────────────────────────
pwd                          # ¿dónde estoy?
ls                           # ¿qué hay aquí?
ls -lh                       # lista con tamaño legible
ls -la                       # incluye archivos ocultos
cd ruta/                     # ir a esa carpeta
cd ..                        # subir un nivel
cd ~                         # ir al home
cd -                         # volver a la carpeta anterior

# ── Crear estructura ──────────────────────────────
mkdir -p ruta/{a,b,c}        # crear árbol de carpetas

# ── Descargar y descomprimir ──────────────────────
wget URL                     # descargar archivo de internet
gunzip archivo.gz            # descomprimir .gz

# ── Inspeccionar FASTA ────────────────────────────
head -1 archivo.fna          # ver la cabecera
head -5 archivo.fna          # ver las primeras 5 líneas
grep -c ">" archivo.fna      # contar secuencias
grep -v ">" fna | tr -d '\n' | wc -c   # contar bases
```

---

## ✅ Checklist de verificación

- [ ] Estructura del proyecto creada: `~/curso_linux_bash/{data/raw_reads,data/reference,scripts,results,doc}`
- [ ] Genoma descargado en `data/reference/`: `GCF_000005845.2_ASM584v2_genomic.fna.gz`
- [ ] Genoma descomprimido: `GCF_000005845.2_ASM584v2_genomic.fna` (4.5 MB)
- [ ] `head -1` → `>NC_000913.3 Escherichia coli str. K-12 substr. MG1655, complete genome`
- [ ] `grep -c ">"` → `1`
- [ ] `wc -c` → `4641652`
- [ ] Ubicaste el contenido de `data/raw_reads/` (lo usarás en el Módulo 4)

---

## Glosario de términos nuevos

| Término | Definición |
|---------|-----------|
| **sistema de archivos** | Árbol jerárquico donde Linux organiza todo el contenido |
| **/** | La raíz — punto de partida de todo el árbol |
| **ruta absoluta** | Dirección completa desde la raíz (`/home/cesar/...`) |
| **ruta relativa** | Dirección desde tu posición actual (sin /) |
| **pwd** | Print Working Directory — muestra tu posición actual |
| **mkdir** | Make Directory — crea una carpeta |
| **mkdir -p** | Crea toda la jerarquía de carpetas de una vez |
| **wget** | Programa para descargar archivos de internet |
| **gunzip** | Descomprime archivos .gz |
| **.gz** | Formato de compresión gzip — como ZIP en Windows |
| **FASTA** | Formato de archivo para secuencias biológicas |
| **cabecera FASTA** | Línea que empieza con > e identifica la secuencia |
| **head** | Muestra las primeras líneas de un archivo |
| **grep -c** | Cuenta cuántas líneas contienen un patrón |
| **raw_reads/** | Subcarpeta de `data/` para lecturas de secuenciación crudas (FASTQ) |
| **reference/** | Subcarpeta de `data/` para genomas de referencia (FASTA) |

---

## Tu bitácora — preguntas guía

```markdown
## Tema 1.3 — Navegación y Descarga del Genoma

¿Cuál es la ruta absoluta de tu carpeta data/reference/?
→

Resultado de head -1 en tu genoma descargado:
→

Resultado de grep -c ">":
→

Resultado de wc -c:
→

¿Coincide con 4641652? Sí / No

¿Qué viste al listar data/raw_reads/?
→

¿Qué fue lo más difícil de navegar el sistema de archivos?
→

¿Qué pregunta te quedó pendiente?
→
```

---

## Referencias

- Noble, W.S. (2009). A quick guide to organizing computational biology projects. *PLoS Computational Biology*, 5(7), e1000424.
- NCBI RefSeq: [GCF_000005845.2](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000005845.2/)

---

*CEM-BIO-101 · Centro de Especialización Multidisciplinario · 2026*
