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

# Build the main target
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)

# Object file compilation
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -MMD -MF $(@:.o=.d) -o $@ -c $<

# Include dependency files
-include $(OBJDIR)/*.d

.PHONY: all debug release clean
