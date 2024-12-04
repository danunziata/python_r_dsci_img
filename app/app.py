import streamlit as st
import subprocess

# Configuración de la página
st.set_page_config(
    page_title="Python and R: Hello World",
    page_icon="🌍",
    layout="wide"
)

# Título principal
st.title("Hello World from Python and R")

# Subtítulo
st.subheader("Demonstrating Python and R integration")

# División en dos columnas
col1, col2 = st.columns(2)

# Mensaje en Python
with col1:
    st.subheader("Python")
    st.write("Hello World from Python!")

# Ejecutar y mostrar el mensaje desde R
with col2:
    st.subheader("R")
    try:
        # Ejecutar el script R
        result = subprocess.run(
            ["Rscript", "helloworld.R"],  # Asegúrate de que el archivo exista
            capture_output=True,
            text=True
        )

        # Mostrar la salida del script R
        if result.returncode == 0:
            st.write(result.stdout)
        else:
            st.error(f"Error in R script execution: {result.stderr}")
    except Exception as e:
        st.error(f"An error occurred while running the R script: {e}")