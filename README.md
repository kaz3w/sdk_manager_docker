# sdk_manager_docker

## Introduction
This is a Dockerfile to use [NVIDIA SDK Manager](https://docs.nvidia.com/sdk-manager/) on Docker container.

## Requirements
* Docker

## Preparation
### Download NVIDIA SDK Manager
This time, I used `sdkmanager_1.1.0-6343_amd64.deb` for installation.
Otherwise (if you want to use other specific version of SDK Manager), please download the package of NVIDIA SDK Manager from <https://developer.nvidia.com/nvidia-sdk-manager> and, put the package of NVIDIA SDK Manager in the same directory as the Dockerfile.

### Build Docker image
```
$ ./create_container.sh
```

To build a Docker image with a specific SDK Manager version(e.g.1.x.y-nnnn) override the ``SDK_MANAGER_VERSION`` variable in the Docker command line

```
$ docker build --build-arg SDK_MANAGER_VERSION=1.x.y-nnnn -t jetpack .
```

or update ARG SDK_MANAGER_VERSION in [Dockerfile](https://github.com/kaz3w/sdk_manager_docker/blob/master/Dockerfile#L4) (Line:4).
```
ARG SDK_MANAGER_VERSION=1.x.y-nnnn
```
### if, under the proxy/firewall enviroment

To build a Docker image under the proxy environment,  override the ``http_proxy`` variable in the Docker command line

```
$ docker build --build-arg http_proxy=http://PROXY_IP:PROXY_PORTn -t jetpack .
```

or update ARG http_proxy in [Dockerfile](https://github.com/kaz3w/sdk_manager_docker/blob/master/Dockerfile#L8) (Line:8).
```
ARG http_proxy=http://PROXY_IP:PROXY_PORT
```


### Launch Docker container
```
$ ./launch_container.sh
```

## Launch NVIDIA SDK Manager
Please launch NVIDIA SDK Manager by the following command.

```
$ sdkmanager
```

You need type user password during setup of NVIDIA SDK Manager.  
In [this Dockerfile](https://github.com/kaz3w/sdk_manager_docker/blob/master/Dockerfile#L116), user password is set to `jetpack`.  
So, please type `jetpack` as user password.
