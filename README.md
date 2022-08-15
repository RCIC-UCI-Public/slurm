# slurm

Collection of configuration, testing, info etc for slurm

## Test Jobs
 
In testing/ there are test submit scripts 

- test1.sub: module load and total installed modules number
- test2.sub: check user environment
- test3.sub: check if can run srun from submit script
- test4.sub: nvme constrain and TMPDIR
- test5.sub: submit job to standard partition
- test6.sub: conda env check
- test7.sub: an array job on free partition, separate output per task
- test8.sub: an array job on standard partition, separate output per task
- test9.sub: a 4-array job with 1000 small tasks. Output files should be 1001 lines
- test10.sh: execute as 'bash test10.sh" which will submit 3 dependency jobs
             test10-1.sub, test10-2.sub, test10-3.sub
- test11.sub: multiple tasks and memory requirement
- test12.sub: run stress (or stress-ng) to go over the requested memory limit 
              job should be OOM 
- interactive.md listing of srun commands with expected outcome
