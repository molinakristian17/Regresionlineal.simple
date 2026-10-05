###################################################################
######                                                       ######
#                      UNIVERSIDAD DEL QUINDÍO                    #
#                       PROGRAMA DE ECONOMIA                      #
#                            ECONOMETRÍA I                        #
######                                                       ######
###################################################################

# MEMBERS: DIANA MARCELA CHILAMA,KRISTIAN CAMILO DUCUARA MOLINA

## REGRESIÓN LINEAL SIMPLE ----
# https://microdatos.dane.gov.co/index.php/catalog/853

getwd()
options('scipen' = 100 , 'digits' = 4)
rm(list = ls())

# Paquetes o librerias ----
library("skimr")
library("readxl")
library("stringr")
library("stringi")
library("haven")
library("tidyverse")
library("plyr")
library("rstatix")
library("descr")
library("splitstackshape")
library("e1071")


  # ============================================================
  # REGRESIÓN LINEAL SIMPLE: Tasa de ahorro (Y) vs Tasa de interés (X)
  # Réplica en R del ejercicio de Excel (hoja REGRESION_SIMPLE)
  # ============================================================
# ==============================================================================
# ACTIVIDAD 2 - ECONOMETRÍA I
# ==============================================================================

# 1. CARGA DE DATOS 
DATOS <- data.frame(
  x = c(10, 12, 15, 18, 20, 22, 25, 28, 30, 32),
  y = c(25, 30, 38, 42, 48, 55, 60, 68, 72, 78)
)

# 2. ESTIMACIÓN  MEDIANTE lm() Y summary()
modelo <- lm(y ~ x, data = DATOS)
summary(modelo)

# 3. PROMEDIOS Y TAMAÑO DE MUESTRA
n <- nrow(DATOS)
mean_x <- mean(DATOS$x)
mean_y <- mean(DATOS$y)

# 4. CONSTRUCCIÓNL COLUMNA POR COLUMNA
DATOS$x_dev <- DATOS$x - mean_x                    # (X_i - X_bar)
DATOS$y_dev <- DATOS$y - mean_y                    # (Y_i - Y_bar)
DATOS$xy_dev <- DATOS$x_dev * DATOS$y_dev          # (X_i - X_bar)*(Y_i - Y_bar)
DATOS$x_dev_sq <- DATOS$x_dev^2                    # (X_i - X_bar)^2
DATOS$y_dev_sq <- DATOS$y_dev^2                    # (Y_i - Y_bar)^2 [SCT individual]

# 5. ESTIMACIÓN MANUAL DE PARÁMETROS (Beta 1 y Beta 0)
beta_1 <- sum(DATOS$xy_dev) / sum(DATOS$x_dev_sq)
beta_0 <- mean_y - beta_1 * mean_x

cat("Beta 0 estimado manualmente:", beta_0, "\n")
cat("Beta 1 estimado manualmente:", beta_1, "\n")

# 6. CÁLCULO DE VALORES ESTIMADOS Y RESIDUOS POR OBSERVACIÓN
DATOS$y_hat <- beta_0 + beta_1 * DATOS$x           # Y_hat_i
DATOS$e_i <- DATOS$y - DATOS$y_hat                 # Residuo e_i
DATOS$e_i_sq <- DATOS$e_i^2                        # Residuo al cuadrado [SCR individual]
DATOS$y_hat_dev_sq <- (DATOS$y_hat - mean_y)^2     # [SCE individual]

# Mostrar la tabla completa con todas las columnas generadas
print(DATOS)

# 7. SUMAS GLOBALES UTILIZANDO sum(DATOS$VECTOR)
SCT <- sum(DATOS$y_dev_sq)
SCR <- sum(DATOS$e_i_sq)
SCE <- sum(DATOS$y_hat_dev_sq)

# 8. VARIANZAS Y DESVIACIONES ESTÁNDAR
gl_reg <- 1
gl_res <- n - 2
gl_tot <- n - 1

var_error <- SCR / gl_res                           # Varianza del error (sigma^2 / CME)
sd_error <- sqrt(var_error)                         # Error estándar de la regresión

var_beta_1 <- var_error / sum(DATOS$x_dev_sq)      # Varianza de Beta 1
se_beta_1 <- sqrt(var_beta_1)                       # Error estándar de Beta 1

var_beta_0 <- var_error * ((1 / n) + (mean_x^2 / sum(DATOS$x_dev_sq))) # Varianza de Beta 0
se_beta_0 <- sqrt(var_beta_0)                       # Error estándar de Beta 0

r_cuadrado <- SCE / SCT                             # R^2 manual

# 9. CONSTRUCCIÓN MANUAL DE LA TABLA ANOVA
cm_reg <- SCE / gl_reg
cm_res <- var_error
f_est <- cm_reg / cm_res
p_val_f <- pf(f_est, gl_reg, gl_res, lower.tail = FALSE)

tabla_anova <- data.frame(
  Fuente_Variacion = c("Regresión (Explicada)", "Residuos (No Explicada)", "Total"),
  Suma_Cuadrados = c(SCE, SCR, SCT),
  Grados_Libertad = c(gl_reg, gl_res, gl_tot),
  Cuadrado_Medio = c(cm_reg, cm_res, NA),
  Estadistico_F = c(f_est, NA, NA),
  p_valor = c(p_val_f, NA, NA)
)

# Imprimir Resultados Finales
cat("\n--- TABLA ANOVA MANUAL ---\n")
print(tabla_anova)

cat("\n--- DESVIACIONES Y VARIANZAS ---\n")
cat("Error estándar de la regresión (sigma):", sd_error, "\n")
cat("Error estándar de Beta 0:", se_beta_0, "\n")
cat("Error estándar de Beta 1:", se_beta_1, "\n")
cat("R-cuadrado:", r_cuadrado, "\n")