#
# Makefile for K-Wrt
# Copyright (C) 2024 KWRT
#

test:
	@echo "Top dir: $(TOPDIR)"
	@echo "Test"

kwrtconfig:
	@echo "K-Wrt: config"

kwrt: kwrtconfig world
	@echo "Build K-Wrt completed!"

