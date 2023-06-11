<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/dps_lab_title.png?sanitize=true" width=350/>
	</p>
  <h3>demo-guestbook</h3>
	<h5>demo-team</h5>
</div>
<br />

Part of the DPS `demo` team series of applications and services. Useful in modeling pipeline architecture and the use of delivery platform resources. This example adapts the Kubernetes [guestbook-go](https://github.com/kubernetes/examples/tree/master/guestbook-go) application.  

The kubernetes guestbook app is a great application to use as a demo for focusing on deployment automation and service mesh interactions. Keep in mind, you won't find unit tests or other common continuous integration elements in this pipeline.  


** Please be patient while the chart is being deployed **

Redis&reg; can be accessed on the following DNS names from within your cluster:

    guestbook-redis-master.twdps-core-labs-team-dev.svc.cluster.local for read/write operations (port 6379)
    guestbook-redis-replicas.twdps-core-labs-team-dev.svc.cluster.local for read-only operations (port 6379)



To get your password run:

    export REDIS_PASSWORD=$(kubectl get secret --namespace twdps-core-labs-team-dev guestbook-redis -o jsonpath="{.data.redis-password}" | base64 -d)

To connect to your Redis&reg; server:

1. Run a Redis&reg; pod that you can use as a client:

   kubectl run --namespace twdps-core-labs-team-dev redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.0.11-debian-11-r12 --command -- sleep infinity

   Use the following command to attach to the pod:

   kubectl exec --tty -i redis-client \
   --namespace twdps-core-labs-team-dev -- bash

2. Connect using the Redis&reg; CLI:
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h guestbook-redis-master
   REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h guestbook-redis-replicas

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace twdps-core-labs-team-dev svc/guestbook-redis-master 6379:6379 &
    REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379





          
          
          

      
      
