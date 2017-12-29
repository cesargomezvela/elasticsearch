# ElasticSearch cluster deployment on kubernetes

2017-12-29

> The present project is based on the work of **Paulo Pires**, thus is highly recommended to review his project and his documentation at https://github.com/pires/kubernetes-elasticsearch-cluster also because I do not provide the entire documentation. The Paulo Pires documentation applies to this project too.



### Advantages in this project

* **Support for X-Pack plugin:** At this moment the image that Paulo Pires uses does not support X-Pack.
* **Support for default plugins:** At this moment the image that Paulo Pires uses is very minimalist. He disabled the default plugins, but this project does not.
* **A new Dockerfile is created based in the official** image `docker.elastic.co/elasticsearch/elasticsearch:6.1.1`, thus it can be easier to migrate to a new elasticsearch version.


### Disadvantages

* I am not incorporating the ability of SHARD_ALLOCATION_AWARENESS because it is not necessary for my needs, but you can incorporate it easily review the Paulo documentation https://github.com/pires/docker-elasticsearch#environment-variables


### NOTES

* At this moment I am not implementing the version Statefulset for k8s 
* I Added a new environment variable `${LICENSE}` inside elasticsearch.yml to support self_generated license at this moment if you no provide your own the default is basic.
* The image is created to work with kubernetes but if you want to execute it with `docker run`, you must comment the `ENV DISCOVERY_SERVICE elasticsearch-discovery` inside docker file visit https://github.com/pires/docker-elasticsearch to see how to run it.

### Deploy

###### Docker Image

```SHELL
cd docker
docker build --tag=k8s/elasticsearch:6.1.1 .
```

###### kubernetes

```SHELL
cd kubernetes
kubectl create -f elasticsearch-discovery-svc.yaml
kubectl create -f elasticsearch-svc.yaml
kubectl create -f elasticsearch-master.yaml
kubectl rollout status -f elasticsearch-master.yaml
kubectl create -f elasticsearch-client.yaml
kubectl rollout status -f elasticsearch-client.yaml
kubectl create -f elasticsearch-data.yaml
kubectl rollout status -f elasticsearch-data.yaml
```

Follow the Paulo Pires documentation to Test It
