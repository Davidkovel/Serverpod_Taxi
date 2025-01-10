FROM cirrusci/flutter:stable

# Добавление нового пользователя
RUN useradd -ms /bin/bash flutteruser

# Используем пользователя flutteruser
USER flutteruser

# Добавляем безопасную директорию для Git
RUN git config --global --add safe.directory /sdks/flutter

WORKDIR /app
COPY . .

RUN flutter pub get

CMD ["flutter", "run"]
