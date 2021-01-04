docker build -t ihorberda/multi-client:latest -t ihorberda/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ihorberda/multi-server:latest -t ihorberda/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ihorberda/multi-worker:latest -t ihorberda/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ihorberda/multi-client:latest
docker push ihorberda/multi-server:latest
docker push ihorberda/multi-worker:latest
docker push ihorberda/multi-client:$SHA
docker push ihorberda/multi-server:$SHA
docker push ihorberda/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ihorberda/multi-client:$SHA
kubectl set image deployments/server-deployment server=ihorberda/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ihorberda/multi-worker:$SHA
