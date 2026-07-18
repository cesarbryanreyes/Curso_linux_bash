# M1 · Fundamentos de Linux

> **CEM-BIO-101** · Módulo 1
> Requisitos previos: ninguno — nivel 0.

Este módulo cubre los fundamentos del sistema operativo Linux y el manejo básico de archivos desde la terminal, usando como caso aplicado la descarga, organización y manipulación del genoma de referencia de *Escherichia coli* K-12 MG1655 desde NCBI.

Formato de bitácora en todos los temas: **comando → salida esperada → explicación**.

---

## Temas del módulo

| Tema | Título | Duración | Archivo | Estado |
|------|--------|----------|---------|--------|
| 1.1 | Fundamentos del Sistema Operativo Linux | 12 min | [M1_T1_Fundamentos_Linux.md](M1_T1_Fundamentos_Linux.md) | ✅ Disponible |
| 1.2 | La Terminal, Shell y Bash | 15 min | [M1_T2_Terminal_Shell_Bash.md](M1_T2_Terminal_Shell_Bash.md) | ✅ Disponible |
| 1.3 | Navegación del Sistema de Archivos | 20 min | [M1_T3_Navegacion_Sistema_Archivos.md](M1_T3_Navegacion_Sistema_Archivos.md) | ✅ Disponible |
| 1.4 | Creación, Copia, Movimiento y Eliminación de Archivos | 15 min | [M1_T4_Manipulacion_Archivos.md](M1_T4_Manipulacion_Archivos.md) | ✅ Disponible |
| 1.5 | Permisos de Ejecución para tus Propios Scripts | 21 min | [M1_T5_Permisos_Ejecucion.md](M1_T5_Permisos_Ejecucion.md) | ✅ Disponible |
| 1.6 | Flujos Estándar, Redirecciones y Pipes | 18 min | [M1_T16_GitHub_README.md](M1_T16_GitHub_README.md) | ✅ Disponible |

*Duración de 1.6 estimada por volumen de contenido — pendiente que confirmes el tiempo real de grabación.

**Duración asincrónica total del módulo:** ≈ 101 minutos (~1h 41min núcleo de contenido).

---

## Hilo conductor del módulo

Cada tema construye sobre el anterior, usando siempre el mismo organismo modelo:

```
1.1 Identidad y $PATH  →  1.2 Sintaxis y ayuda  →  1.3 Navegar + descargar genoma
        →  1.4 Copiar/mover/eliminar sin alterar el original  →  1.5 Ejecutar tu propio script
        →  1.6 Redirecciones y pipes (cierra el módulo)
```

El genoma de *E. coli* K-12 MG1655 (`GCF_000005845.2`, `NC_000913.3`, 4,641,652 bp) se descarga en el Tema 1.3 y se usa como archivo de trabajo en los Temas 1.4, 1.5 y 1.6. En el Tema 1.6 se explica finalmente la pipe de 3 comandos (`grep -v ">" | tr -d '\n' | wc -c`) que calculó la longitud del genoma en el Tema 1.3.

---

## Tu bitácora

Cada tema tiene su propia sección de preguntas guía al final del archivo correspondiente. Las plantillas de bitácora completas están en `plantillas_estudiante/`:

| Tema | Plantilla de bitácora |
|------|------------------------|
| 1.1 | `plantillas_estudiante/bitacora_T11.md` |
| 1.2 | `plantillas_estudiante/bitacora_T12.md` |
| 1.3 | `plantillas_estudiante/bitacora_T13.md` |
| 1.4 | `plantillas_estudiante/bitacora_T14.md` |
| 1.5 | `plantillas_estudiante/bitacora_T15.md` |
| 1.6 | `plantillas_estudiante/bitacora_T16.md` |

Documenta tu aprendizaje siguiendo el patrón: qué comando usé, qué hace, qué me costó, qué pregunta me queda.

---

## Referencias del módulo

- Noble, W. S. (2009). A quick guide to organizing computational biology projects. *PLoS Computational Biology*, 5(7), e1000424.
- Brandies, P. A., & Hogg, C. J. (2021). Ten simple rules for getting started with command-line bioinformatics. *PLoS Computational Biology*, 17(6), e1009256.
- Perkel, J. M. (2021). Five reasons why researchers should learn to love the command line. *Nature*, 590(7844), 173–174.
- NCBI RefSeq: [GCF_000005845.2](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000005845.2/)

---

*CEM-BIO-101 · Centro de Especialización Multidisciplinario · 2026*
