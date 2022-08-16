# Interactive jobs 
 a list of command to run interactively 

## for free partition

start interactive job
```bash
srun -p free --pty /bin/bash -i
```

these should fail if DISPLAY is not set

```bash
srun --x11 -p free  --pty /bin/bash -i
srun --x11 -p free -c 2 -N 1 --mem-per-cpu=10G --pty /bin/bash -i
```

## for standard partition

start interative job
```bash
srun --nodes=1 --ntasks-per-node=1 --pty /bin/bash -i
```

should fail if DISPLAY is not set

```bash
srun --x11 --mem=100000 --time=9600 -A NPW_LAB --pty /bin/bash -i
```

start interactive job and attach to it
```bash
srun --job-name=TUN --pty /bin/bash -i
srun --pty --jobid=$(squeue -t R -o%i -hu $USER --name=TUN) /bin/bash
squeue -u npw
```

alternatively  start a job, run interactive command via attaching to it from a different shell
```bash
srun --job-name=TUN --pty /bin/bash -i
srun --pty --jobid $JOBID top
```

ahould get TRES=cpu=12,mem=72000M,node=1,billing=12

```bash
srun -p standard --mem-per-cpu=6000M --nodes=1 --ntasks=1 --cpus-per-task=12 --time=00:20:00 --pty /bin/bash -i
scontrol show job $(squeue -u $USER -t R -h -o%i)
```

ahould get TRES=cpu=12,mem=72G,node=1,billing=12

```bash
srun -p standard --mem-per-cpu=6G --nodes=1 --ntasks=1 --cpus-per-task=12 --time=00:20:00 --pty /bin/bash -i
scontrol show job $(squeue -u $USER -t R -h -o%i)
```

ERROR: should get 8 CPUs, but getting 6 
```bash
srun --ntasks=1 --cpus-per-task=6 --mem=45000M --pty /bin/bash -i
scontrol show job $(squeue -u $USER -t R -h -o%i)
```

## gpu and free-gpu 

ERROR not provideing GRES still gets to the GPU queue
```bash
srun -p free-gpu --pty /bin/bash -i 
```

this should succeed
```bash
srun -p free-gpu --gres=gpu:V100:1  --pty /bin/bash -i 
```

these  should succeed
```bash
srun -A HACKATHON_GPU -N 1 -p free-gpu --gres=gpu:V100:2 -t 3-00:00:00 --pty bash -i
srun -A HACKATHON_GPU -p gpu --gres=gpu:V100:1  --pty /bin/bash -i 
srun -A hackathon_gpu -p gpu --gres=gpu:V100:1  --pty /bin/bash -i 
srun -A NPW_LAB -p standard  --pty /bin/bash -i 
srun -A npw_lab -p standard  --pty /bin/bash -i 
```

these  should fail (as they don't request a gres as required by current job_submit.lua)

```bash
srun -A HACKATHON_GPU -p standard  --pty /bin/bash -i 
srun -A hackathon_gpu -p standard  --pty /bin/bash -i 
srun -p gpu --pty /bin/bash -i
```

## highmen hugemem and maxmem

interactive job in highmem
```bash
srun --mem=200G -p highmem --time=00:02:00  --pty /bin/bash -i
queue -u $USER
JOBID           PARTITION     NAME     USER    ACCOUNT ST        TIME  CPUS NODE NODELIST(REASON)
14336791        highmem       bash      npw        npw  R        0:07    20    1 hpc3-20-24
```

interactive job in hugemem
```bash
srun --mem=400G -p hugemem --time=00:02:00  --pty /bin/bash -i
hpc3-20-21 2001%  squeue -u $USER
JOBID           PARTITION     NAME     USER    ACCOUNT ST        TIME  CPUS NODE NODELIST(REASON)
14336795        hugemem       bash      npw        npw  R        0:08    23    1 hpc3-20-21
```

interactive job in maxmem
```bash
srun -p maxmem -c 40  --time=00:02:00  --pty /bin/bash -i
hpc3-l18-02 2001%  squeue -u $USER
JOBID           PARTITION     NAME     USER    ACCOUNT ST        TIME  CPUS NODE NODELIST(REASON)
14336798        maxmem        bash      npw        npw  R        0:05    40    1 hpc3-l18-02
```

## check group account 

```bash
srun -A NPW_LAB -c 4 -p standard --pty /bin/bash -i
srun -A NPW_LAB --mem=200G  --pty /bin/bash -i
srun -A NPW_LAB --cpus-per-task=8 --mem 128G --pty bash -i
```

## run sacct and seff

```bash
export SACCT_FORMAT="JobID%20,Partition,NodeList,Elapsed,State,ExitCode,MaxRSS,AllocTRES%32"
sacct -j 14199462
seff 14199462
/pub/hpc3/zotledger -u npw
```
