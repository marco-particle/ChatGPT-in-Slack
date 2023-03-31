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
# export SLACK_APP_TOKEN=xapp-1-A051AHCD93L-5041719655909-2e36d23fe397f5c84ac119e59e0c57a57ee225906e06b2e1900c7df612a11c25
# export SLACK_BOT_TOKEN=xoxb-2152987045-5057217975777-nsM9qXGT1OrvjIXZXazIIzB9
# export OPENAI_API_KEY=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
# docker run -e SLACK_APP_TOKEN=$SLACK_APP_TOKEN -e SLACK_BOT_TOKEN=$SLACK_BOT_TOKEN -e OPENAI_API_KEY=$OPENAI_API_KEY -it marco-particle/chat-gpt-in-slack
