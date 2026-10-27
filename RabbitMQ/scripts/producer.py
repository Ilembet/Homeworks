import pika

HOST = "10.0.2.3"   # IP ноды с RabbitMQ (вместо localhost)
QUEUE = "hello"
MESSAGE = "Hello Netology!"

credentials = pika.PlainCredentials("admin", "admin")
connection = pika.BlockingConnection(
    pika.ConnectionParameters(host=HOST, credentials=credentials)
)
channel = connection.channel()

channel.queue_declare(queue=QUEUE)
channel.basic_publish(exchange="", routing_key=QUEUE, body=MESSAGE)
print(f" [x] Sent '{MESSAGE}' to queue '{QUEUE}' on {HOST}")

connection.close()
