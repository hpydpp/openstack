# Openstack介绍

## Openstac概述
### Openstack是什么？
关于OpenStack是什么呢？可以理解为： **目前最流行的开源云管理平台。**

- **资源抽象**
1. OpenStack将各类硬件资源，通过虚拟化与软件定义的方式，抽象成资源池资源分配与负载调度；
2. OpenStack根据管理员/用户的需求，将资源池中的资源分配给不同的用户，承载不同应用。

- **应用生命周期管理**
OpenStack已经可以提供初步的应用部署/撤除、自动规模调整能力。

- **系统运维**
OpenStack已经可以提供一定的系统监控能力。

- **人机交互**
OpenStack提供人机接口，外界可以通过API、命令行或图形界面的方式与OpenStack进行交互。

### Openstack不是什么
1. **Openstack不是虚拟化**
OpenStack只是系统的控制面，OpenStack不包括系统的数据面组件，如hypervisor、存储和网络设备等。
之前也有朋友咨询：云计算和虚拟化的区别是什么？
![](http://i.imgur.com/dtQIUrv.jpg)
通过上图可以看到：虚拟化是实现云计算的技术支撑手段之一，并不代表整个云计算，只是实现的手段之一而已。

2. **Openstack不是云**
OpenStack只是构建云的关键组件，可以理解为：内核、骨干、框架、总线；为了构建一个云，还需要很多东西……
![](http://i.imgur.com/k36xkeQ.jpg)

### Openstack基本设计思想

1. **开放**
- 开源，尽最大可能重用已有开源项目；
- 不要“重复发明轮子”，而要“站在巨人肩膀上”。
2. **灵活**
- 不使用任何不可替代的私有/商业组件；
- 大量使用插件化方式进行架构设计与实现。
3. **可扩展**
- 由多个相互独立的项目组成；
- 每个项目包含多个独立服务组件；
- 无中心架构；
- 无状态架构。


### Openstack开发介绍
每年发布两个大版本，分别在4月和10月中旬发布；约70%的代码（核心逻辑）使用Python开发；License使用Apache 2.0 License，商业友好。
**OpenStack社区：**
 http://www.openstack.org/
**OpenStack中文社区:** 
http://www.openstack.cn/

## Openstack服务有哪些
###Openstack服务
OpenStack的常见服务有Nova、Swift、Glance、Keystone、Neutron、Cinder、Horizon、Ceilometer、Heat、Trove、TripleO、Sahara。
这些服务中，我们先简要描述Nova、Swift和Glance这三个服务之间的藕断丝连。然后着重介绍下Nova服务，OpenStack的骨干，后续再介绍其他充当血液角色的服务。
关于Nova、Swift和Glance的主要作用，如图所示。
![](http://i.imgur.com/M4VcPTh.jpg)
图中英文较多，我们快速解读一下：
Compute（计算服务）：它叫做Nova，主要的作用是管理虚拟机实例的整个生命周期，根据用户需求来提供虚拟服务。有一点非常重要， OpenStack是不提供虚拟化能力的，而是通过与虚拟化资源层（比如KVM、Xen等）交互，从而对虚拟资源层进行管理。
Image Service（镜像管理服务）：它叫做Glance。镜像服务器是一套虚拟机镜像发现、注册、检索系统，但它不提供镜像文件的存储功能。通常情况下，我们将镜像存储在OpenStack的对象存储节点中。
Object Storage（对象存储服务）：它叫做Swift。Swift是对象存储服务，存储数量到一定级别，而且是非结构化数据，通常才会有使用对象存储的需求。镜像文件通常存储在Swift中。

### Openstack核心服务之Nova
#### Nova概述
1. Nova是什么？ 
- OpenStack中提供计算资源服务的项目。
2. Nova负责什么？ 
- 虚拟机生命周期管理 。
- 其他计算资源生命周期管理 。
3. Nova不负责什么？ 
- 承载虚拟机的物理主机自身的管理 。
- 全面的系统状态监控 。
4. Nova是OpenStack最核心的项目 
- 历史最长：OpenStack首批两个项目之一 。
- 功能最复杂，代码量最大 。
- 大部分集成项目和Nova之间都存在配合关系 。
- 贡献者在社区中的影响力最大 。
5. Nova在OpenStack中的位置
![](http://i.imgur.com/1VPI1lC.jpg)

#### Nova管理下的资源类型
主要资源：虚拟机
- KVM 
- Xen
- Hyper-V
- vCenter/vSphere

其它资源
- 物理机：通过Ironic
- 容器：LXC、Docker

#### Nova逻辑架构 -- KVM场景
![](http://i.imgur.com/wbNYi2y.jpg)

|模块            |功能                     |一般部署位置     |
|:--------------|:------------------------|:---------------|
|nova-api       |接受REST消息              |控制节点
|nova-scheduler |选择合适的主机             |控制节点
|nova-conductor |数据库操作和复杂流程控制    |控制节点
|nova-compute   |虚拟机生命周期管理和资源管理 |计算节点
#### NOVA系统架构
![](http://i.imgur.com/9OF2wtL.jpg)
1. 基于消息队列的架构。 
2. 使用延缓对象，回调函数避免组件通信阻塞。
3. 可以容易的水平扩展，使用于大规模的部署。
*说明：该框架使用的网络为neutron组件， 而不是传统的nova-network。*

### Openstack服务概览
除上述服务之外，还有以下服务，如下表所示：

|序号|类型           |名称      |作用       |
|---|--------------|----------|----------|
|1  |鉴权服务       |Keystone  |为Openstack其他服务提供身份验证、服务规则和服务令牌的功能。
|2  |网络&地址管理  | Neutron   |提供云计算的网络虚拟化技术，为虚拟机提供网络连接服务，以及其他如VPN、防火墙等服务
|3  |块存储        | Cinder    |为运行实例提供稳定的数据块存储服务，如创建卷、删除卷，在实例上挂载和卸载卷。
|4  |UI界面        | Horizon   |Openstack中各种服务的Web管理门户，从而使用户对服务的操作变得更直观、易用。
|5  |计量          | Ceilometer|能把Openstack内部发生的几乎所胡的事件收集起来，然后为计费、监控以及其它服务提供数据支撑。
|6  |部署编排       | Heat      |提供了一种通过模板定义的协同部署方式，实现去基础设施软件运行环境（计算、存储和网络资源）的自动化部署。
|7  |数据库服务     | Trove     |为用户在Openstack的环境提供可扩展和可靠的关系和非关系数据库引擎服务。即实现把数据库当成服务提供给用户的功能。
|8  |自动部署       | TripleO   |用于行货部署Openstack，并实现管理和更新，能够使Openstack更加容易部署和管理。
|9  |部署Hadoop    | Sahara    |通过该服务，可以简单便捷地部署Hadoop集群。



## RabbitMQ

### 什么是RabbitMQ

1. RabbitMQ是一种MQ，意为像兔子一样快的MQ。
![rabbitmq](http://i.imgur.com/OcKSdAT.jpg)

2. MQ全称为Message Queue，应用程序通过读写出入队列的消息（针对应用程序的数据）来通信，而无需专用连接来链接它们。

![mq](http://i.imgur.com/fFemBa6.jpg)

- 健壮的message（可靠性、灵活的routing、集群）。
- 使用简单。
- 支持所有主流操作系统：windows、linux…
- 支持大量的平台：java、python、.net …
- 开源和商业支持。

### RabbitMQ的工作流程
首先通过一个例子说明MQ的工作流程。
两个小学生毕业以后没有分到同一所中学，两个人只能通过邮件方式通信。

1. 小女孩通过邮箱寄出信封  ---  生产者通过RabbitMQ的客户端发布了一条消息。
2. 邮局  ---  RabbitMQ的交换机Exchange。
3. 小男孩  ---  消费者。
4. 信封的地址  ---  RabbitMQ的Route Key。
5. 信的内容  ---  RabbitMQ消息内容。
6. 邮递员  ---  RabbitMQ的队列Queue，邮局雇佣很多邮递员，每个邮递员负责指定区域的邮件推送，RabbitMQ的交换机会绑定很多队列，每个队列负责推送消息给指定消费者。

![rabbitmq-server](http://i.imgur.com/9xgwYwa.jpg)

说明：
1. 左边的ClientA，ClientB是生产者，右边的Client1，Client2，Client3 是消费者，左右两边都是Rabbitmq Client，中间部分是Rabbitmq Server。
2. 生产者通过Rabbitmq Server将消息发送给消费者。
3. Rabbitmq Server通过Route Key将Exchange和Queue绑定在一起，其中Route Key在发送消息时候指定，通过该标识Rabbitmq Server就可以将消息通过指定的队列推送给消费者。

### RabbitMQ中的基本概念

|概念名称      |说明                                                   |
|:-----------:|:------------------------------------------------------|
|Exchange     |消息交换机，这指定消息按什么规则，路由到哪个队列。             |
|Queue        |消息队列载体，每个消息都会被投入到一个或多个队列。            |
|Binding      |绑定，它的作用就是把exchange和queue按照路由规则绑定起来。    |
|Routing Key  |路由关键字，exchange根据这个关键字进行消息投递。             |
|Producer     |消息生产者，就是投递消息的程序。                             |
|Consumer     |消息消费者，就是接受消息的程序。                             |
|Connection   |就是一个TCP的连接。Producer和Consumer都是通过TCP连接到RabbitMQ Server的。|
|Channel      |消息通道，是在TCP连接中的虚拟连接，在客户端的每个TCP连接里，可建立多个channel，每个channel代表一个传话任务。|



## Keystone

### Keystone基本介绍

- OpenStack的核心组件，提供认证鉴权服务。
- 社区主要玩家：IBM、Rackspace、Red Hat、HP（PTL所属公司）、CERN、Huawei等。
- 已经衍生出了很多子项目：keystone-specs、python-keystoneclient、keystonemiddleware、pycadf、python-keystone-kerberos、python-keystoneclient-federation。

### Keystone的对象模型

|对象         |对象说明                                 |
|:--------- :|:--------------------------------------|
|Domain      |域，keystone中资源(project,user,group)的持有者。
|Project     |租户，其他组件中资源（虚拟机、镜像）的持有者。
|User        |用户，云系统的使用者。
|Group       |用户组，可以把多个用户作为一个整体进行角色管理。
|Role        |角色，基于角色进行访问控制。
|Trust       |委托，把自己拥有的角色临时授权给别人。
|Service     |服务，一组相关功能的集合，比如计算服务、网络服务、镜像服务、存储服务等。
|Endpoint    |必须和一个服务关联，代表这个服务的访问地址，一般一个服务需要提供三种类型的访问地址：public、internal、admin。
|Region      |区域，在keystone里基本代表一个数据中心。
|Policy      |访问控制策略，定义接口访问控制规则。
|Assignment  |一个(actor,target,role)三元组叫一个assignment,actor或user,group,target包括domain,project。每个assignment代表一次赋权操作。
|Token       |令牌，用户访问服务的凭证，代表着用户的账户信息，一般需要包含user信息、scope信息(project,domain或者trust)，role信息。

**几个对象模型理解的误区：**

- 租户是个虚拟的概念，同国家、公司等虚拟概念差不多的意思。
- 用户才是代表一个人，用户可以在租户内有角色，但是不能说用户属于某个租户，实际上用户可以在多个租户内有角色，而且可以有不同的角色。
- 用户和租户的纽带是assignment，可以把assignment理解成各种卡证，根据角色进行访问控制就可以映射成进办公区时刷卡确认权限。所以独立的用户、租户、角色没有任何意义，有assignment之后才产生意义。
- Token分为unscoped_token和scoped_token两种，unscoped_token就是没有选定作用范围（某个project或domain）的token，而没有范围时就没有角色，所以这种token不携带角色信息，是不能访问其他服务的。
- 用户、租户、用户组都必须属于一个domain，只有domain的管理员才能在该domain中创建用户、租户、用户组这些资源，外部组件应该只知道租户。

### Keystone的职责
- 为用户提供系统的统一入口，并提供service_catalog功能。

![keystone职责](http://i.imgur.com/9JR4JwJ.jpg)

- 为OpenStack各组件提供基于token的认证框架，基于角色的访问控制框架（RBAC）。

- 提供更加灵活、方便、丰富的权限管理功能。

- 集成更多的第三方认证方式及兼容更多的认证协议。



### Keystone的架构

![keystone架构](http://i.imgur.com/cAb5x47.png)

- Router定义url到controller的映射关系。
- Controller进行参数、权限校验，处理和http请求相关的事情，比如从http请求中取到filters、组织响应数据等。
- Manager处理业务逻辑，发送cadf广播。
- Driver是不同存储后端的实现。


