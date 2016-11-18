FROM microsoft/dotnet:1.0.0-preview2-sdk

RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN apt-get update
RUN apt-get install -y curl jq

# If we are going to run as NOBODY, we have to do some things.
# #ihaveseenthings

RUN mkdir /nonexistent
RUN mkdir /nonexistent/.nuget
RUN chown -R nobody /nonexistent

ADD ./TodoApi /tmp/app
ADD ./bin/run.sh /tmp/app/bin/run.sh
RUN chmod +x /tmp/app/bin/run.sh
RUN chown -R nobody /tmp/app

USER nobody
WORKDIR /tmp/app
RUN dotnet restore
RUN dotnet build

CMD ["/tmp/app/bin/run.sh"]
