# Accounting 
A list of command to check accounting  and DB

## sreport

```bash
sreport -t percent -T ALL cluster utilization 
```

Commands with expected outputs 

For a lab account

```bash
sreport cluster AccountUtilizationByUser Start=2022-06-01 End=2022-08-01 -t Hours account=penner_lab
--------------------------------------------------------------------------------
Cluster/Account/User Utilization 2022-06-01T00:00:00 - 2022-07-31T23:59:59 (5270400 secs)
Usage reported in CPU Hours
--------------------------------------------------------------------------------
  Cluster         Account     Login     Proper Name     Used   Energy 
--------- --------------- --------- --------------- -------- -------- 
     hpc3      penner_lab                              11995        0 
     hpc3      penner_lab  ajainswo Aaron Joseph A+       49        0 
     hpc3      penner_lab  cacandel Christopher An+        2        0 
     hpc3      penner_lab    liuag1    Amy Gong Liu      192        0 
     hpc3      penner_lab  lliebert Lindsay Liebert      257        0 
     hpc3      penner_lab  lnienste Liliane Nienst+       31        0 
     hpc3      penner_lab  mspiege1 Michelle Spieg+      171        0 
     hpc3      penner_lab     pyyoo Paul Youngmin +    11294        0 
     hpc3      penner_lab  qbrummet Quentin Brummet        0        0 
```

For an account

```bash
sreport cluster AccountUtilizationByUser Start=2022-07-01 account=npw
--------------------------------------------------------------------------------
Cluster/Account/User Utilization 2022-07-01T00:00:00 - 2022-08-14T23:59:59 (3888000 secs)
Usage reported in CPU Minutes
--------------------------------------------------------------------------------
  Cluster         Account     Login     Proper Name     Used   Energy 
--------- --------------- --------- --------------- -------- -------- 
     hpc3             npw                                222        0 
     hpc3             npw       npw Nadya P Willia+      222        0 


sreport  cluster AccountUtilizationByUser start=2022-07-01 -t hours account=npw
--------------------------------------------------------------------------------
Cluster/Account/User Utilization 2022-07-01T00:00:00 - 2022-08-14T23:59:59 (3888000 secs)
Usage reported in CPU Hours
--------------------------------------------------------------------------------
  Cluster         Account     Login     Proper Name     Used   Energy 
--------- --------------- --------- --------------- -------- -------- 
     hpc3             npw                                  4        0 
     hpc3             npw       npw Nadya P Willia+        4        0 

sreport cluster AccountUtilizationByUser Start=2022-07-01 user=npw
--------------------------------------------------------------------------------
Cluster/Account/User Utilization 2022-07-01T00:00:00 - 2022-08-14T23:59:59 (3888000 secs)
Usage reported in CPU Minutes
--------------------------------------------------------------------------------
  Cluster         Account     Login     Proper Name     Used   Energy 
--------- --------------- --------- --------------- -------- -------- 
     hpc3         npw_lab       npw Nadya P Willia+       15        0 
     hpc3   hackathon_gpu       npw Nadya P Willia+        1        0 
     hpc3             npw       npw Nadya P Willia+      222        0 
```


## sshare

```bash
sshare --account=weil21_lab,dmobley_lab,trupert_lab,jyu20_lab_gpu,caoph_lab,ffurche_lab,jranders_lab,pjohnso3_lab,dmobley_lab_gpu,srwhite_lab
```
expected output
```txt
             Account       User  RawShares  NormShares    RawUsage  EffectvUsage  FairShare 
-------------------- ---------- ---------- ----------- ----------- ------------- ---------- 
caoph_lab                                1    0.000265  7106161665      0.047462            
dmobley_lab                              1    0.000265 13418773071      0.089623            
dmobley_lab_gpu                          1    0.000265  5266678307      0.035176            
ffurche_lab                              1    0.000265  6821382630      0.045560            
jranders_lab                             1    0.000265  6288449940      0.042000            
jyu20_lab_gpu                            1    0.000265  7508240295      0.050147            
pjohnso3_lab                             1    0.000265  6251055651      0.041750            
srwhite_lab                              1    0.000265  3432665424      0.022927            
trupert_lab                              1    0.000265  8558751019      0.057163            
weil21_lab                               1    0.000265 21466384467      0.143373           
```

```bash
sshare
sshare | wc -l
3782
sshare -a --format=Account,User,NormShares,NormUsage,FairShare | wc -l
8724
```

```bash
sshare -A npw -U npw 
             Account       User  RawShares  NormShares    RawUsage  EffectvUsage  FairShare 
-------------------- ---------- ---------- ----------- ----------- ------------- ---------- 
npw                         npw          1    1.000000     1788345      1.000000   0.315013 


sshare -A npw --format=Account,User,NormShares,NormUsage,FairShare  
             Account       User  NormShares   NormUsage  FairShare 
-------------------- ---------- ----------- ----------- ---------- 
npw                                0.000265    0.000012            
 npw                        npw    1.000000    0.000012   0.315013 

```



## sacctmgr

```bash
sacctmgr show user -s 
sacctmgr show user -s | wc -l
4951
```

```bash
sacctmgr list user  -s npw
```
```txt
 User Def Acct  Admin  Cluster    Account Partition  Share Priority MaxJobs MaxNodes  MaxCPUs MaxSubmit MaxWall MaxCPUMins             QOS  Def QOS 
----- -------- ------ -------- ---------- --------- ------ -------- ------- -------- -------- --------- ------- ---------- --------------- -------- 
 npw      npw    None     hpc3 hackathon+                 1                                                                 high,low,normal   normal 
 npw      npw    None     hpc3    npw_lab                 1                                                                 high,low,normal   normal 
 npw      npw    None     hpc3 hackathon+                 1                                                                 high,low,normal   normal 
 npw      npw    None     hpc3    npw_gpu                 1                                                                 high,low,normal   normal 
 npw      npw    None     hpc3  hackathon                 1                                                                          normal          
 npw      npw    None     hpc3        npw                 1                                                                 high,low,normal   normal 
 npw      npw    None     hpc3 ppapadop_+                 1                                                                 high,low,normal   normal 
```

```bash
sacctmgr show qos format="name,priority,preempt,usagefactor,grptres,MaxTRESPerNode,MaxTRESPU,MaxJobsPU,MaxTRESPA,MaxJobsPA"
```

expected output
```txt
      Name   Priority    Preempt UsageFactor       GrpTRES MaxTRESPerNode     MaxTRESPU MaxJobsPU     MaxTRESPA MaxJobsPA 
---------- ---------- ---------- ----------- ------------- -------------- ------------- --------- ------------- --------- 
    normal        500  guest,low    1.000000                                                                              
       low        100               0.000000                                                                              
      high       2000  guest,low    2.000000                                                                              
    ultron      20000  guest,low    0.000000                                                                              
     guest          0               0.000000       cpu=200                      cpu=200                                   
   nogpu4u          0               1.000000                   gres/gpu=0                                                 
  nogpu4u2        500  guest,low    1.000000                   gres/gpu=0                                                 
highmempa+          0               1.000000       cpu=600                                                                
     debug          0               1.000000                                                                            1 
 free-part          0               1.000000                                   cpu=2000      2000      cpu=2000      2000 
highmem-p+          0               1.000000                                    cpu=750       750       cpu=750       750 
hugemem-p+          0               1.000000                                    cpu=192       192       cpu=192       192 
free-gpu-+          0               1.000000                                                    8                      16 
  gpu-part          0               1.000000                                                                              
```

Cluster associations 

```bash
sacctmgr list associations cluster=hpc3 format=Account,Cluster,User,Fairshare | wc -l
8724
```

```bash
sacctmgr show assoc where user=tgokey format=Account%-16,User%-8,Partition,Share,MaxJobs
         Account     User  Partition     Share MaxJobs 
---------------- -------- ---------- --------- ------- 
andricio_lab_gpu tgokey                      1         
andricio_lab     tgokey                      1     300 
openforcefield   tgokey         free         1     300 
tgokey           tgokey                      1     300 
dmobley_lab      tgokey                      1     300 
```

```bash
sacctmgr show assoc where account=jallard_lab format=account,user,partition,grpTres,MaxTresMins,GrpTresMins
   Account       User  Partition       GrpTRES   MaxTRESMins   GrpTRESMins 
---------- ---------- ---------- ------------- ------------- ------------- 
jallard_l+                                                    cpu=19384500 
jallard_l+    jallard                                                      
jallard_l+   jcorrett                                                      
jallard_l+   robertbt                                                      
jallard_l+    sohyeop                                                      
jallard_l+    trinin1    
```

## sacct

```bash
sacct -j 14233362  -X 
```
expected output 
```txt
       JobID    JobName  Partition    Account  AllocCPUS      State ExitCode 
------------ ---------- ---------- ---------- ---------- ---------- -------- 
14233362           bash   standard        npw          4  COMPLETED      0:0 
```

```bash
sacct -X --format=User,JobID,Jobname,partition,state,time,elapsed,MaxRss,MaxVMSize,ncpus 
sacct -X --format=User,JobID,Jobname,partition,state,time,elapsed,MaxRss,MaxVMSize,ncpus -u npw
```

Modify user account

initial account

```bash
sacctmgr show assoc where account=npw format=account,user,partition,grpTres,MaxTresMins,GrpTresMins
   Account       User  Partition       GrpTRES   MaxTRESMins   GrpTRESMins 
---------- ---------- ---------- ------------- ------------- ------------- 
       npw                                                       cpu=60000 
       npw        npw                                                      
```

set a limit

```bash
sacctmgr modify user jcorrett set MaxTRESMins=cpu=10000
sacctmgr show assoc where account=npw format=account,user,partition,grpTres,MaxTresMins,GrpTresMins
```

remove a limit

```bash
sacctmgr modify user npw set MaxTRESMins=cpu=-1
sacctmgr show assoc where account=npw format=account,user,partition,grpTres,MaxTresMins,GrpTresMins
```

## zotledger

```bash
/pub/hpc3/zotledger -p standard,free --start 2022-05-01 -d 120 -A npw_lab
      DATE       USER          ACCOUNT  PARTITION     JOBID    JOBNAME ARRAYLEN     CPUS  WALLHOURS        SUs
2022-08-11        npw          npw_lab   standard  14214309       bash        -        1       0.00       0.00
2022-08-11        npw          npw_lab   standard  14214310       bash        -        1       0.00       0.00
2022-08-11        npw          npw_lab   standard  14214325       bash        -        4       0.00       0.01
2022-08-11        npw          npw_lab   standard  14214327       bash        -       16       0.00       0.03
2022-08-11        npw          npw_lab   standard  14214328       bash        -       34       0.00       0.10
2022-08-11        npw          npw_lab   standard  14214329       bash        -       34       0.00       0.09
2022-08-15        npw          npw_lab   standard  14265512      test5        -        1       0.00       0.00
2022-08-15        npw          npw_lab   standard  14265528      test5        -        1       0.00       0.00
    TOTALS          -                -          -         -          -        -        -       0.01        0.2
```
