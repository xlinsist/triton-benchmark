# 设置项目路径
BUILD_DIR := build

# 进入 build 目录，清理 CMake 缓存
clean:
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && rm -rf CMakeFiles CMakeCache.txt

# 运行 CMake 重新生成 Makefile
configure:
	@cd $(BUILD_DIR) && cmake ..

# 运行 make 进行编译
build:
	@cd $(BUILD_DIR) && make -j$(nproc)

run:
	@cd $(BUILD_DIR) && ./spike_test

# 一键清理 + 重新配置 + 编译
all: clean configure build

.PHONY: all clean configure build rebuild
