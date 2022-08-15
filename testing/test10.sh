#!/bin/bash

# first job - no dependencies
jid1=$(sbatch -t 00:10:00 --parsable test10-1.sub)

# multiple jobs can depend on a single job
jid2=$(sbatch  -t 00:10:00 --parsable --dependency=afterany:$jid1 test10-2.sub)
jid3=$(sbatch  -t 00:10:00 --parsable --dependency=afterok:$jid1:$jid2 test10-3.sub)

echo "Submitted" $jid1 $jid2 $jid3
echo "You can restart failed jobs with: scontrol requeue JOBID"

