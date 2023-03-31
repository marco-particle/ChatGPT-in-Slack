FROM python:3.11.2-slim-buster as builder
COPY requirements.txt /build/
WORKDIR /build/
RUN pip install -U pip && pip install -r requirements.txt

FROM python:3.11.2-slim-buster as app
WORKDIR /app/
COPY *.py /app/
RUN mkdir /app/app/
COPY app/*.py /app/app/
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /usr/local/lib/ /usr/local/lib/
ENTRYPOINT python main.py

# docker build . -t marco-particle/chat-gpt-in-slack
# export SLACK_APP_TOKEN=
# export SLACK_BOT_TOKEN=
# export OPENAI_API_KEY=
# docker run -e SLACK_APP_TOKEN=$SLACK_APP_TOKEN -e SLACK_BOT_TOKEN=$SLACK_BOT_TOKEN -e OPENAI_API_KEY=$OPENAI_API_KEY -it marco-particle/chat-gpt-in-slack
