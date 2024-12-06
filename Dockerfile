# Imagen base
FROM ubuntu:22.04

# Establecer variables de entorno para evitar interacción durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar repositorios e instalar dependencias básicas
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    software-properties-common \
    curl \
    gnupg2 \
    lsb-release \
    ca-certificates \
    locales \
    sudo \
    wget \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libicu-dev \
    python3.11 \
    python3.11-dev \
    python3.11-distutils \
    python3-pip \
    r-base && \
    apt-get clean

# Configurar locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Establecer Python 3.11 como predeterminado
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Instalar setuptools y wheel antes de instalar las dependencias de Python
RUN pip install --upgrade pip setuptools wheel

# Crear un directorio de trabajo
WORKDIR /app

# Copiar los archivos de requisitos de Python y R
COPY ./app/requirements.txt requirements.txt
COPY ./app/install_r_libraries.R install_r_libraries.R

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Instalar las librerías de R
RUN Rscript install_r_libraries.R

# Copiar la aplicación básica de Streamlit
COPY ./app /app

# Exponer el puerto para Streamlit
EXPOSE 8501

# Comando por defecto para ejecutar Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501"]
