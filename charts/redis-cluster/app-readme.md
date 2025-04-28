## Overview

Redis is a key-value based distributed database, this helm chart is for only standalone setup. This helm chart needs Redis Operator inside Kubernetes cluster. The redis definition can be modified or changed by values.yaml.

## Redis Cluster
Redis Cluster is a distributed implementation of Redis with the following goals in order of importance in the design:

- High performance and linear scalability up to 1000 nodes. There are no proxies, asynchronous replication is used, and no merge operations are performed on values.

- Acceptable degree of write safety: the system tries (in a best-effort way) to retain all the writes originating from clients connected with the majority of the master nodes. Usually there are small windows where acknowledged writes can be lost. Windows to lose acknowledged writes are larger when clients are in a minority partition.

- Availability: Redis Cluster is able to survive partitions where the majority of the master nodes are reachable and there is at least one reachable replica for every master node that is no longer reachable. Moreover using replicas migration, masters no longer replicated by any replica will receive one from a master which is covered by multiple replicas.