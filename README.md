# Fundamentos de Linux y Bash Scripting para Bioinformática · CEM-BIO-101

> Repositorio oficial del curso del **Centro de Especialización Multidisciplinario (CEM)**.
> Aquí viven los **datos, recursos y guías de descarga** que usarás a lo largo del curso.

**Docente:** Mg(c). César Bryan Reyes Moreno · [UNMSM](https://www.unmsm.edu.pe/)
**ORCID:** [0000-0001-7346-2917](https://orcid.org/0000-0001-7346-2917)
**Contacto:** cursoscemcontacto@gmail.com

---

## 🚀 Empieza aquí

1. Ten tu entorno listo (WSL2 en Windows, o terminal nativa en macOS/Linux). Ver Módulo 0.
2. Descarga el paquete de datos de cada módulo siguiendo las guías de abajo.
3. Documenta lo que haces en **tu propia bitácora** en GitHub (ver [`plantillas_estudiante/`](plantillas_estudiante/)).

> **Atajo:** puedes bajar los datos de M0 y M1 de una sola vez con el script [`scripts/descargar_datos.sh`](scripts/descargar_datos.sh).

---

## 📦 Datos del curso

Todos los datos provienen de bases públicas (NCBI, Ensembl/GENCODE, UniProt, SRA/ENA) y están documentados en [`datos/README.md`](datos/README.md).

| Módulo | Dato | Fuente | Guía |
|---|---|---|---|
| **M0** | Paquete del curso: lecturas FASTQ de *E. coli* (LTEE) | GitHub Release · SRA | [M0_preparacion/](M0_preparacion/README.md) |
| **M1** | Genoma de referencia *E. coli* K-12 MG1655 | NCBI RefSeq | [M1_fundamentos/](M1_fundamentos/README.md) |
| M2 | Anotación GENCODE + proteoma *E. coli* | Ensembl · UniProt | *(próximamente)* |
| M4 | Lecturas FASTQ crudas para FastQC | SRA / ENA | *(próximamente)* |

---

## 🗂️ Estructura de este repositorio

```
Curso_linux_bash/
├── README.md                 ← este archivo (portal del curso)
├── datos/                    ← catálogo de datos y su procedencia
├── M0_preparacion/           ← guía de descarga del M0 (bitácora)
├── M1_fundamentos/           ← guía de descarga del M1 (bitácora)
├── scripts/                  ← scripts de apoyo (descarga automatizada)
└── plantillas_estudiante/    ← plantillas para TU bitácora personal
```

---

## 📁 ¿Dónde se guardan los datos en tu computadora?

Los datos **no viven en este repositorio** (son pesados). Tú los descargas a tu carpeta de trabajo local, con esta estructura recomendada (Noble, 2009):

```
~/Cursos_bioinformatica/curso_linux_bash/
├── data/        ← datos crudos descargados
├── results/     ← resultados de tus análisis
├── scripts/     ← tus scripts .sh
└── doc/         ← notas y documentación
```

---

## 📝 Tu bitácora (obligatoria como guía de referencia)

Cada estudiante mantiene un **repositorio de bitácora** propio en GitHub, escrito en Markdown. Documenta *qué comando usaste, qué hace, qué te costó y qué pregunta te queda*. Usa las plantillas de [`plantillas_estudiante/`](plantillas_estudiante/) para empezar.

---

## 📚 Bibliografía base

- Perkel, J. M. (2021). *Five reasons why researchers should learn to love the command line.* Nature.
- Brandies & Hogg (2021). *Ten simple rules for getting started with command-line bioinformatics.* PLoS Comp Biol.
- Noble, W. S. (2009). *A quick guide to organizing computational biology projects.* PLoS Comp Biol.

---

*El material del webinar de mayo 2026 (demo introductorio) se conserva en la carpeta [`webinar/`](webinar/) para referencia.*
