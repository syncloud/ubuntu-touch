import requests

def get_latest_price(api, currencies, real):

    COINBASE_API_URL = "https://api.coinbase.com/v2/prices/%s-%s/spot" % (currencies, real)
    CRYPTOCOMPARE_API_URL = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=%s&tsyms=%s" % (currencies.upper(), real.upper())

    if api == "COINBASE":
        response = requests.get(COINBASE_API_URL)
        response_json = response.json()
        try:
            return float(response_json['data']['amount'])
        except:
            return False
    else:
        response = requests.get(CRYPTOCOMPARE_API_URL)
        response_json = response.json()
        try:
            return float(response_json['RAW'][currencies.upper()][real.upper()]['PRICE'])
        except:
            return False
