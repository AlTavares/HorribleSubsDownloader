FROM swift:4.2

WORKDIR /swift/app
COPY . .

RUN apt-get update && apt-get install libxml2-dev -y
RUN swift build

CMD .build/debug/Anime