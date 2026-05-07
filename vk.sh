#!/bin/bash

vk_token="vk1.a.xxx" #Здесь пишем полученный в VK токен
chat_id="2000000001" #Это id чата
ns=$(curl -s "https://jug8000.99ns.ru/sgv.json?count=1") #Тут адрес вашего Nightscout
sgv=`echo "$ns" | jq '.[0].sgv'`
date=`echo "$ns" | jq '.[0].dateString'`
mmol=$(bc<<<"scale=1;$sgv/18")
message="Test: $mmol в $date"
echo $message

response=$(curl -X POST "https://api.vk.com/method/messages.send" \
      --data-urlencode "access_token=$vk_token" \
      --data-urlencode "v=5.199" \
      --data-urlencode "peer_id=$chat_id" \
      --data-urlencode "random_id=0" \
      --data-urlencode "message=$message")

  if [ -z "$response" ]; then
      echo "Ошибка отправки VK: Пустой ответ сервера, проверьте подключение к интернету."
  fi

  if echo "$response" | jq -e '.response' >/dev/null 2>&1; then
      echo "Сообщение отправлено VK."
  else
      echo "Ошибка отправки VK: $response"
  fi
