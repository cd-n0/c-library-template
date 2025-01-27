CC = gcc
CFLAGS = -std=c89 -Wall -Wextra -Wpedantic -I$(SRCDIR)
LDLIBS = 
DEBUG_FLAGS = -ggdb
RELEASE_FLAGS = -O2

# Directories
SRCDIR = src
OBJDIR = obj
TESTDIR = tests
TESTOBJDIR = $(TESTDIR)/obj
TESTBINDIR = $(TESTDIR)/bin

# Source and object files
SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
TESTSRCS = $(wildcard $(TESTDIR)/*.c)
TESTOBJS = $(patsubst $(TESTDIR)/%.c,$(TESTOBJDIR)/%.o,$(TESTSRCS))
TESTBINS = $(patsubst $(TESTOBJDIR)/%.o,$(TESTBINDIR)/%,$(TESTOBJS))

BUILD ?= debug
ifeq ($(BUILD), debug)
	CFLAGS += $(DEBUG_FLAGS)
else ifeq ($(BUILD), release)
	CFLAGS += $(RELEASE_FLAGS)
endif

TARGET = libtarget.a
