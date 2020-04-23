# sdk_manager_docker

## Introduction
This is a Dockerfile to use [NVIDIA SDK Manager](https://docs.nvidia.com/sdk-manager/) on Docker container.

## Requirements
* Docker

## Prerequisites
* https://forums.developer.nvidia.com/t/jetpack-4-3-sdkmanager-ubuntu16-04-error-file-system-and-os-chroot-failed-to-run-command-mount-exec-format-error/112884/9

## Preparation
### Download NVIDIA SDK Manager
Please download the package of NVIDIA SDK Manager from <https://developer.nvidia.com/nvidia-sdk-manager>.  
And, please put the package of NVIDIA SDK Manager in the same directory as the Dockerfile.  
This time, I used `sdkmanager_1.1.0-6343_amd64.deb`.

### Build Docker image
```
$ ./create_container.sh
```

To build a Docker image with a specific SDK Manager version override the ``SDK_MANAGER_VERSION`` variable in the Docker command line

```
$ docker build --build-arg SDK_MANAGER_VERSION=1.1.0-6343 -t jetpack .
```

### Create Docker container
```
$ ./launch_container.sh
```

## Launch NVIDIA SDK Manager
Please launch NVIDIA SDK Manager by the following command.

```
$ sdkmanager
```

You need type user password during setup of NVIDIA SDK Manager.  
In [this Dockerfile](https://github.com/atinfinity/sdk_manager_docker/blob/master/Dockerfile#L75), user password is set to `jetpack`.  
So, please type `jetpack` as user password.
