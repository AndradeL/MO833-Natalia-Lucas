# MO833-Natalia-Lucas
Repositório para compartilhamento de arquivos de trabalho da disciplina MO833 da Unicamp.

##GROMACS
1. A execução da aplicação GROMACS é feita pela execução do script gromacs.sh
2. Os dados de entrada da aplicação estão disponíveis on-line e podem ser baixados através dos links abaixo:
* https://files.rcsb.org/download/1AKI.pdb
* http://www.mdtutorials.com/gmx/lysozyme/Files/ions.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/minim.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/nvt.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/npt.mdp
* http://www.mdtutorials.com/gmx/lysozyme/Files/md.mdp

obs: o download desses arquivos está incluso na execução do script

3. A chamada do script deve ser feita seguida de 4 argumentos, sendo eles:
* número de processos MPI
* número de threads OpenMP
* ids das gpus utilizadas (obs: os ids tem base zero)
* número de passos

##PYRANDA

