.ONESHELL:

alpha:
	./node_modules/.bin/granary client - import secret key activator unencrypted:edsk31vznjHSSpGExDMHYASz45VZqXN4DPxvsa4hAyY8dHM28cZzp6 --force
	./node_modules/.bin/granary client - activate protocol Pt24m4xiPbLDhVgVfABUjirbmda3yohdN82Sp9FeuAXJ4eV9otd with fitness 1 and key activator and parameters $(PWD)/protocol_parameters.json --timestamp `TZ='AAA+1' date +%FT%TZ`
	./node_modules/.bin/granary client - import secret key "bootstrap1" "unencrypted:edsk3gUfUPyBSfrS9CCgmCiQsTCHGkviBDusMxDJstFtojtc1zcpsh"
	./node_modules/.bin/granary client - bake for bootstrap1
	./node_modules/.bin/granary client - rpc get /chains/main/blocks/head

block:
	./node_modules/.bin/granary client - bake for bootstrap1

michelson:
	docker run -v $(PWD):$(PWD) ligolang/ligo:next compile-contract $(PWD)/src/nft.ligo main 1> $(PWD)/src/nft.tz

test:
	pytest -v .

origination:
	python -m client originate
	$(MAKE) block
