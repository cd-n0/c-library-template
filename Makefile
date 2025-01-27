include config.mk

all: debug

# Debug build
debug: CFLAGS += $(DEBUG_FLAGS)
debug: $(TARGET)

# Release build
release: CFLAGS += $(RELEASE_FLAGS)
release: $(TARGET)

# Clean target to remove compiled files
clean:
	rm -rf $(OBJDIR)
	rm -f $(TARGET)
	rm -rf $(TESTOBJDIR)
	rm -rf $(TESTBINDIR)

# Build the main target
$(TARGET): $(OBJS)
	ar rcs $@ $^

# Object file compilation
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -MMD -MF $(@:.o=.d) -o $@ -c $<

# Include dependency files
-include $(OBJDIR)/*.d

$(TESTOBJDIR):
	@mkdir $@

$(TESTBINDIR):
	@mkdir $@

# TODO: Find a way to compile and link all C++ file extensions for tests
# (cpp, cxx, cc, cp, C)
# Rule to compile test objects
$(TESTOBJDIR)/%.o: $(TESTDIR)/%.c | $(TESTOBJDIR)
	$(CC) $(CFLAGS) -o $@ -c $<

# Build test binaries from object files
$(TESTBINDIR)/%: $(TESTOBJDIR)/%.o | $(TESTBINDIR) $(TARGET)
	$(CC) $(CFLAGS) -o $@ $< $(TARGET) $(LDLIBS)

# Run all tests
test: $(TESTBINS)
	@echo "Running tests..."
	@for test in $^; do \
		echo "Running $$test..."; \
		./$$test && echo "TEST $$test OK" || echo "TEST $$test FAIL"; \
	done

.PHONY: all debug release clean
