from tests.user_get import user_send
import requests

from datetime import datetime

from utils import clear_database, set_user_admin
from tests.auth_signup import signup_send
from dateutil.relativedelta import relativedelta


DATA_TEST = {
        "email": "test@test.com",
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": "012345678901234",
        "nationalCard": "12654624455"
    }


def reports_general_send(host, token):
    response = requests.get(f'{host}/reports/general', headers={"Authorization": f"Bearer {token}"})
    return response


def create_user_admin(host, admin = True):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print("Report General - Falha em preparar ambiente!!!")
        return
    
    data = response.json()
    token = data["access_token"]


    response = user_send(host, token)
    data = response.json()

    if admin:
        set_user_admin(data['_id'])

    return token


def test_0(host):
    token = create_user_admin(host)

    response = reports_general_send(host, token)

    data = response.json()

    print("Report General - Verificando relátorio geral dados, com permissão", end="")

    try:
        if response.status_code == 200 \
            and len(data.keys()) == 1 \
            and data['file'] is not None \
            and type(data['file']) is str:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    

    clear_database()


def test_1(host):
    token = create_user_admin(host, False)

    response = reports_general_send(host, token)

    print("Report General - Verificando relátorio geral dados corretos, sem permissão", end="")

    try:
        if response.status_code == 403:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    

    clear_database()


def reports_general_test(host):
    test_0(host)
    test_1(host)
