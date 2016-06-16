# Openstack with Ceph 部署方案

***

## 概述

本部署方案用于指导openstack整合ceph的部署过程，并作为后续平台维护的支撑性文档。

### 基本概念
给出重要的概念，以便于理解本指南中的内容。

* provider network
> The provider networks option deploys the Openstack Networking service in the simplest way possible with primarily layer-2(bridging/switching) services and VLAN segmentation of networks, Essentially, it bridges virtual networks to physical networks and relies on physical network infrastructure for layer-3(routing) services.Additionally, a DHCP service provides IP address information to instances.

* self-service network


* 管理网络

* 外部网络




## 环境部署
本节给出部署的网络结构和各节点的编址方案。


### 主机节点配置
给出各类主机节点的配置方案。

#### 硬件需求
![硬件需求](http://i.imgur.com/S4XKcvB.png)

#### 控制节点配置要求
R910用作控制节点，

#### 计算节点配置要求
为方便统一管理和维护，本次部署计算节点全部使用R710服务器，目前R710服务器有6？个硬盘槽位，1和2号槽位做RAID1,3~6号槽位分别做RAID0,用作CEPH的OSD存储使用。

#### 存储节点配置要求
R510全部用于CEPH的OSD存储节点,所有硬盘分别做RAID0。
#### 节点配置信息列表

|主机名          |IP地址       |运行服务   |机架     |
|:-------------:|:-----------:|:--------:|:------:|
|controller     |172.31.0.11  |...       |  1     |
|compute01      |172.31.0.20  |...       |   2    |
|...            |...          |...       |   1    |

### 网络设备规划方案
鉴于openstack最新版本优化了原有的网络设计，


#### 网络拓扑
宿主机
![network layout](http://i.imgur.com/Ycbw15q.png)
## Openstack部署

### 概述

### 虚拟网络部署方案

#### 选择1：provider networking
![provider networks](http://i.imgur.com/FoXN8N4.png)

#### 选择2：self-service networking
![self-service networks](http://i.imgur.com/1K2BuFL.png)

## ceph部署

### ceph简介
TBD

### ceph部署

### glance部署

### 



