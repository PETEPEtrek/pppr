### **Домашнее задание 2 - добавляем в проект istio**

## Развёртывание

1. Создаем кластер ```kind create cluster```
2. Собираем образ ```docker build -t custom-app:latest .```
3. Загружаем образ в кластер ```kind load docker-image custom-app:latest```
4. Развертывание всех необходимых манифестов ```./deploy.sh```

## Тест
1. В одном из окон istio gateway ```kubectl -n istio-system port-forward svc/istio-ingressgateway 8080:80```
2. Далее команды ```curl http://localhost:8080/``` ```curl http://localhost:8080/status``` ```curl -i -X POST http://localhost:8080/log -H "Content-Type: application/json" -d '{"message":"hi"}'```
   ```curl http://localhost:8080/logs```
   ```curl -i http://localhost:8080/wrong``` - для 404

3. Список подов ```kubectl get pods -l app=log-agent```
4. Логи выбранного пода ```kubectl logs <pod name>```
5. Fault-injection + timeout + retry - ```time curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:8080/log -H "Content-Type: application/json" -d '{"message":"x"}'``` - Должен вернуть 504 и занять ~2с


![alt text](<Снимок экрана 2025-05-06 213623.png>)
 ![alt text](<Снимок экрана 2025-05-06 213633.png>)