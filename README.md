# MO833-Natalia-Lucas
Repositório para compartilhamento de arquivos de trabalho da disciplina MO833 da Unicamp.

## GROMACS
1. A execução da aplicação GROMACS é feita pela execução do script gromacs.sh e pode ser feita utilizando o container _singularity_ gromacs.sif com o comando:
```bash
singularity exec gromacs.sif sh gromacs.sh
```
2. Os dados de entrada da aplicação estão disponíveis on-line e podem ser baixados através dos links abaixo:
* https://files.rcsb.org/download/1AKI.pdb
* http://www.mdtutorials.com/gmx/lysozyme/Files/ions.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/minim.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/nvt.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/npt.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/md.mdp

*Obs*: o download desses arquivos está incluso na execução do script

3. A chamada do script deve ser feita seguida de 4 argumentos, sendo eles:
* número de processos MPI
* número de threads OpenMP
* IDs das GPUs utilizadas (obs: os IDs tem base zero)
* número de passos

## PYRANDA

A execução da aplicação pyranda é feita pelo script pyranda.sh e pode ser feita utilizando o container _singularity_ pyranda.sif com o comando
```bash
singularity exec pyranda.sif ./pyranda.sh
```
##### Certifique-se de que pyranda.sh tem permissões de execução antes de executar o comando acima, senão pode fazer o comando `chmod 777 pyranda.sh` e depois rodar o script.
##### Para rodar o script deve-se ter baixado este repositório todo, ou pelo menos a pasta pyranda e o container pyranda.sif.
##### O script irá realizar o teste e exibir a saída da ferramenta _time_ no arquivo time.txt no mesmo diretório em que foi executado. A aplicação é executada 3 vezes com o número de núcleos sendo o máximo possível para a máquina, podendo esse ser modificado alterando o parâmetro _np_ na linha 4 de _pyranda.sh_.