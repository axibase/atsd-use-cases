# Allocating Resources to Containers

![](./images/real-time-insights.png)

Allocating resources to containers is important; containers are less isolated than virtual machines and thus prone to the cannibalization of resources from other containers. A single runaway container can lead to performance degradation across an entire host. This tutorials covers the basic commands and best practices for allocating resources to containers.

## CPU

Each container is assigned a share of CPU. By default, this is set to `1024`. By itself `1024` CPU share does not mean anything. When only a single container is running, that container uses all available CPU resources. However, if you launch another container and they both have `1024` CPU share defined, then each container claims at least 50% of CPU resources.

CPU share is set using the `-c` or `--cpu-shares` flag upon container launch:

```sh
docker run -ti -c 1024 ubuntu:14.04 /bin/bash
```

Assume three containers are running, two with `1024` CPU share and one with `512`. The two containers with `1024` CPU share can each use 40% of the available CPU, while the container with `512` CPU share is limited to 20%. This scenario is only applicable for hosts operating under conditions where CPU resources are scarce. For an idle system running multiple containers, a single container with a small CPU share is able to utilize 100% of the unused CPU capacity.

Another option to set CPU limits is CPU Completely Fair Scheduler (CFS). In this case, set **CPU Period** (100 ms by default) and **CPU Quota** (number of CPU ticks allocated to container):

```sh
docker run -ti --cpu-period=50000 --cpu-quota=10000 ubuntu:14.04 /bin/bash
```

The container gets 20% CPU runtime every 50 ms. This is a stricter limit than setting CPU shares; in this case the container is not able to surpass the set limit on an idle system.

Containers can also be assigned to use only specific CPUs or CPU cores. In this instance, the CPU share system only applies to processes running on the same core. If there are two containers that are assigned to different CPU cores, and no other containers running, then both of these containers are able to utilize 100% of their CPU core regardless of the shares until other containers are launched or assigned to the same CPU cores.

The choice between these two methods comes down to the applications and microservices running inside the containers. Allocating a strict limit for CPU usage is better in most cases, especially when the amount of processing power each container requires under a load is known beforehand. This approach guarantees that during idle hours, no application uses the extra available CPU resources and suffers performance degradation when another application starts to use its allocated CPU share.

## Memory

Things are much simpler with respect to memory. Limit memory with a short`-m` flag, these limits are applied to both memory and swap.

```sh
docker run -ti -m 300M --memory-swap 300M ubuntu:14.04 /bin/bash
```

> This command limits the container memory and swap space usage to 300 MB each.

Currently, controlling the amount of allocated memory and swap separately is not possible in Docker. By default, when a container is launched there are no set memory limits, which can lead to issues where a single container hogs all the memory and makes the system unstable.

## Disk

Disk space and `read/write` speeds can be limited in Docker. By default `read/write` speed is unlimited, but if required, limit `read/write` speed with `cgroups`.

Each container is allocated 10 GB of space by default. This value can be excessive or lacking depending on the application or microservice. The amount of allocated disk space can be altered when upon initial container launch.

## Conclusion

Controlling resource allocation is simple and easily implemented. Resource management can be controlled automatically based on container type, application, and microservice. When setting the resource limits for a container, consider the role of the application or microservice. This requires some planning and forethought. A container running an important task, such as a database, requires substantially more resources than a microservice controlling API queries.

In production deployments, resource allocation must be planned well ahead of time and done automatically, as it is becoming the norm to constantly launch and stop containers depending on various events and factors. Managing resources by hand in production environments is out of the question.