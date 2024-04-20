.PHONY: format.all
format.all:
	@find . -type f -name '*.lua' -exec lua-format -i {} +