from utils import clear_database
import requests

from tests.auth_signup import signup_send
from tests.user_get import user_send

DATA_TEST = {
        "email": "test@test.com",
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": "012345678901234",
        "nationalCard": "12654624455"
    }


def user_patch_send(host, token, data):
    response = requests.patch(f'{host}/user', headers={"Authorization": f"Bearer {token}"}, data=data)
    return response


def create_user(host):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print(" User Patch - Falha em preparar ambiente!!!")
        return
    
    
    data = response.json()
    token = data["access_token"]

    return token


def test_0(host):
    token = create_user(host)

    data_patch = {
        'email': "jjjj@testjjj.com.br",
        'nationalCard': '13674272407'
    }

    response = user_patch_send(host, token, data_patch)


    response_get = user_send(host, token)
    data = response_get.json()

    print("User Patch - Verificando atualização de CPF e email - Válida", end="")

    try:
        if response.status_code == 200 \
            and response_get.status_code == 200 \
            and len(data.keys()) == 7 \
            and data['role'] == 'user' \
            and data['nationalCard'] == data_patch['nationalCard'] \
            and data['email'] == data_patch['email'] \
            and data['_id'] is not None \
            and data['birthDate'].replace("T00:00:00.000Z", "") == DATA_TEST['birthDate'] \
            and data['fullName'] == DATA_TEST['fullName'] \
            and data['healthCard'] == DATA_TEST['healthCard']:

            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    

    clear_database()

def test_1(host):
    token = create_user(host)

    data_patch = {
        'healthCard': "111111111111111",
    }

    response = user_patch_send(host, token, data_patch)


    response_get = user_send(host, token)
    data = response_get.json()

    print("User Patch - Verificando atualização de Cartão do Sus - Válida", end="")

    try:
        if response.status_code == 200 \
            and response_get.status_code == 200 \
            and len(data.keys()) == 7 \
            and data['role'] == 'user' \
            and data['nationalCard'] == DATA_TEST['nationalCard'] \
            and data['email'] == DATA_TEST['email'] \
            and data['_id'] is not None \
            and data['birthDate'].replace("T00:00:00.000Z", "") == DATA_TEST['birthDate'] \
            and data['fullName'] == DATA_TEST['fullName'] \
            and data['healthCard'] == data_patch['healthCard']:

            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    

    clear_database()


def test_2(host):
    token = create_user(host)

    data_patch = {
        'birthDate': "1982-03-20",
        'fullName': 'Joao Messias Lima Pereira'
    }

    response = user_patch_send(host, token, data_patch)


    response_get = user_send(host, token)
    data = response_get.json()

    print("User Patch - Verificando atualização de Nome Completo e Data de Nascimento - Válida", end="")

    try:
        if response.status_code == 200 \
            and response_get.status_code == 200 \
            and len(data.keys()) == 7 \
            and data['role'] == 'user' \
            and data['nationalCard'] == DATA_TEST['nationalCard'] \
            and data['email'] == DATA_TEST['email'] \
            and data['_id'] is not None \
            and data['birthDate'].replace("T00:00:00.000Z", "") == data_patch['birthDate'] \
            and data['fullName'] == data_patch['fullName'] \
            and data['healthCard'] == DATA_TEST['healthCard']:

            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    

    clear_database()


def user_patch_test(host):
    test_0(host)
    test_1(host)
    test_2(host)
