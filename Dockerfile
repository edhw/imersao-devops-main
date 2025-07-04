# Use uma imagem oficial do Python como imagem base.
# python:3.10-slim é uma boa escolha por ser leve e estável.
FROM python:3.10-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Esta camada só será reconstruída se o requirements.txt mudar.
COPY requirements.txt .

# Instala as dependências do projeto.
# --no-cache-dir: Desabilita o cache do pip para manter a imagem menor.
# --upgrade pip: Garante que a versão mais recente do pip seja usada.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# --host 0.0.0.0 é necessário para tornar a aplicação acessível externamente.
# O comando foi corrigido e a flag --reload removida, pois não é ideal para produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
