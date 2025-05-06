#!/bin/bash
set -e

echo "=== Установка Istio Service Mesh ==="
# предполагается, что istioctl в PATH
istioctl install --set profile=demo -y

echo "=== Включаем автоматическую инъекцию sidecar'ов в default namespace ==="
kubectl label namespace default istio-injection=enabled --overwrite

echo "=== Разворачиваем ConfigMap... ==="
kubectl apply -f k8s/configmap.yaml

echo "=== Разворачиваем тестовый Pod... ==="
kubectl apply -f k8s/pod.yaml
kubectl wait --for=condition=Ready pod/custom-app-pod --timeout=60s

echo "=== Разворачиваем Deployment... ==="
kubectl apply -f k8s/deployment.yaml
kubectl rollout status deployment/custom-app-deployment --timeout=120s

echo "=== Разворачиваем Service... ==="
kubectl apply -f k8s/service.yaml

echo "=== Разворачиваем Istio Gateway и VirtualService... ==="
kubectl apply -f k8s/istio-gateway.yaml
kubectl apply -f k8s/istio-virtualservice.yaml

echo "=== Разворачиваем DestinationRule для app-service... ==="
kubectl apply -f k8s/istio-destinationrule-app.yaml
# При наличии log-service:
# kubectl apply -f k8s/istio-destinationrule-log.yaml

echo "=== Разворачиваем DaemonSet... ==="
kubectl apply -f k8s/daemonset.yaml

echo "=== Разворачиваем CronJob... ==="
kubectl apply -f k8s/cronjob.yaml

echo "=== Развёртывание завершено! ==="

