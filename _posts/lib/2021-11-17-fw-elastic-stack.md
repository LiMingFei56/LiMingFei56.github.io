---
layout: post
title: "Elastic Stack"
categories: framework
tags: [framework]
date: 2021-11-17
---

## Elastic Stack

Filebeat + kafka + Logstash + Elasticsearch + Kibana

		curl ip.sb
		netstat -natp | grep 5601

### filebeat

#### install

		curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.15.2-x86_64.rpm
		sudo rpm -vi filebeat-7.15.2-x86_64.rpm

### elastic search

#### install

		wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-x86_64.rpm
		wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.2-x86_64.rpm.sha512
		shasum -a 512 -c elasticsearch-7.15.2-x86_64.rpm.sha512
		sudo rpm --install elasticsearch-7.15.2-x86_64.rpm

		sudo /bin/systemctl daemon-reload
		sudo /bin/systemctl enable elasticsearch.service

		sudo systemctl start elasticsearch.service
		sudo systemctl stop elasticsearch.service

		# 配置
		vim /etc/elasticsearch/elasticsearch.yml
		cluster.name: eolog-es                 # 集群名称
		node.name: eolog-es-m                  # 节点名称
		path.data: /var/lib/elasticsearch      # 数据保存路径
		path.logs: /var/log/elasticsearch      # 日志保存路径
		network.host: 0.0.0.0                  # 默认监听本地所有ip地址
		http.port: 9200                        # 端口
		discovery.seed_hosts: ["172.17.10.31"] # 集群列表
		cluster.initial_master_nodes: ["eolog-es-m"] # 节点名称

#### problem1: failed; error='Not enough space'

		sudo vim /etc/elasticsearch/jvm.options.d/mymem.options
		# add below 
		-Xms1g
		-Xmx1g

#### command

		curl -H "Content-Type: application/json" -XPOST 'http://192.168.32.137:9200/system-syslog-20181129/system-syslog' -d '{"first_name":"yuan","last_name":"mu","age":88,"about":"I love to wo qu","interests":["sport","huangya"]}'

#### 跨域问题

> No 'Access-Control-Allow-Origin' header is present on the requested resource. 

	elastichsearch.yml	
	#allow origin
	http.cors.enabled: true
	http.cors.allow-or

### kibana

#### install 

		wget https://artifacts.elastic.co/downloads/kibana/kibana-7.15.2-x86_64.rpm
		shasum -a 512 kibana-7.15.2-x86_64.rpm 
		sudo rpm --install kibana-7.15.2-x86_64.rpm

		sudo /bin/systemctl daemon-reload
		sudo /bin/systemctl enable kibana.service

		sudo systemctl start kibana.service
		sudo systemctl stop kibana.service

		# 配置
		vim /etc/kibana/kibana.yml
		server.port: 5601                    # 端口
		server.host: "172.17.10.31"          # 地址
		server.publicBaseUrl: "http://172.17.10.31:5601" # 访问地址
		server.maxPayload: 1048576          # 最大负载
		server.name: "eolog-kibana"         # 服务名称
		kibana.index: ".kibana"             # 索引名
		i18n.locale: "zh-CN"                # 汉化

### logstash

		wget https://artifacts.elastic.co/downloads/logstash/logstash-oss-7.15.2-x86_64.rpm
		sudo rpm --install logstash-oss-7.15.2-x86_64.rpm 

		bin/logstash -f logstash.conf

		vim /etc/logstash/conf.d/apache.conf

		# Test
		sudo bin/logstash --config.test_and_exit -f <path_to_config_file>
		sudo bin/logstash --debug -f <path_to_config_file>

		# 启动
		nohup /usr/share/logstash/bin/logstash --path.settings /etc/logstash/ -f /etc/logstash/conf.d/kafka_os_into_es.conf &

#### 配置文件

> logstash/conf.d/ 目录下的文件, 运行时会合并成一个, 所以需要处理冲突

1. 过滤不需要的日志

		filter {
				if ([message]=~ "^Retrieved hosts from InstanceDiscovery: 0") {
						drop{}
				}
		}

2. 分发到不同索引

		output {
			 if [type] == "infolog" {
				 elasticsearch {
						hosts => ["test:9200"]
						index => "infolog-%{+YYYY.MM.dd}"
				}
			 } else if [type] == "errlog" {
				 elasticsearch {
						hosts => ["test:9200"]
						index => "errlog-%{+YYYY.MM.dd}"
				}
			 }

		}

#### grok

		/usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/logstash-patterns-core-4.3.1/patterns/ecs-v1/grok-patterns 

### zookeeper

		wget https://dlcdn.apache.org/zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0-bin.tar.gz:wq

		# 安装
		rpm -ivh jdk-8u181-linux-x64.rpm
		tar  -xvf zookeeper-3.4.14.tar.gz -C /usr/local/
		mv /usr/local/zookeeper-3.4.14/ /usr/local/zookeeper
		cp /usr/local/zookeeper/conf/zoo_sample.cfg  /usr/local/zookeeper/conf/zoo.cfg
		mkdir /usr/local/zookeeper/data
		echo 1 >> /usr/local/zookeeper/data/myid     #三台机器分别对应写入，123

		# 修改配置
		vim /usr/local/zookeeper/conf/zoo.cfg 
		tickTime=2000
		initLimit=10
		syncLimit=5
		dataDir=/usr/local/zookeeper/data
		clientPort=2181
		server.1=192.168.113.101:2888:3888
		server.2=192.168.113.102:2888:3888
		server.3=192.168.113.103:2888:3888

		# 启动
		/usr/local/zookeeper/bin/zkServer.sh start
		jps #查看进程


### kafka

		wget https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz

		# 安装
		tar -xvf kafka_2.11-2.1.1.tgz  -C /usr/local/
		mv /usr/local/kafka_2.11-2.1.1/ /usr/local/kafka
		mkdir /usr/local/kafka/logs

		#重点修改以下几项
		vim /usr/local/kafka/config/server.properties
		broker.id=1                                         #根据节点数依次更改       
		listeners=PLAINTEXT://192.168.113.101:9092          #kafka的监听地址与端口
		log.dirs=/usr/local/kafka/logs
		num.partitions=6                                    #设置新创建的topic有多少个分区
		log.retention.hours=60                              #配置kafka中消息保存的时间
		log.segment.bytes=1073741824                        #partition中每个segment数据文件的大小          zookeeper.connect=192.168.113.101:2181,192.168.113.102:2181,192.168.113.103:2181   #zookeeper所在的地址      
		auto.create.topics.enable=true                      #设置是否自动创建topic
		delete.topic.enable=true                            #Kafka提供了删除topic的功能，但是默认并不会直接将topic数据物理删除。如果要从物理上删除（即删除topic后，数据文件也会一同删除），就需要设置此配置项为true
		zookeeper.connect=172.17.10.31:2181
		zookeeper.connection.timeout.ms=18000

		# 启动
		nohup /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties >/dev/null 2>&1 &
		jps #查看进程

		# 常用命令
		/usr/local/kafka/bin/kafka-topics.sh --list --bootstrap-server 172.17.10.34:9092
		/usr/local/kafka/bin/kafka-topics.sh --create --bootstrap-server 172.17.10.34:9092 --replication-factor 1 --partitions 1 --topic equickorderlog

		# 查看消费情况
		bin/kafka-consumer-groups.sh --bootstrap-server kafka-1.default.svc.cluster.local:9092 --list
		bin/kafka-consumer-groups.sh --describe --bootstrap-server kafka-1.default.svc.cluster.local:9092 --group usercenter

		# 查看topic情况
		/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server 172.17.10.34:9092 --list
		/usr/local/kafka/bin/kafka-topics.sh --describe --bootstrap-server 172.17.10.34:9092 --topic eologorder
		# 删除topic
		/usr/local/kafka/bin/kafka-topics.sh --delete --bootstrap-server 172.17.10.34:9092 --topic eologorder
		# 启动消费者
		/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server 172.17.10.34:9092 --topic eologorder --from-beginning


### 删除旧日志
[Remove or delete old data from elastic search](https://stackoverflow.com/questions/34170025/remove-or-delete-old-data-from-elastic-search)
[Delete old data from an Index](https://discuss.elastic.co/t/delete-old-data-from-an-index/92412)


### Reference
[Overview](https://www.elastic.co/guide/index.html)
[Advanced configurationedit](https://www.elastic.co/guide/en/elasticsearch/reference/master/advanced-configuration.html#set-jvm-heap-size)
[ELK+Kafka+Filebeat搭建日志系统](https://blog.51cto.com/u_13950323/2502774)
