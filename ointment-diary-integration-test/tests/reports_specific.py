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


def reports_specific_send(host, token, data):
    response = requests.post(f'{host}/reports/specific', headers={"Authorization": f"Bearer {token}"}, data=data)
    return response


def create_user_admin(host, admin = True):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print("Report Specific - Falha em preparar ambiente!!!")
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
    data_report = {
        "healthCard": DATA_TEST['healthCard']
    }

    response = reports_specific_send(host, token, data_report)

    data = response.json()

    print("Report Specific - Verificando relátorio specifico dados, com permissão", end="")

    try:
        if response.status_code == 201 \
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

    data_report = {
        "healthCard": DATA_TEST['healthCard']
    }

    response = reports_specific_send(host, token, data_report)

    print("Report Specific - Verificando relátorio specifico dados corretos, sem permissão", end="")

    try:
        if response.status_code == 403:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    

    clear_database()


def reports_specific_test(host):
    test_0(host)
    test_1(host)
