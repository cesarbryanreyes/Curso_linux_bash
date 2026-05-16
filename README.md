# Webinar: Primeros pasos en bioinformática con Linux y Bash

> Repositorio público de referencia del webinar gratuito del **sábado 16 de mayo de 2026** organizado por el **Centro de Especialización Multidisciplinario (CEM)**.

**Fecha del webinar:** sábado 16 de mayo de 2026 · 5:00 PM (hora de Lima, Peru)

**Docente:** Mg(c). César Bryan Reyes Moreno · [UNMSM](https://www.unmsm.edu.pe/)
**ORCID:** [0000-0001-7346-2917](https://orcid.org/0000-0001-7346-2917)

---

## ¿Qué encontrarás aquí?

Este repositorio contiene los **comandos esenciales** del demo en vivo del webinar, listos para que los repliques en tu propia computadora. 

> **Importante:** este repositorio NO es un curso. Es una guía de referencia rápida del demo del webinar. Si quieres aprender los fundamentos desde cero, inscríbete al curso completo **Fundamentos de Linux y Bash Scripting para Bioinformática** (inicio: 13 de junio de 2026).

---

## Antes de empezar: requisitos técnicos

### Sistema operativo
- **Windows 10/11:** instalar [WSL2 con Ubuntu]
- **macOS:** usar la terminal nativa (Terminal.app) o iTerm2
- **Linux:** usar la terminal nativa

---

## CASO I: Datos crudos de secuenciación (FASTQ)

### Descarga del archivo

```bash
# Desde mi directorio de trabajo Cursos_bioinformatica
mkdir -p webinar_linux_bash/data/raw_reads
cd webinar_linux_bash/data/raw_reads
wget https://github.com/cesarbryanreyes/Curso_linux_bash/releases/download/v1.0/sub.tar
tar -xvf sub.tar
ls -lh
```

**Resultado esperado:** archivo `SRR2589044_1.trim.sub.fastq` de 58 MB.

**Origen:** Experimento de Richard Lenski sobre evolución a largo plazo de *Escherichia coli*.

---

### COMANDO 1 — Ver dentro del archivo descomprimido

```bash
head -8 SRR2589044_1.trim.sub.fastq
```

**Salida esperada:**

```
@SRR2589044.1 1/1
CGCGTCCATTAATCCAGGCGTACGGCAAGCATGAGGTCAGCAAGAGCG...
+
AAFFFKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK...
@SRR2589044.2 2/1
AGCCAATGCAGTTTGCTGTACATCGCCATCCAGCAACCTGTGGGCGT...
+
AAFFFKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK...
```

**Explicación:** `head -8` toma solo las primeras 8 líneas. Cada lectura FASTQ ocupa **4 líneas**: identificador, secuencia, separador (`+`) y calidades (codificacion Phred+33 / ASCII).

---

### COMANDO 2 — Contar lecturas

```bash
echo "$(($(cat SRR2589044_1.trim.sub.fastq | wc -l) / 4))"
```

**Salida esperada:**

```
Total: 1108029
```

**Explicación:**  `cat` lee el archivo y lo envía por el pipe `|` a  `wc -l` que cuenta el número total de líneas. Dividir entre 4 da el número de lecturas (porque cada lectura ocupa 4 líneas). `$( ... )` ejecuta un comando y captura su salida, mientras que `$(( ... ))` hace la operación matemática en Bash. Finalmente, `echo` imprime el resultado. **Ciento setenta y cinco mil reads (secuencias) en menos de 5 segundos.** 

---

### COMANDO 3 — Largo promedio de las lecturas

```bash
# Paso 1 — Extraer solo las líneas de secuencia
cat SRR2589044_1.trim.sub.fastq | awk 'NR%4==2' > solo_secuencias.txt

# Paso 2 — Calcular el largo de cada secuencia
awk '{print length($0)}' solo_secuencias.txt > largos.txt

# Paso 3 — Calcular el promedio
awk '{sum+=$1; n++} END {print "Largo promedio:", sum/n, "bp"}' largos.txt
```

**Salida esperada:**

```
Largo promedio: 139.105 bp
```
**Explicación:**
- **Paso 1:** `cat` lee el archivo y lo envía por el pipe `|` a `awk`, una herramienta que procesa texto línea por línea permitiendo filtrar, calcular e imprimir resultados. `NR%4==2` usa el operador módulo `%` para seleccionar únicamente las líneas de secuencia — como cada read FASTQ ocupa exactamente 4 líneas (encabezado, secuencia, `+`, calidad), el residuo de dividir el número de línea `NR` entre `4` siempre es `2` cuando cae en una línea de secuencia. El resultado se guarda en `solo_secuencias.txt`.
- **Paso 2:** `awk` recorre cada línea de `solo_secuencias.txt`, `length($0)` mide el número de caracteres de cada secuencia y `print` imprime ese número. El resultado — un largo por línea — se guarda en `largos.txt`.
- **Paso 3:** `awk` recorre cada línea de `largos.txt` acumulando el valor de cada línea en `sum` y contando cuántas líneas hay en `n`. Al finalizar todas las líneas (`END`), `print` imprime el promedio dividiendo `sum` entre `n`, expresado en pares de bases (bp).

> **Tip:** Puedes inspeccionar los archivos intermedios con `head solo_secuencias.txt` y `head largos.txt` para entender qué hace cada paso.

---
### COMANDO 4 — Detectar contaminación de adaptador Illumina

```bash
### Ejemplo 1
# Paso 1 — Extraer solo las líneas de secuencia
cat SRR2589044_1.trim.sub.fastq | awk 'NR%4==2' > solo_secuencias.txt

# Paso 2 — Contar lecturas con adaptador
grep -c "AGATCGGAAGAG" solo_secuencias.txt

### Ejemplo 2
# Paso 1 — Extraer solo las líneas de secuencia
cat SRR33374132_2_extra.fastq | awk 'NR%4==2' > solo_secuencias_ejemplo2.txt

# Paso 2 — Contar lecturas con adaptador
## Adaptador TruSeq (el más común - read 1)
grep -c "AGATCGGAAGAG" solo_secuencias_ejemplo2.txt

## Adaptador TruSeq read 2
grep -c "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT" solo_secuencias_ejemplo2.txt

## Nextera
grep -c "CTGTCTCTTATACACATCT" solo_secuencias_ejemplo2.txt

## Small RNA
grep -c "ATGGAATTCTCGGGTGCCAAGG" solo_secuencias_ejemplo2.txt
```

**Salida esperada:**
```
0 para ejemplo 1 en TruSeq R1
27 para ejemplo 2 en TruSeq R1
```

**Explicación:**
- **Paso 1:** `cat` lee el archivo y lo envía a `awk`, que con `NR%4==2` extrae únicamente las líneas de secuencia y las guarda en `solo_secuencias.txt`.
- **Paso 2:** `grep` busca la cadena `AGATCGGAAGAG` dentro de cada línea de `solo_secuencias.txt`. `AGATCGGAAGAG` es la secuencia de inicio del adaptador estándar de Illumina. El flag `-c` en lugar de imprimir las líneas que coinciden, cuenta cuántas lecturas la contienen — detectando así contaminación de adaptador que debe ser removida antes del análisis (~16% de las lecturas en este caso).

**Explicación:**
- **Paso 1:** `cat` lee el archivo y lo envía a `awk`, que con `NR%4==2` extrae únicamente las líneas de secuencia y las guarda en `solo_secuencias_ejemplo2.txt`.
- **Paso 2:** `grep -c` busca y cuenta lecturas que contienen cada adaptador. Los adaptadores **no dependen del tipo de experimento** (DNA-seq, RNA-seq, ChIP-seq) sino del **kit de Illumina** utilizado para preparar la librería. El adaptador TruSeq `AGATCGGAAGAG` es uno de los más frecuentes en experimentos.

> **Esto es exactamente lo que detecta FastQC**, la herramienta que aprenderás en el Curso.
---

## CASO II: Proteoma anotado (MULTIFASTA)

### Ubicarse en el directorio de trabajo Cursos_bioinformatica
```bash
cd ~/Cursos_bioinformatica/
```

### Descarga del archivo

```bash
mkdir -p webinar_linux_bash/data/proteome
cd webinar_linux_bash/data/proteome
wget -O ecoli_proteome.fasta.gz "https://rest.uniprot.org/uniprotkb/stream?query=organism_id:83333+AND+reviewed:true&format=fasta&compressed=true"
gunzip ecoli_proteome.fasta.gz
ls -lh
```

**Resultado esperado:** archivo `ecoli_proteome.fasta` de ~5 MB con aproximadamente 4,400 proteínas anotadas de *E. coli* K-12 descargado de UniProt.

---

### COMANDO 1 — Ver dentro del archivo

```bash
head -10 ecoli_proteome.fasta
```

**Salida esperada (parcial):**
```
>sp|P0A6F3|GLPK_ECOLI Glycerol kinase OS=Escherichia coli (strain K12) OX=83333 GN=glpK PE=1 SV=3
MTEKKYIVALDQGTTSSRAVVMDHDANIISVSQREFEQIYPKPGWVEHDPMEIWATQSSTL
VEVLAKADISSDQIAAIGITNQRETTIVWEKETGKPIYNAIVWQCRRTAEICEHLKRDGLE
DYIRSNTGLVIDPYFSGTKVKWILDHVEGSRERARRGELLFGTVDTWLIWKMTQGRVHVTD
YTNASRTMLFNIHTLDWDDKMLEVLDIPREMLPEVRRSSEVYGQTNIGGKGGTRIPISGIA
...
```

**Explicación:** `head -10` muestra las primeras 10 líneas del archivo sin abrirlo completo — útil cuando el archivo tiene miles de proteínas. Cada proteína en formato FASTA tiene una estructura fija de dos partes:
- **Header (`>`):** contiene el ID de UniProt, el código del gen, el nombre completo de la proteína y el organismo de origen.
- **Secuencia:** las líneas siguientes contienen los aminoácidos en código de una letra (A, M, K, T...) hasta que aparece el siguiente `>`.

---

### COMANDO 2 — Contar el número total de proteínas

```bash
grep -c "^>" ecoli_proteome.fasta
```

**Salida esperada:**
```
4531
```

**Explicación:** `grep` busca patrones dentro de un archivo línea por línea. `^>` es una **expresión regular** donde `^` (caret) significa "inicio de línea" y `>` es el carácter que empieza todo header FASTA. Combinados, `^>` selecciona únicamente las líneas que empiezan con `>`, es decir, exactamente una por proteína. El flag `-c` **cuenta** cuántas hay. **4,531 proteínas contadas en menos de 1 segundo.**

---

### COMANDO 3 — Buscar TODAS las proteínas ribosomales

```bash
grep -c "ribosomal" ecoli_proteome.fasta
```

**Salida esperada:**
```
~70
```

**Explicación:** `grep -c "ribosomal"` recorre todas las líneas del archivo buscando la palabra `ribosomal` y cuenta cuántas líneas la contienen. Como solo los headers FASTA contienen palabras anotadas (las líneas de secuencia solo tienen letras de aminoácidos), esto cuenta efectivamente cuántas proteínas están anotadas como ribosomales. Sin el flag `-c`, `grep "ribosomal"` imprimiría todos los headers encontrados. **Análisis funcional en miles de proteínas en menos de 1 segundo.**

---

### COMANDO 4 — Buscar genes específicos por nombre

```bash
grep ">" ecoli_proteome.fasta | grep -i "DNA polymerase"
```

**Salida esperada:**
```
>sp|P00582|DPO1_ECOLI DNA polymerase I OS=Escherichia coli (strain K12) OX=83333 GN=polA PE=1 SV=1
>sp|P03007|DPO3E_ECOLI DNA polymerase III subunit epsilon OS=Escherichia coli (strain K12) OX=83333 GN=dnaQ PE=1 SV=1
>sp|P06710|DPO3X_ECOLI DNA polymerase III subunit tau OS=Escherichia coli (strain K12) OX=83333 GN=dnaX PE=1 SV=1
>sp|P0ABS8|HOLE_ECOLI DNA polymerase III subunit theta OS=Escherichia coli (strain K12) OX=83333 GN=holE PE=1 SV=1
>sp|P10443|DPO3A_ECOLI DNA polymerase III subunit alpha OS=Escherichia coli (strain K12) OX=83333 GN=dnaE PE=1 SV=1
>sp|P28630|HOLA_ECOLI DNA polymerase III subunit delta OS=Escherichia coli (strain K12) OX=83333 GN=holA PE=1 SV=1
>sp|P28631|HOLB_ECOLI DNA polymerase III subunit delta' OS=Escherichia coli (strain K12) OX=83333 GN=holB PE=1 SV=2
>sp|P28632|HOLD_ECOLI DNA polymerase III subunit psi OS=Escherichia coli (strain K12) OX=83333 GN=holD PE=1 SV=1
>sp|P28905|HOLC_ECOLI DNA polymerase III subunit chi OS=Escherichia coli (strain K12) OX=83333 GN=holC PE=1 SV=1
>sp|Q47155|DPO4_ECOLI DNA polymerase IV OS=Escherichia coli (strain K12) OX=83333 GN=dinB PE=1 SV=1
>sp|P21189|DPO2_ECOLI DNA polymerase II OS=Escherichia coli (strain K12) OX=83333 GN=polB PE=1 SV=2
```

**Explicación:** Este comando usa **dos `grep` encadenados con pipe `|`**:
- **Primer `grep ">"`:** busca/filtra solo las líneas que contienen `>`, es decir, únicamente los headers — descartando todas las líneas de secuencia.
- **Pipe `|`:** envía esos headers al segundo `grep`.
- **Segundo `grep -i "DNA polymerase"`:** busca el término dentro de los headers. El flag `-i` ignora mayúsculas y minúsculas (*case insensitive*), por lo que encontraría tanto `DNA polymerase` como `dna polymerase` o `Dna Polymerase`.

> Este patrón de encadenar `grep` es fundamental en bioinformática para filtrar bases de datos proteómicas o genómicas por función, nombre o familia.

---

### COMANDO 5 — Extraer la secuencia COMPLETA de UNA proteína específica

```bash
# Ver en pantalla
awk '/^>/{p=0} /DPO1_ECOLI/{p=1} p' ecoli_proteome.fasta | head -10

# Guardar en archivo
awk '/^>/{p=0} /DPO1_ECOLI/{p=1} p' ecoli_proteome.fasta > DPO1_ECOLI_protein.fasta
```

**Salida esperada:**
```
>sp|P00582|DPO1_ECOLI DNA polymerase I OS=Escherichia coli (strain K12) OX=83333 GN=polA PE=1 SV=1
MVQIPQNPLILVDGSSYLYRAYHAFPPLTNSAGEPTGAMYGVLNMLRSLIMQYKPTHAAV
VFDAKGKTFRDELFEHYKSHRPPMPDDLRAQIEPLHAMVKAMGLPLLAVSGVEADDVIGT
LAREAEKAGRPVLISTGDKDMAQLVTPNITLINTMTNTILGPEEVVNKYGVPPELIIDFL
ALMGDSSDNIPGVPGVGEKTAQALLQGLGGLDTLYAEPEKIAGLSFRGAKTMAAKLEQNK
EVAYLSYQLATIKTDVELELTCEQLEVQQPAAEELLGLFKKYEFKRWTADVEAGKWLQAK
GAKPAAKPQETSVADEAPEVTATVISYDNYVTILDEETLKAWIAKLEKAPVFAFDTETDS
LDNISANLVGLSFAIEPGVAAYIPVAHDYLDAPDQISRERALELLKPLLEDEKALKVGQN
LKYDRGILANYGIELRGIAFDTMLESYILNSVAGRHDMDSLAERWLKHKTITFEEIAGKG
KNQLTFNQIALEEAGRYAAEDADVTLQLHLKMWPDLQKHKGPLNVFENIEMPLVPVLSRI
```
**Explicación:** `awk` procesa el archivo línea por línea usando una variable `p` como **interruptor (flag)** que puede estar apagado (`p=0`) o encendido (`p=1`). En cada línea hace tres preguntas en orden:

- `/^>/` — ¿esta línea empieza con `>`? Si sí, **apaga** el flag (`p=0`): significa que llegamos a una proteína que no nos interesa, deja de imprimir.
- `/DPO1_ECOLI/` — ¿esta línea contiene `DPO1_ECOLI`? Si sí, **enciende** el flag (`p=1`): encontramos la proteína buscada, empieza a imprimir.
- `p` — ¿el flag está encendido? Si sí, **imprime** la línea actual.

De esta forma extrae el header y toda la secuencia de aminoácidos hasta encontrar el siguiente `>`, momento en que el flag se apaga automáticamente. Es como buscar un capítulo en un libro: ignoras todo hasta encontrar el título que buscas, lees hasta el siguiente título, y paras.

- El símbolo `>` redirige la salida a un archivo nuevo (`DPO1_ECOLI_protein.fasta`) listo para usar en análisis posteriores como alineamientos, docking molecular o diseño de primers.

---

### COMANDO 6 — Extraer UN GRUPO de proteínas

```bash
# Extraer todas las polimerasas
awk '/^>/{p=0} /DNA polymerase/{p=1} p' ecoli_proteome.fasta > polimerasas.fasta

# Verificar cuántas se extrajeron
grep -c "^>" polimerasas.fasta
```

**Salida esperada:**
```
5
```

**Explicación:** Funciona con la misma lógica de flag que el Comando 5, pero en lugar de buscar un ID exacto busca el término `DNA polymerase` — capturando **todas** las proteínas que lo contengan en su header. El resultado se redirige con `>` a un archivo nuevo `polimerasas.fasta`. Luego `grep -c "^>"` verifica cuántas proteínas fueron extraídas contando los headers del archivo resultante.

**Útil para:** filtrar por familias funcionales, agrupar proteínas relacionadas, preparar subconjuntos de datos para análisis posteriores como alineamiento múltiple (MUSCLE, MAFFT) o construcción de árboles filogenéticos.

---

## ¿Quieres aprender los fundamentos completos?

Inscríbete al curso oficial:

### Fundamentos de Linux y Bash Scripting para Bioinformática

| Característica | Detalle |
|----------------|---------|
| **Inicio** | 13 de junio de 2026 |
| **Cierre** | 4 de julio de 2026 |
| **Duración** | 11 horas lectivas en 4 semanas |
| **Modalidad** | Virtual híbrida (7 h asincrónicas + 4 h sincrónicas) |
| **Idioma** | Español |
| **Nivel** | Introductorio (sin prerrequisitos) |
| **Certificación** | Digital del CEM |

### Estructura del curso (5 módulos)

- **M0** — Bienvenida y preparación del flujo de trabajo (1 h)
- **M1** — Fundamentos de Linux, la terminal y el sistema de archivos (2.5 h)
- **M2** — Procesamiento de datos biológicos en texto (2.5 h)
- **M3** — Bash scripting introductorio: de comandos a programas (2.5 h)
- **M4** — Aplicación: control de calidad de FASTQ con FastQC (2.5 h)

### ¿Por qué este curso?

- **100% en español** con datasets bioinformáticos reales
- **Cohorte pequeña** con seguimiento personalizado del docente
- **Datos reales** descargados de NCBI, Ensembl, UniProt y SRA/ENA
- **Bitácora personal en GitHub** — construirás tu propia guía de referencia futura
- **Diseño introductorio honesto** — 2-3 h por semana, sin sobrecargas

---

## Contacto e inscripción

- **Inscripción al curso:** escanea el QR del flyer del CEM o escribe a 📧 cursoscemcontacto@gmail.com

---

## Licencia

Este repositorio se distribuye con fines educativos. Los comandos y ejemplos pueden reutilizarse libremente. Los datos provienen de fuentes públicas (Data Carpentry, UniProt) con sus respectivas licencias.

---

> 🧬 *"La bioinformática empieza con una sola línea de comando."*

**Centro de Especialización Multidisciplinario (CEM)** · Programa de Bioinformática Aplicada · Mayo 2026
