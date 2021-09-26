import requests
import json


from datetime import datetime

from dateutil.relativedelta import relativedelta
from tests.auth_signup import signup_send

from utils import clear_database

DATA_TEST = {
        "email": "test@test.com",
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": "012345678901234",
        "nationalCard": "12654624455"
    }


def questions_daily_send(host, token, data):
    response = requests.post(f'{host}/questions/daily', headers={"Authorization": f"Bearer {token}"}, json=data)
    return response


def create_user(host):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print("Questions Daily - Falha em preparar ambiente!!!")
        return
    
    data = response.json()
    token = data["access_token"]

    return token

def test_0(host):
    date = datetime.today() + relativedelta(day=1)

    data_daily = {
        "usouPomada": True,
        "motivoNaoUsar": "",
        "dataDeMarcacao": date.strftime('%Y-%m-%d'),
        "dataDePreenchimento": date.strftime('%Y-%m-%d')
    }
    
    token = create_user(host)

    response = questions_daily_send(host, token, data_daily)
    print("Questions Daily - Enviando questões", end="")

    try:
        if response.status_code == 201:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")

    clear_database()


def test_1(host):
    date = datetime.today() + relativedelta(day=1)

    data_daily = {
        "usouPomada": True,
        "motivoNaoUsar": None,
        "dataDeMarcacao": date.strftime('%Y-%m-%d'),
        "dataDePreenchimento": date.strftime('%Y-%m-%d')
    }
    
    token = create_user(host)

    response = questions_daily_send(host, token, data_daily)
    print("Questions Daily - Enviando questões - Com nulo", end="")

    try:
        if response.status_code == 201:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")

    clear_database()


def questions_daily_test(host):
    test_0(host)
    test_1(host)
