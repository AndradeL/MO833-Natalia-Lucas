# MO833-Natalia-Lucas
Repositório para compartilhamento de arquivos de trabalho da disciplina MO833 da Unicamp.

## Containers
Para construção dos containers para reproduzir os experimentos siga os passos abaixo:

1. Instale o container singularity e suas dependências (https://sylabs.io/guides/3.2/user-guide/ ou execute os comando no final do documento)
2. Faça a construção dos containers com os seguintes comandos
```
# Para construir o Gromacs:
sudo singularity build gromacs.sif gromacs_recipe
# Para construir o Pyranda:
sudo singularity build pyranda.sif pyranda_recipe
```

## GROMACS
1. A execução da aplicação GROMACS é feita pela execução do script gromacs.sh e pode ser feita utilizando o container _singularity_ gromacs.sif com o comando:
```bash
singularity exec gromacs.sif sh gromacs.sh ntmpi ntomp gpu-ids nsteps
```
onde:
* ntmpi: número de processos MPI
* ntomp: número de threads OpenMP
* gpu-ids: IDs das GPUs utilizadas (ex: gpu-id = 01 corresponde ao utilizar as GPUs com IDs 0 e 1)
* nsteps: número de passos da simulação

2. Os dados de entrada da aplicação estão disponíveis on-line e podem ser baixados através dos links abaixo:
* https://files.rcsb.org/download/1AKI.pdb
* http://www.mdtutorials.com/gmx/lysozyme/Files/ions.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/minim.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/nvt.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/npt.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/md.mdp

*Obs*: o download desses arquivos está incluso na execução do script



## PYRANDA

A execução da aplicação pyranda é feita pelo script pyranda.sh e pode ser feita utilizando o container _singularity_ pyranda.sif com o comando
```bash
singularity exec pyranda.sif ./pyranda.sh
```
##### Certifique-se de que pyranda.sh tem permissões de execução antes de executar o comando acima, senão pode fazer o comando `chmod 777 pyranda.sh` e depois rodar o script.
##### Para rodar o script deve-se ter baixado este repositório todo, ou pelo menos a pasta pyranda e o container pyranda.sif.
##### O script irá realizar o teste e exibir a saída da ferramenta _time_ no arquivo time.txt no mesmo diretório em que foi executado. A aplicação é executada 3 vezes com o número de núcleos sendo o máximo possível para a máquina, podendo esse ser modificado alterando o parâmetro _np_ na linha 4 de _pyranda.sh_.

## Comando para instalação do singularity
```
sudo apt-get update && \
sudo apt-get install -y build-essential \
libssl-dev uuid-dev libgpgme11-dev libseccomp-dev pkg-config squashfs-tools
export VERSION=1.11.4 OS=linux ARCH=amd64  # change this as you need
wget -O /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz && \
sudo tar -C /usr/local -xzf /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
source ~/.bashrc
curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh |
sh -s -- -b $(go env GOPATH)/bin v1.15.0
mkdir -p ${GOPATH}/src/github.com/sylabs && \
cd ${GOPATH}/src/github.com/sylabs && \
git clone https://github.com/sylabs/singularity.git && \
cd singularity
git checkout v3.2.1
cd ${GOPATH}/src/github.com/sylabs/singularity && \
./mconfig && \
cd ./builddir && \
make && \
sudo make install
cd ~; singularity version
```
