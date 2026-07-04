#!/usr/bin/env bash
# =============================================================================
# descargar_datos.sh
# Descarga los datos de los Módulos 0 y 1 del curso CEM-BIO-101 y arma la
# estructura de trabajo recomendada (Noble, 2009).
#
# Uso:
#   bash descargar_datos.sh
#
# Autor: Mg(c). César Bryan Reyes Moreno · CEM
# =============================================================================

set -euo pipefail   # -e: corta si algo falla · -u: error si variable no definida · -o pipefail

# ---- Configuración -----------------------------------------------------------
BASE="$HOME/Cursos_bioinformatica/curso_linux_bash"
URL_M0="https://github.com/cesarbryanreyes/Curso_linux_bash/releases/download/v1.0/sub.tar"
URL_M1="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz"

echo ">> Creando estructura de trabajo en: $BASE"
mkdir -p "$BASE/data/raw_reads" "$BASE/data/reference" "$BASE/results" "$BASE/scripts" "$BASE/doc"

# ---- M0: paquete de lecturas FASTQ ------------------------------------------
echo ">> [M0] Descargando paquete de datos del curso..."
cd "$BASE/data/raw_reads"
if [ ! -f "SRR2589044_1.trim.sub.fastq" ]; then
    wget -c "$URL_M0"
    tar -xvf sub.tar
else
    echo "   Ya existe SRR2589044_1.trim.sub.fastq, se omite."
fi

# ---- M1: genoma de referencia -----------------------------------------------
echo ">> [M1] Descargando genoma de referencia de E. coli K-12 MG1655..."
cd "$BASE/data/reference"
if [ ! -f "GCF_000005845.2_ASM584v2_genomic.fna" ]; then
    wget -c "$URL_M1"
    gunzip -f GCF_000005845.2_ASM584v2_genomic.fna.gz
else
    echo "   Ya existe el genoma, se omite."
fi

# ---- Verificación ------------------------------------------------------------
echo ""
echo ">> Verificación:"
echo "   Lecturas FASTQ (M0):"
ls -lh "$BASE/data/raw_reads/SRR2589044_1.trim.sub.fastq"
echo "   Genoma de referencia (M1):"
ls -lh "$BASE/data/reference/GCF_000005845.2_ASM584v2_genomic.fna"

echo ""
echo ">> Listo. Datos de M0 y M1 descargados y organizados."
