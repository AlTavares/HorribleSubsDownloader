.PHONY: build-docker update runm

build-docker:
	docker build --rm -f "Dockerfile" -t anime:latest .
	docker run --rm -it anime:latest

update:
	killall Xcode || true
	swift package update
	swift package generate-xcodeproj --xcconfig-overrides Anime.xcconfig
	open Anime.xcodeproj

run:
	swift build -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.14"
	.build/debug/Anime