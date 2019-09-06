import fire
from os.path import join, dirname
from pprint import pprint

from pytezos import pytezos, NonFungibleTokenImpl

pytezos = pytezos.using(key='edsk3gUfUPyBSfrS9CCgmCiQsTCHGkviBDusMxDJstFtojtc1zcpsh', shell='sandboxnet')
project_dit = dirname(__file__)


class TezosNftSamle:

    def originate(self):
        app = NonFungibleTokenImpl.from_file(join(project_dit, 'src/nft.tz'))
        opg = pytezos.origination(script=app.script(original=False)).autofill().sign()
        contract_id = opg.result()[0].originated_contracts[0]
        opg.inject()
        print(f'Successfully originated {contract_id}\nCheck out the contract at https://better-call.dev/sandbox/{contract_id}')    

    def mint(self, contract_id, token_id, owner=None):
        if owner is None:
            owner = pytezos.key.public_key_hash()
        app = pytezos.nft_app(contract_id)
        app.mint(token_id=token_id, owner=owner).inject()
        print(f'Successfully invoked\nCheck out the latest operation at https://better-call.dev/sandbox/{contract_id}')

    def transfer(self, contract_id, token_id, destination):
        app = pytezos.nft_app(contract_id)
        app.transfer(token_id=token_id, destination=destination).inject()
        print(f'Successfully invoked\nCheck out the latest operation at https://better-call.dev/sandbox/{contract_id}')

    def burn(self, contract_id, token_id):
        app = pytezos.nft_app(contract_id)
        app.burn(token_id).inject()
        print(f'Successfully invoked\nCheck out the latest operation at https://better-call.dev/sandbox/{contract_id}')


if __name__ == '__main__':
    fire.Fire(TezosNftSamle)
