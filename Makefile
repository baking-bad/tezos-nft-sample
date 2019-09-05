version:
	echo '{ "version": "0.0.3" }' > .granary/sandboxnet/node/version.json

alpha:
	./node_modules/.bin/granary client - import secret key activator unencrypted:edsk31vznjHSSpGExDMHYASz45VZqXN4DPxvsa4hAyY8dHM28cZzp6 --force
	./node_modules/.bin/granary client - activate protocol Pt24m4xiPbLDhVgVfABUjirbmda3yohdN82Sp9FeuAXJ4eV9otd with fitness 1 and key activator and parameters $(PWD)/protocol_parameters.json --timestamp `TZ='AAA+1' date +%FT%TZ`
	./node_modules/.bin/granary client - import secret key "bootstrap1" "unencrypted:edsk3gUfUPyBSfrS9CCgmCiQsTCHGkviBDusMxDJstFtojtc1zcpsh"
	./node_modules/.bin/granary client - bake for bootstrap1
	./node_modules/.bin/granary client - rpc get /chains/main/blocks/head

compile:
	for f in src/*.ligo; do docker run -v $(PWD):$(PWD) ligolang/ligo:next compile-contract $(PWD)/$$f main > $(PWD)/$${f%.ligo}.tz; done

test:
	pytest -v .

origination:
	python -m client originate

block:
	./node_modules/.bin/granary client - bake for bootstrap1
