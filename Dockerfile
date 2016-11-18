FROM microsoft/dotnet:1.0.0-preview2-sdk

RUN apt-get update
RUN apt-get install -y curl jq lsof

ADD ./TodoApi /tmp/app

WORKDIR /tmp/app
RUN dotnet restore
RUN dotnet build

ADD ./bin/run.sh /tmp/app/bin/run.sh
RUN chmod +x /tmp/app/bin/run.sh

CMD ["/tmp/app/bin/run.sh"]
