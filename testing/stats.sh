#!/bin/bash

# this script collects minimal info about slurm configuration 
# the output is collected in file slurm-info-<timestamp>

DAT=`date +%Y%m%d-%H%M`
OUT=slurm-info-$DAT

date > $OUT

echo "Running: scontrol -V" 
echo "## scontrol -V" >> $OUT
scontrol -V &>> $OUT

echo "Running: sinfo" 
echo "## sinfo " >> $OUT
sinfo &>> $OUT

echo "Running: scontrol show config"
echo "## scontrol show config" >> $OUT
scontrol show config &>> $OUT

echo "Running: sacctmgr show assoc"
echo "## sacctmgr show assoc" >> $OUT
sacctmgr show assoc  &>> $OUT

echo "Running: sbank balance statement -A"
echo "## sbank balance statement -A" >> $OUT
sbank balance statement -A &>> $OUT

echo "Running: sacctmgr list users"
echo "## sacctmgr list users" &>> $OUT
sacctmgr list users &>> $OUT

echo "Running sshare"
echo "## sshare" >> $OUT
sshare &>> $OUT
