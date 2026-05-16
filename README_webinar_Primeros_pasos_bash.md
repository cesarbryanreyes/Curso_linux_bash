# 🧬 Webinar CEM-BIO-101: Primeros pasos en bioinformática con Linux y Bash

> Repositorio público de referencia del webinar gratuito del **sábado 16 de mayo de 2026** organizado por el **Centro de Especialización Multidisciplinario (CEM)**.

📅 **Fecha del webinar:** sábado 16 de mayo de 2026 · 5:00 PM (hora de Lima)
🖥️ **Plataforma:** Microsoft Teams
⏱️ **Duración:** 40 minutos
👨‍🏫 **Docente:** Mg(c). César Bryan Reyes Moreno · [UNMSM](https://www.unmsm.edu.pe/)
🔗 **ORCID:** [0000-0001-7346-2917](https://orcid.org/0000-0001-7346-2917)

---

## 📌 ¿Qué encontrarás aquí?

Este repositorio contiene los **10 comandos completos** del demo en vivo del webinar, listos para que los repliques en tu propia computadora. Incluye instrucciones de instalación, descarga de datos y los comandos paso a paso.

> 💡 **Importante:** este repositorio NO es un curso. Es una guía de referencia rápida del demo del webinar. Si quieres aprender los fundamentos desde cero, inscríbete al curso completo **CEM-BIO-101** (inicio: 13 de junio de 2026).

---

## 🚀 ¿Por qué Linux y Bash?

Hoy, casi cualquier laboratorio de investigación, hospital o empresa biotecnológica trabaja con datos que ya no funcionan adecuadamente en Excel: archivos de secuenciación genómica de cientos de megabytes o gigabytes, resultados de microscopía cuantitativa o registros clínicos masivos. **Esos datos se procesan en Linux, desde la terminal.**

Aprender Linux y Bash te convierte en un **profesional autónomo** que puede analizar sus propios datos sin depender siempre del bioinformático del equipo.

---

## 🛠️ Antes de empezar: requisitos técnicos

### Sistema operativo
- **Windows 10/11:** instalar [WSL2 con Ubuntu](https://learn.microsoft.com/es-es/windows/wsl/install)
- **macOS:** usar la terminal nativa (Terminal.app) o iTerm2
- **Linux:** usar tu terminal habitual

### Herramientas necesarias
- `zcat`, `wc`, `awk`, `grep`, `head`, `cat`, `echo` (preinstaladas en Linux/macOS)
- `wget` para descargar archivos (en macOS: `brew install wget`)

---

## 📦 CASO I: Datos crudos de secuenciación (FASTQ)

### Descarga del archivo

```bash
mkdir -p ~/webinar_demo/data/raw_reads
cd ~/webinar_demo/data/raw_reads
wget https://ndownloader.figshare.com/files/14418248 -O sub.tar.gz
tar -xvzf sub.tar.gz
ls -lh
```

**Resultado esperado:** archivo `sub_SRR2589044_1.fastq.gz` de ~109 MB.

**Origen:** Experimento de Richard Lenski sobre evolución a largo plazo de *Escherichia coli*. Datos descargados desde una base de datos pública de secuenciación.

---

### COMANDO 1 — Ver dentro del archivo comprimido

```bash
zcat sub_SRR2589044_1.fastq.gz | head -8
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

**Explicación:** `zcat` lee archivos comprimidos al vuelo (sin descomprimirlos). `head -8` toma solo las primeras 8 líneas. El símbolo `|` (pipe) conecta los dos comandos como una tubería. Cada lectura FASTQ ocupa **4 líneas**: identificador, secuencia, separador (`+`) y calidades.

---

### COMANDO 2 — Contar lecturas (⭐ CLÍMAX 1)

```bash
echo "Total: $(($(zcat sub_SRR2589044_1.fastq.gz | wc -l) / 4))"
```

**Salida esperada:**

```
Total: 1108029
```

**Explicación:** `wc -l` cuenta el número total de líneas. Dividir entre 4 da el número de lecturas (porque cada lectura ocupa 4 líneas). `$(( ... ))` hace la operación matemática en Bash. **Un millón ciento ocho mil veintinueve secuencias en menos de 5 segundos.**

---

### COMANDO 3 — Largo promedio de las lecturas (🟡 OPCIONAL)

```bash
zcat sub_SRR2589044_1.fastq.gz | awk 'NR%4==2 {sum+=length($0); n++} END {print "Largo promedio:", sum/n, "bp"}'
```

**Salida esperada:**

```
Largo promedio: 150 bp
```

**Explicación:** `awk 'NR%4==2'` toma solo las líneas de secuencia (cada cuarta línea empezando desde la 2). `length($0)` calcula el largo de cada secuencia. Acumula la suma y divide entre el total al final.

---

### COMANDO 4 — Detectar contaminación de adaptador Illumina (⭐ CLÍMAX 2)

```bash
zcat sub_SRR2589044_1.fastq.gz | awk 'NR%4==2' | grep -c "AGATCGGAAGAG"
```

**Salida esperada:**

```
~180000
```

**Explicación:** `AGATCGGAAGAG` es la secuencia de inicio del adaptador estándar de Illumina. `grep -c` cuenta cuántas lecturas la contienen. Esto detecta contaminación de adaptador que necesita ser removida antes del análisis (~16% de las lecturas en este caso).

**Esto es exactamente lo que detecta FastQC**, la herramienta que aprenderás a usar en el Módulo 4 del curso CEM-BIO-101.

---

### COMANDO 5 — Generar mini-reporte de QC

```bash
echo "REPORTE DE QC RÁPIDO" > resumen.txt
echo "Total lecturas: $(($(zcat sub_SRR2589044_1.fastq.gz | wc -l) / 4))" >> resumen.txt
echo "Adaptador presente: $(zcat sub_SRR2589044_1.fastq.gz | awk 'NR%4==2' | grep -c 'AGATCGGAAGAG')" >> resumen.txt
cat resumen.txt
```

**Salida esperada:**

```
REPORTE DE QC RÁPIDO
Total lecturas: 1108029
Adaptador presente: ~180000
```

**Explicación:** El símbolo `>` redirige la salida a un archivo (sobrescribiendo). `>>` añade al final del archivo (sin sobrescribir). `cat` muestra el contenido del archivo. **Esto es lo que el Módulo 4 del curso enseña a automatizar con FastQC.**

---

## 📦 CASO II: Proteoma anotado (MULTIFASTA)

### Descarga del archivo

```bash
mkdir -p ~/webinar_demo/data/proteome
cd ~/webinar_demo/data/proteome
wget -O ecoli_proteome.fasta.gz "https://rest.uniprot.org/uniprotkb/stream?query=organism_id:83333+AND+reviewed:true&format=fasta&compressed=true"
gunzip ecoli_proteome.fasta.gz
ls -lh ecoli_proteome.fasta
```

**Resultado esperado:** archivo `ecoli_proteome.fasta` de ~5 MB con aproximadamente 4,400 proteínas anotadas de *E. coli* K-12.

**Origen:** Proteoma de referencia de *Escherichia coli* descargado de UniProt.

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

**Explicación:** Cada proteína FASTA empieza con `>` seguido del **header anotado**: ID de UniProt, nombre del gen, nombre completo de la proteína y organismo. Las siguientes líneas son la secuencia de aminoácidos.

---

### COMANDO 2 — Contar el número total de proteínas

```bash
grep -c "^>" ecoli_proteome.fasta
```

**Salida esperada:**

```
4391
```

**Explicación:** `^>` es una expresión regular que significa "líneas que empiezan con `>`". Como cada proteína FASTA empieza con `>`, contar esas líneas equivale a contar proteínas. **4,391 proteínas anotadas en menos de 1 segundo.**

---

### COMANDO 3 — Buscar TODAS las proteínas ribosomales (⭐ CLÍMAX 1)

```bash
grep -c "ribosomal" ecoli_proteome.fasta
```

**Salida esperada:**

```
~70
```

**Explicación:** `grep -c` cuenta cuántas líneas contienen la palabra "ribosomal". Como solo los headers contienen palabras anotadas, esto cuenta las proteínas anotadas como ribosomales. **Análisis funcional en miles de proteínas en menos de 1 segundo.**

---

### COMANDO 4 — Buscar genes específicos por nombre (🟡 OPCIONAL)

```bash
grep ">" ecoli_proteome.fasta | grep -i "DNA polymerase"
```

**Salida esperada:**

```
>sp|P00582|DPO1_ECOLI DNA polymerase I OS=Escherichia coli (strain K12)...
>sp|P00580|DPO3A_ECOLI DNA polymerase III subunit alpha OS=Escherichia coli...
>sp|P03007|DPO3E_ECOLI DNA polymerase III subunit epsilon OS=Escherichia coli...
>sp|P06710|DPO3X_ECOLI DNA polymerase III subunit tau OS=Escherichia coli...
>sp|P10443|DPO3B_ECOLI DNA polymerase III subunit beta OS=Escherichia coli...
...
```

**Explicación:** Primer `grep ">"` filtra solo los headers (líneas que contienen `>`). Segundo `grep -i "DNA polymerase"` busca el término sin distinguir mayúsculas/minúsculas. Útil para identificar genes de interés en bases de datos.

---

### COMANDO 5 — Extraer la secuencia COMPLETA de UNA proteína específica (⭐ CLÍMAX FINAL)

```bash
awk '/^>/{p=0} /DPO1_ECOLI/{p=1} p' ecoli_proteome.fasta | head -10
```

**Salida esperada:**

```
>sp|P00582|DPO1_ECOLI DNA polymerase I OS=Escherichia coli (strain K12)...
MVQIPQNPLILVDGSSYLYRAYHAFPPLTNSAGEPTGAMYGVLNMLRSLIMQYKPTHAACV
FDAKGKTFRDELFEHYKSHRPPMPDDLRAQIEPLHAMVKAMGLPLLAVSGVEADDVIGTLA
REAEKAGRPVLISTGDKDMAQLVTPNITLINTMTNTILGPEEVVNKYGVPPELIIDFLALM
GDSSDNIPGVPGVGEKTAQALLQGLGGLDTLYAEPEKIAGLSFRGAKTMAAKLEQNKEVAY
LSYQLATIKTDVELELTCEQLEVQQPAAEELLGLFKKYEFKRWTADVEAGKWLQAKGAKPA
...
```

**Explicación:** El comando `awk` usa una variable `p` (flag) que activa la impresión solo cuando encuentra el patrón deseado. Cuando llega a un nuevo header (`/^>/`), apaga el flag (`p=0`). Cuando encuentra el header de la proteína buscada (`DPO1_ECOLI`), lo enciende (`p=1`). Mientras el flag esté encendido, imprime las líneas.

**Aplicaciones reales:** análisis de homología, diseño de primers, punto de partida para experimentos.

---

### COMANDO 6 (BONUS) — Extraer UN GRUPO de proteínas

```bash
awk '/^>/{flag=0} /DNA polymerase/{flag=1} flag' ecoli_proteome.fasta > polimerasas.fasta
grep -c "^>" polimerasas.fasta
```

**Salida esperada:**

```
5
```

**Explicación:** Funciona igual que el Comando 5, pero captura **todas** las proteínas que contengan "DNA polymerase" en su header (no solo una). El símbolo `>` redirige el resultado a un archivo nuevo (`polimerasas.fasta`). Luego se cuenta cuántas se extrajeron.

**Útil para:** filtrar por familias funcionales, agrupar proteínas relacionadas, preparar datasets para análisis posteriores.

---

## 🎓 ¿Quieres aprender los fundamentos completos?

Inscríbete al curso oficial:

### CEM-BIO-101 — Fundamentos de Linux y Bash Scripting para Bioinformática

| Característica | Detalle |
|----------------|---------|
| 📅 **Inicio** | 13 de junio de 2026 |
| 📅 **Cierre** | 4 de julio de 2026 |
| ⏱️ **Duración** | 11 horas lectivas en 4 semanas |
| 🌐 **Modalidad** | Virtual híbrida (7 h asincrónicas + 4 h sincrónicas) |
| 🗣️ **Idioma** | Español |
| 🎓 **Nivel** | Introductorio (sin prerrequisitos) |
| 📜 **Certificación** | Digital del CEM al aprobar con nota ≥ 13/20 |

### Estructura del curso (5 módulos)

- **M0** — Bienvenida y preparación del flujo de trabajo (1 h)
- **M1** — Fundamentos de Linux, la terminal y el sistema de archivos (2.5 h)
- **M2** — Procesamiento de datos biológicos en texto (2.5 h) ← *donde profundizarás en lo que viste hoy*
- **M3** — Bash scripting introductorio: de comandos a programas (2.5 h)
- **M4** — Aplicación: control de calidad de FASTQ con FastQC (2.5 h) ← *automatización del CASO I*

### ¿Por qué este curso?

- 🎯 **100% en español** con datasets bioinformáticos reales
- 👥 **Cohorte pequeña** con seguimiento personalizado del docente
- 💻 **Datos reales** descargados de NCBI, Ensembl, UniProt y SRA/ENA
- 📚 **Bitácora personal en GitHub** — construirás tu propia guía de referencia futura
- 🚀 **Diseño introductorio honesto** — 2-3 h por semana, sin sobrecargas

---

## 📞 Contacto e inscripción

- **Inscripción al curso:** escanea el QR del flyer del CEM o escribe a 📧 cursoscemcontacto@gmail.com
- **Docente:** cesar.reyes11@unmsm.edu.pe
- **ORCID del docente:** [0000-0001-7346-2917](https://orcid.org/0000-0001-7346-2917)

---

## 📜 Créditos y referencias

### Datos utilizados

- **FASTQ (CASO I):** subset de `SRR2589044` del experimento de evolución a largo plazo de *E. coli* de Richard Lenski. Distribuido por [Data Carpentry — Wrangling Genomics](https://datacarpentry.org/wrangling-genomics/).
- **Multifasta (CASO II):** Proteoma de referencia de *Escherichia coli* K-12, descargado de [UniProt](https://www.uniprot.org/).

### Material adaptado

El curso CEM-BIO-101 está adaptado a partir del material del **Máster en Bioinformática de la Universidad Internacional de Valencia (VIU, España)**.

### Lecturas recomendadas

- Perkel, J. M. (2021). [Five reasons why researchers should learn to love the command line](https://www.nature.com/articles/d41586-021-00263-0). *Nature*, 590(7844), 173–174.
- Brandies, P. A., & Hogg, C. J. (2021). [Ten simple rules for getting started with command-line bioinformatics](https://doi.org/10.1371/journal.pcbi.1008645). *PLoS Computational Biology*, 17(2), e1008645.
- Noble, W. S. (2009). [A quick guide to organizing computational biology projects](https://doi.org/10.1371/journal.pcbi.1000424). *PLoS Computational Biology*, 5(7), e1000424.

---

## 📝 Licencia

Este repositorio se distribuye con fines educativos. Los comandos y ejemplos pueden reutilizarse libremente. Los datos provienen de fuentes públicas (Data Carpentry, UniProt) con sus respectivas licencias.

---

> 🧬 *"La bioinformática empieza con una sola línea de comando."*

**Centro de Especialización Multidisciplinario (CEM)** · Programa de Bioinformática Aplicada · Mayo 2026
