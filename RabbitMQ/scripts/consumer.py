import pika

HOST = "10.0.2.3"   # для проверки отказа ноды — 10.0.2.4 (rmq02)
QUEUE = "hello"

credentials = pika.PlainCredentials("admin", "admin")
connection = pika.BlockingConnection(
    pika.ConnectionParameters(host=HOST, credentials=credentials)
)
channel = connection.channel()

channel.queue_declare(queue=QUEUE)


def callback(ch, method, properties, body):
    print(f" [x] Received {body.decode()}")


channel.basic_consume(queue=QUEUE, on_message_callback=callback, auto_ack=True)
print(f" [*] Waiting for messages from {HOST}. To exit press CTRL+C")
channel.start_consuming()
