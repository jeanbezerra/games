#!/bin/bash

# Atualizar e instalar dependências
sudo apt-get update
sudo apt-get install -y git wget screen

# Criar diretório para o servidor
mkdir -p ~/fivem_server
cd ~/fivem_server

# Baixar o artefato mais recente do FiveM
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/ -O - | grep -Eo 'https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/[0-9]+-[0-9a-f]{5}-[0-9a-f]{5}-[0-9]+/[a-zA-Z0-9_.-]+' | head -1 | wget -i -

# Extrair os arquivos
tar -xvf fx.tar.xz
rm fx.tar.xz

# Clonar repositório cfx-server-data
git clone https://github.com/citizenfx/cfx-server-data.git

# Copiar e configurar o arquivo server.cfg
cp cfx-server-data/server.cfg .
echo -e "\n# Configuração adicional\nsv_licenseKey changeme\nsv_hostname 'Meu Servidor FiveM'" >> server.cfg

# Criar script de inicialização
cat <<EOL > start_server.sh
#!/bin/bash
cd ~/fivem_server
screen -S fivem_server -d -m ./run.sh +exec server.cfg
EOL

# Tornar o script executável
chmod +x start_server.sh

# Informar ao usuário sobre o próximo passo
echo "A instalação está completa. Edite o arquivo server.cfg para ajustar as configurações do servidor."
echo "Para iniciar o servidor, execute: ./start_server.sh"

