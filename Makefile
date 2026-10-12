# Define the default shell
SHELL := /bin/bash

.PHONY: help install dev run clean format lint

## help: Show this help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/## //'

## install: Install all project dependencies using uv
install:
	uv sync

## run: Run the production FastAPI server
run:
	uv run uvicorn main:app --reload

## cli: Run the CLI tool through uv (make cli cmd=summary|debug)
cmd ?= summary
cli:
	uv run python cli.py $(cmd)

## format: Format the codebase using uv's built-in ruff formatter
format:
	uv run ruff format .

## lint: Lint the codebase using uv's built-in ruff linter
lint:
	uv run ruff check .

## clean: Remove cached Python and build directories
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
