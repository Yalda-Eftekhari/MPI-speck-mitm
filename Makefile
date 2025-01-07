#Authors: Yalda Eftekhari and Laura Paxton
# Compiler and flags
CC = mpicc
CFLAGS = -Wall -fopenmp -lm

# Executable name
TARGET = mitm

# Source file
SRC = mitm.c

# Default values (can be overridden via command line)
NP ?= 4
n ?= 4

# Predefined run configurations
RUN_ARGS_4 = --n 4 --C0 f9bb5ad6381c95db --C1 bfdb212e064b9544
RUN_ARGS_8 =  --n 8 --C0 aede0f853ae3991b --C1 6cfab714ef791bbf
RUN_ARGS_16 = --n 16 --C0 26de6c0be3898390 --C1 84a334d5ac314818
RUN_ARGS_20 = --n 20 --C0 017ec9921b7dae7a --C1 068901c1ef08132b
RUN_ARGS_24 = --n 24 --C0 4c143361d238f251 --C1 81d8694e0ef8fdef
RUN_ARGS_25 = --n 25 --C0 0218ba08bc8a3d62 --C1 08503489026b42bb
RUN_ARGS_26 = --n 26 --C0 8a3c2ea7698e4834 --C1 458179c8b6a25485
RUN_ARGS_27 = --n 27 --C0 49cc4e0401935378 --C1 d1330883152d67a5

# Dynamic selection of RUN_ARGS based on n
RUN_ARGS = $(RUN_ARGS_$(n))

# Build target
all: $(TARGET)

# Compilation rule
$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

# Run target
run: $(TARGET)
	@if [ -z "$(RUN_ARGS)" ]; then \
		echo "Error: No RUN_ARGS defined for n=$(n)."; \
		exit 1; \
	fi
	mpirun -np $(NP) --oversubscribe ./$(TARGET) $(RUN_ARGS)

# Clean target
clean:
	rm -f $(TARGET)

# Phony targets
.PHONY: all run clean
