### **Домашнее задание: Развёртывание распределённой системы логирования и хранения с резервным копированием**

## Развёртывание

1. Создаем кластер ```kind create cluster```
2. Собираем образ ```docker build -t custom-app:latest .```
3. Загружаем образ в кластер ```kind load docker-image custom-app:latest```
4. Развертывание всех необходимых манифестов ```./deploy.sh```

## Тест
1. В одном из окон ```kubectl port-forward service/custom-app-service 5000:80```
2. Далее команды ```curl http://localhost:5000/``` ```curl http://localhost:5000/status``` ```curl -X POST http://localhost:5000/log -d '{"message": "test log"}' -H "Content-Type: application/json"```
   ```curl http://localhost:5000/logs```

3. Список подов ```kubectl get pods -l app=log-agent```
4. Логи выбранного пода ```kubectl logs <pod name>```


![alt text](<Снимок экрана 2025-03-30 175334.png>)
![alt text](<Снимок экрана 2025-03-30 183843.png>)
![alt text](<Снимок экрана 2025-03-30 184314.png>)