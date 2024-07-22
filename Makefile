help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

test:
	@echo "-> Testing hive_built_value"
	cd hive_built_value && dart test test/

	@echo "-> Testing hive_built_value_flutter"
	cd hive_built_value_flutter && dart test test/

	@echo "-> Testing hive_built_value_generator"
	cd hive_built_value_generator && dart test test/
	cd hive_built_value_generator && dart build_runner test
