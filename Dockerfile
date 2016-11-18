FROM microsoft/dotnet:1.0.0-preview2-sdk

RUN apt-get update
RUN apt-get install -y curl jq

ADD ./TodoApi /app
WORKDIR /app
RUN dotnet restore
RUN dotnet build

ADD ./bin/run.sh /app/bin/run.sh
RUN chmod +x /app/bin/run.sh
CMD ["/app/bin/run.sh"]
