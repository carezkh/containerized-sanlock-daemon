# Containerized Sanlock Daemon

**Containerized Sanlock Daemon** can be used to build a container image that runs [sanlock](https://pagure.io/sanlock).

The image repository: [sanlock-daemon](https://hub.docker.com/repository/docker/carezkh/sanlock-daemon).

## Prerequisite

Sanlock can clear the process within a specified time. Otherwise, the watchdog device is required to reset the host. If you do not have a hardware watchdog, you can enable `softdog` in the following ways.

```shell
cat >> /etc/rc.d/rc.local <<EOF
> /usr/sbin/modprobe softdog
> EOF

chmod +x /etc/rc.d/rc.local

modprobe softdog
```

## Guide

You can refer to the sample [daemonset-in-k8s.yaml](samples/daemonset-in-k8s.yaml) to see how to use the container image in Kubernetes.
