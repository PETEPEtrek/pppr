#!/bin/bash
set -e

echo "Разворачиваем ConfigMap..."
kubectl apply -f k8s/configmap.yaml

echo "Разворачиваем тестовый Pod..."
kubectl apply -f k8s/pod.yaml

echo "Ожидание готовности Pod..."
kubectl wait --for=condition=Ready pod/custom-app-pod --timeout=60s

echo "Разворачиваем Deployment..."
kubectl apply -f k8s/deployment.yaml

echo "Ожидание готовности Deployment..."
kubectl rollout status deployment/custom-app-deployment --timeout=120s

echo "Разворачиваем Service..."
kubectl apply -f k8s/service.yaml

echo "Разворачиваем DaemonSet..."
kubectl apply -f k8s/daemonset.yaml

echo "Разворачиваем CronJob..."
kubectl apply -f k8s/cronjob.yaml

echo "Развёртывание завершено!"

