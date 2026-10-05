# Regresión Lineal Simple — Econometría I

*Universidad del Quindío*  
*Programa de Economía*  

* *Estudiantes:* Diana Marcela Chilama, Kristian Camilo Ducuara Molina 

---

## Descripción del Proyecto
Este repositorio contiene la estimación y réplica de un modelo de *Regresión Lineal Simple* realizado en RStudio para la materia Econometría I. 

El análisis evalúa la relación entre la variable independiente ($X$) y la variable dependiente ($Y$).

## Contenido del Código
El script Regresionlineal (1).R
1. Carga y exploración de la base de datos.
2. Estimación del modelo econométrico mediante la función lm() y summary().
3. Cálculo manual de los parámetros $\beta_0$ y $\beta_1$.
4. Matriz de desviaciones, residuos ($e_i$) y varianzas.
5. Construcción manual de la *Tabla ANOVA* (SCT, SCR, SCE, estadístico F y p-valor).
---
## Interpretación Econométrica

* *Intercepto ($\beta_0 = 5$):* Es el valor estimado de la Tasa de Ahorro ($Y$) cuando la Tasa de Interés ($X$) es cero.
* *Pendiente ($\beta_1 = 2.308$):* Por cada aumento de 1 unidad (o punto porcentual) en la Tasa de Interés, la Tasa de Ahorro se incrementa en promedio 2.308 unidades.
* *Coeficiente de Determinación ($R^2 = 0.985$):* El 98.5% de la variabilidad en la Tasa de Ahorro es explicada por la Tasa de Interés a través del modelo.

---
Desarrollado en RStudio con control de versiones en Git y GitHub.
