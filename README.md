# slurm

Collection of configuration, testing, info etc for slurm

## Test Jobs
 
In testing/ there are test submit scripts 

- test01.sub: module load and total installed modules number
- test02.sub: check user environment
- test03.sub: check if can run srun from submit script
- test04.sub: nvme constrain and TMPDIR
- test05.sub: submit job to standard partition
- test06.sub: conda env check
- test07.sub: an array job on free partition, separate output per task
- test08.sub: an array job on standard partition, separate output per task
- test09.sub: a 4-array job with 1000 small tasks. Output files should be 1001 lines
- test10.sh: execute as 'bash test10.sh" which will submit 3 dependency jobs
             test10-1.sub, test10-2.sub, test10-3.sub
- test11.sub: multiple tasks and memory requirement
- test12.sub: run stress (or stress-ng) to go over the requested memory limit 
              job should be OOM 
- test13.sub: check nvidia-smi  

Interactive commands 

- **accounting.md** A list of command to check accounting  and DB
- **configuration.md** A list of command to check configuration information
- **interactive.md** A list of srun commands with expected outcome

Scripts for validation

- stats.sh  collects key slurm config and DB info. 
  Run for validation of DB consistency when upgrading slurm 
