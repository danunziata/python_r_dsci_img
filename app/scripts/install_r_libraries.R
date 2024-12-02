# Lista de paquetes necesarios
required_packages <- c("glmnet", "caret", "umap", "plotly", "limma", "edgeR", "data.table", "tidyverse", "ggplot2", "cowplot", "gridExtra")

# Función para instalar paquetes si no están ya instalados
install_if_missing <- function(packages) {
  for (pkg in packages) {
    # Si el paquete no está instalado, lo instala
    if (!require(pkg, character.only = TRUE)) {
      cat(paste("Instalando el paquete:", pkg, "\n"))
      
      # Intentar instalar el paquete con un reintento
      attempt <- 1
      success <- FALSE
      while (attempt <= 3 && !success) {
        try({
          # Cambiar el repositorio de CRAN y aumentar el tiempo de espera
          options(timeout = 300)  # 5 minutos de tiempo de espera
          options(repos = c(CRAN = "https://cloud.r-project.org/"))
          install.packages(pkg, repos = getOption("repos"))
          
          # Si la instalación es exitosa
          success <- TRUE
          cat(paste("Paquete", pkg, "instalado correctamente.\n"))
        }, silent = TRUE)
        
        if (!success) {
          cat(paste("Intento", attempt, "fallido para instalar", pkg, "\n"))
          attempt <- attempt + 1
          Sys.sleep(5)  # Esperar 5 segundos antes de intentar nuevamente
        }
      }
      
      if (!success) {
        cat(paste("No se pudo instalar el paquete:", pkg, "después de 3 intentos.\n"))
      }
    } else {
      cat(paste("El paquete", pkg, "ya está instalado.\n"))
    }
  }
}

# Instalar los paquetes necesarios
install_if_missing(required_packages)
