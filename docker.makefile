build:
	docker build -t nirname/documentary .

run: build
	docker run -v "`pwd`:/project" -it nirname/documentary