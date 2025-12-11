FROM rocker/r-ubuntu

# Install system dependencies (pandoc, V8, xml2, ragg/graphics, curl/ssl)
RUN apt-get update && apt-get install -y \
    pandoc \
    libv8-dev \
    libnode-dev \
    libxml2 \
    libxml2-dev \
    libwebp-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff5-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfontconfig1-dev \
    libcurl4-openssl-dev \
    libssl-dev \
  && rm -rf /var/lib/apt/lists/*


# Set up project directory
RUN mkdir /project
WORKDIR /project

# Create subdirectories (some may be overwritten by COPY)
RUN mkdir -p code data report figs tables renv

# Copy project files into the image
COPY code code
COPY data data
COPY report report
COPY Makefile .
COPY .Rprofile .
COPY renv.lock .
COPY renv/activate.R renv/
COPY renv/settings.json renv/

# Install renv + restore package library from renv.lock
RUN Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::restore(prompt = FALSE)"

# **Default command: render the report using our script**
CMD ["Rscript", "code/render_report_docker.R"]
