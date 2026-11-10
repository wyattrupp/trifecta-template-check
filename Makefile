# The toolchain is the trifecta package, pinned with every dependency in the hashed lock.
PY ?= python3

.PHONY: setup vale check clean

setup:
	$(PY) -m pip install --require-hashes -r requirements.lock
	$(PY) -m trifecta setup --vale-only

vale:
	$(PY) -m trifecta setup --vale-only

## check: run the pipeline. Set BASE=<git ref> to also check history against a ref.
check: vale
	$(PY) -m trifecta check $(if $(BASE),--base $(BASE))

clean:
	rm -rf docs/_build
