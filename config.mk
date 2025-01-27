CC = gcc
CFLAGS = -std=c89 -Wall -Wextra -Wpedantic -I$(SRCDIR)
LDLIBS = 
DEBUG_FLAGS = -ggdb
RELEASE_FLAGS = -O2

# Directories
SRCDIR = src
OBJDIR = obj

# Source and object files
SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))

TARGET = target.out
