# Configuration and Information
A list of command to check configuration and information

## commands to check upon boot of slurm-i14
```bash
systemctl status slurmdbd.service
systemctl status mariadb.service
systemctl status slurmctl.service
systemctl status slurm-jobarchive.service
```

## sinfo

```bash
sinfo -o %C                                    # summarize CPUS by status Active/Idle/Other/Total
sinfo -R                                       # summarize down nodes, draining, drained
sinfo -t down                                  # summarize down,drained nodes or nodes with slurmd not responding
sinfo -s                                       # summarize by partition
sinfo -t idle,mix,alloc -p admin | cut -c1-40  # summarize the number of nodes in each state: mix(partial use), alloc(full use),idle(no use)
```

# sinfo: group nodes by feature

```bash
sinfo -o "%60N %10c %10m  %20f  %10G" -e
```
expected output
```txt
NODELIST                                                     CPUS       MEMORY      AVAIL_FEATURES        GRES      
hpc3-19-[07,17],hpc3-l18-03                                  64         500000      amd,epyc,epyc7551     (null)    
hpc3-14-[00-31],hpc3-15-[00-19,21,24-31],hpc3-17-[08-11],hpc 40         180000      intel,avx512          (null)    
hpc3-18-[00-01],hpc3-19-[00-06,08-11,18-19],hpc3-l18-[00-01] 64         500000      amd,epyc,epyc7601     (null)    
hpc3-18-02                                                   64         244000      amd,epyc,epyc7601     (null)    
hpc3-19-12                                                   24         500000      intel                 (null)    
hpc3-19-[13-15]                                              36         500000      intel                 (null)    
hpc3-21-[00-32],hpc3-22-[00-04,06-10]                        48         180000      intel,avx512,fastscr  (null)    
hpc3-19-16                                                   44         500000      intel                 (null)    
hpc3-20-[23,25-32]                                           48         180000      intel,avx512          (null)    
hpc3-l18-[04-05]                                             28         245000      intel,avx512          (null)    
hpc3-20-[16-20,24],hpc3-22-05                                48         372000      intel,avx512          (null)    
hpc3-20-[21-22]                                              48         756000      intel,avx512,fastscr  (null)    
hpc3-15-[20,22-23],hpc3-17-[00-03,12-19]                     40         372000      intel,avx512          (null)    
hpc3-17-[04-07]                                              40         756000      intel,avx512          (null)    
hpc3-gpu-16-00                                               40         180000      intel,avx512          gpu:V100:4
hpc3-l18-02                                                  40         1523544     amd,epyc,epyc7551     (null)    
hpc3-gpu-16-[01-07],hpc3-gpu-17-[02-04],hpc3-gpu-18-[01-02]  40         180000      intel,avx512          gpu:V100:4
hpc3-gpu-18-00                                               40         372000      intel,avx512          gpu:V100:4
```

# sinfo: group nodes by feature, node list at end of line
```bash
sinfo -o "%20f %10G %10m %4c %N" -e
```
expected output
```text
AVAIL_FEATURES       GRES       MEMORY     CPUS NODELIST
amd,epyc,epyc7551    (null)     500000     64   hpc3-19-[07,17],hpc3-l18-03
amd,epyc,epyc7601    (null)     244000     64   hpc3-18-02
intel,avx512         (null)     180000     40   hpc3-14-[00-31],hpc3-15-[00-19,21,24-31],hpc3-17-[08-11],hpc3-20-[00-15]
amd,epyc,epyc7601    (null)     500000     64   hpc3-18-[00-01],hpc3-19-[00-06,08-11,18-19],hpc3-l18-[00-01]
intel                (null)     500000     24   hpc3-19-12
intel                (null)     500000     36   hpc3-19-[13-15]
intel                (null)     500000     44   hpc3-19-16
intel,avx512         (null)     180000     48   hpc3-20-[23,25-32]
intel,avx512,fastscr (null)     180000     48   hpc3-21-[00-32],hpc3-22-[00-04,06-10]
intel,avx512         (null)     245000     28   hpc3-l18-[04-05]
intel,avx512         (null)     372000     40   hpc3-15-[20,22-23],hpc3-17-[00-03,12-19]
intel,avx512         (null)     372000     48   hpc3-20-[16-20,24],hpc3-22-05
intel,avx512,fastscr (null)     756000     48   hpc3-20-[21-22]
intel,avx512         (null)     756000     40   hpc3-17-[04-07]
intel,avx512         gpu:V100:4 180000     40   hpc3-gpu-16-00
amd,epyc,epyc7551    (null)     1523544    40   hpc3-l18-02
intel,avx512         gpu:V100:4 180000     40   hpc3-gpu-16-[01-07],hpc3-gpu-17-[02-04],hpc3-gpu-18-[01-02]
intel,avx512         gpu:V100:4 372000     40   hpc3-gpu-18-00
```

## view current configuration

view configuration

```bash
scontrol show config
scontrol -V
```

stop slurm from scheduling jpbs per partition and restart when needed

```bash
scontrol update PartitionName=free State=DOWN
scontrol update PartitionName=free State=UP
```

## sdrain and sresume

on slurm-i14 reserve and relesase whole node

```bash
/usr/local/bin/sdrain hpc3-14-04 "NPW, test drain and release "
/usr/local/bin/sresume hpc3-14-04
```

## modify QOS

check qos
```bash
sacctmgr show assoc format=user,account,qos where account=npw_lab
```

check qos for all rcic-admins
```bash
for A in $(getent group rcic-admin_lab_share | awk -F: '{print $NF}' | cut -d ',' -f 2- | tr ',' ' '); do sacctmgr show assoc format=user%-20,account%-20,qos where account=${A}_lab; echo; done
```

modify user QOS, show result
```bash
sacctmgr -i modify user npw where account=npw_lab set qos=low
sacctmgr show assoc format=user,account,qos where account=npw_lab
```

restore user QOS, show result
```bash
sacctmgr -i modify user npw where account=npw_lab set qos=high,normal,low
sacctmgr show assoc format=user,account,qos where account=npw_lab
```

## sbank deposit

deposit 10 hrs to npw_lab , time argument is in hrs .

```bash
sbank balance statement -a npw_lab
sbank deposit -c hpc3 -a npw_lab -t 10
sbank balance statement -a npw_lab
```
## check job archiver being populated
```
watch -d 'find /var/slurm/jobscript_archive'
```
