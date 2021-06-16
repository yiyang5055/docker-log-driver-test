# Plugin parameters
PLUGIN_NAME=docker-log-driver
PLUGIN_TAG=v1

all: clean build-image create-plugin

clean:
	@echo "Removing plugin build directory"
	rm -rf ./plugin-build

build-image:
	@echo "docker build: rootfs image with the plugin"
	docker build -f Dockerfile.build -t ${PLUGIN_NAME}:rootfsimg .
	@echo "### create rootfs directory in ./plugin-build/rootfs"
	mkdir -p ./plugin-build/rootfs
	docker create --name rootfsctr ${PLUGIN_NAME}:rootfsimg
	docker export rootfsctr | tar -x -C ./plugin-build/rootfs
	@echo "### copy config.json to ./plugin-build/"
	cp config.json ./plugin-build/
	docker rm -vf rootfsctr

create-plugin:
	@echo "### remove existing plugin ${PLUGIN_NAME}:${PLUGIN_TAG} if exists"
	docker plugin rm -f ${PLUGIN_NAME}:${PLUGIN_TAG} || true
	@echo "### create new plugin ${PLUGIN_NAME}:${PLUGIN_TAG} from ./plugin-build"
	docker plugin create ${PLUGIN_NAME}:${PLUGIN_TAG} ./plugin-build
	@echo "### enable plugin ${PLUGIN_NAME}:${PLUGIN_TAG}"
	docker plugin enable ${PLUGIN_NAME}:${PLUGIN_TAG}

