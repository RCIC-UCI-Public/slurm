# Interactive jobs 
 a list of command to run interactively 

## for free partition

```bash
srun -p free --pty /bin/bash -i
```

These should fail if DISPLAY is not set

```bash
srun --x11 -p free  --pty /bin/bash -i
srun --x11 -p free -c 2 -N 1 --mem-per-cpu=10G --pty /bin/bash -i
```

## start interactive job and attach to it

```bash
srun --job-name=TUN --pty /bin/bash -i
srun --pty --jobid=$(squeue -t R -o%i -hu $USER --name=TUN) /bin/bash
squeue -u npw
```

Alternatively  start a job, run interactive command via attaching to it from a different shell
```bash
srun --job-name=TUN --pty /bin/bash -i
srun --pty --jobid $JOBID top
```

## for standard partition

```bash
srun --nodes=1 --ntasks-per-node=1 --pty /bin/bash -i
```

should fail if DISPLAY is not set

```bash
srun --x11 --mem=100000 --time=9600 -A NPW_LAB --pty /bin/bash -i
```

Should get TRES=cpu=12,mem=72000M,node=1,billing=12

```bash
srun -p standard --mem-per-cpu=6000M --nodes=1 --ntasks=1 --cpus-per-task=12 --time=00:20:00 --pty /bin/bash -i
```

Should get TRES=cpu=12,mem=72G,node=1,billing=12

```bash
srun -p standard --mem-per-cpu=6G --nodes=1 --ntasks=1 --cpus-per-task=12 --time=00:20:00 --pty /bin/bash -i
```

## check for group account 

```bash
srun -A NPW_LAB -c 4 -p standard --pty /bin/bash -i
srun -A NPW_LAB --mem=200G  --pty /bin/bash -i
srun -A NPW_LAB --cpus-per-task=8 --mem 128G --pty bash -i
```

These  should succeed
```bash
srun -A HACKATHON_GPU -N 1 -p free-gpu --gres=gpu:V100:2 -t 3-00:00:00 --pty bash -i
srun -A HACKATHON_GPU -p gpu --gres=gpu:V100:1  --pty /bin/bash -i 
srun -A hackathon_gpu -p gpu --gres=gpu:V100:1  --pty /bin/bash -i 
srun -A NPW_LAB -p standard  --pty /bin/bash -i 
srun -A npw_lab -p standard  --pty /bin/bash -i 
```

These  should fail

```bash
srun -A HACKATHON_GPU -p standard  --pty /bin/bash -i 
srun -A hackathon_gpu -p standard  --pty /bin/bash -i 
srun -p gpu --pty /bin/bash -i
```

## Run sacct and seff

```bash
export SACCT_FORMAT="JobID%20,Partition,NodeList,Elapsed,State,ExitCode,MaxRSS,AllocTRES%32"
sacct -j 14199462
seff 14199462
/pub/hpc3/zotledger -u npw
```
