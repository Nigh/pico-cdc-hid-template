

BUILD_DIR = build

.PHONY: clean default build rebuild

default: docker_build

build:
	cmake . -G Ninja -B$(BUILD_DIR) -S.
	ninja -C $(BUILD_DIR)

clean:
	@if [ -d "./$(BUILD_DIR)" ]; then rm ./$(BUILD_DIR) -r; fi

rebuild: clean build

format:
	bash format.sh

.PHONY: docker_build
docker_build:
	docker run --rm \
	-v ${PWD}:/pico-src \
	xianii/pico-sdk:latest /bin/bash -c "cd pico-src && cmake . -G Ninja -Bbuild -S. && ninja -C build"
