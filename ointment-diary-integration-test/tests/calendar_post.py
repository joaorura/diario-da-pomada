import requests

from datetime import datetime

from utils import clear_database
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


def calendar_send(host, token, data):
    response = requests.post(f'{host}/calendary', headers={"Authorization": f"Bearer {token}"}, data=data)
    return response


def test_0(host, token):
    data_calendar = {
        "currentDate": datetime.today().strftime('%Y-%m-%d')
    }

    response = calendar_send(host, token, data_calendar)

    data = response.json()

    print("Calendar - Verificando acesso ao calendário atual", end="")

    try:
        if response.status_code == 201 \
            and len(data.keys()) == 3 \
            and data['weekly'] is not None \
            and type(data['weekly']) is list \
            and data['daily'] is not None \
            and type(data['daily']) is list \
            and data['isNew'] == False:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    


def test_1(host, token):
    date = datetime.today() + relativedelta(years=1)

    data_calendar = {
        "currentDate": date.strftime('%Y-%m-%d')
    }

    response = calendar_send(host, token, data_calendar)

    data = response.json()

    print("Calendar - Verificando acesso ao calendário novo", end="")

    try:
        if response.status_code == 201 \
            and len(data.keys()) == 3 \
            and data['weekly'] is not None \
            and type(data['weekly']) is list \
            and data['daily'] is not None \
            and type(data['daily']) is list \
            and data['isNew'] == True:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    


def calendar_test(host):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print("Calendar - Falha em preparar ambiente!!!")
        return
    
    data = response.json()
    token = data["access_token"]

    test_0(host, token)
    test_1(host, token)

    clear_database()
