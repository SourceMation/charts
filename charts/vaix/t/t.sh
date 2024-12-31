#!/usr/bin/env bash

NAMESPACE="test-namespace"

kubectl label namespace $NAMESPACE istio-injection=enabled --overwrite

cat <<EOF | kubectl apply -n $NAMESPACE -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpbin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: httpbin
  template:
    metadata:
      labels:
        app: httpbin
    spec:
      containers:
      - name: httpbin
        image: docker.io/kennethreitz/httpbin:latest
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /status/200
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
        livenessProbe:
          httpGet:
            path: /status/200
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 10
---
apiVersion: v1
kind: Service
metadata:
  name: httpbin
spec:
  ports:
  - port: 80
    name: http
  selector:
    app: httpbin
EOF

echo "Waiting for httpbin pod to be ready in namespace $NAMESPACE..."
kubectl rollout status deployment/httpbin -n $NAMESPACE --timeout=220s

if [ $? -ne 0 ]; then
    echo "Deployment httpbin not ready. Check pod status with: kubectl get pods -n $NAMESPACE"
    exit 1
fi

for i in {1..3}; do
  kubectl run -n ${NAMESPACE} curl-$i --rm -i --image=curlimages/curl -- \
    curl -H "x-b3-sampled: 1" \
         -H "x-b3-traceid: $(printf '%032x' $i)" \
         -H "x-b3-spanid: $(printf '%016x' $i)" \
         http://httpbin.${NAMESPACE}.svc.cluster.local/get
done

