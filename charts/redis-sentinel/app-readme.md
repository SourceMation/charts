## Overview

Redis is a key-value based distributed database, this helm chart is for only standalone setup. This helm chart needs Redis Operator inside Kubernetes cluster. The redis definition can be modified or changed by values.yaml.

## Redis Sentinel
Redis Sentinel is a monitoring solution for Redis instances that handles automatic failover of Redis masters and service discovery. Since Sentinel is both responsible for reconfiguring instances during failovers, and providing configurations to clients connecting to Redis masters or replicas, clients are required to have explicit support for Redis Sentinel.

This is the full list of Sentinel capabilities at a macroscopic level (i.e. the big picture):

- Monitoring. Sentinel constantly checks if your master and replica instances are working as expected.

- Notification. Sentinel can notify the system administrator, or other computer programs, via an API, that something is wrong with one of the monitored Redis instances.

- Automatic failover. If a master is not working as expected, Sentinel can start a failover process where a replica is promoted to master, the other additional replicas are reconfigured to use the new master, and the applications using the Redis server are informed about the new address to use when connecting.

- Configuration provider. Sentinel acts as a source of authority for clients service discovery: clients connect to Sentinels in order to ask for the address of the current Redis master responsible for a given service. If a failover occurs, Sentinels will report the new address.