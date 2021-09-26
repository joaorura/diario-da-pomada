import requests

from utils import clear_database

def signup_send(host, data):
    response = requests.post(f'{host}/auth/signup', data=data)
    return response


def s_test_0(host):
    clear_database()

    data = {
        "email": "test@test.com",
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": "012345678901234",
        "nationalCard": "12654624455"
    }
    
    response = signup_send(host, data)
    data = response.json()
    
    try:
        if response.status_code == 201 and len(data.keys()) == 1 and data['access_token'] is not None:
            print("Auth - Siginup - Verificando criação de conta válida - Passou")
        else:
            print("Auth - Siginup - Verificando criação de conta válida - Não Passou")
    except:
            print("Auth - Siginup - Verificando criação de conta válida - Não Passou")


def s_test_1(host):
    clear_database()

    data = {
        "email": None,
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": "012345678901234",
        "nationalCard": "12654624455"
    }
    
    response = signup_send(host, data)
    data = response.json()
    
    try:
        if response.status_code == 201 and len(data.keys()) == 1 and data['access_token'] is not None:
            print("Auth - Siginup - Verificando criação de conta válida (Sem email) - Passou")
        else:
            print("Auth - Siginup - Verificando criação de conta válida (Sem email) - Não Passou")
    except:
        print("Auth - Siginup - Verificando criação de conta válida (Sem email) - Não Passou")


def s_test_2(host):
    clear_database()

    data = {
        "email": "test@test.com",
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": None,
        "nationalCard": "12654624455"
    }
    
    response = signup_send(host, data)
    data = response.json()
    
    try:
        if response.status_code == 400:
            print("Auth - Siginup - Verificando criação de conta válida (Sem healthCard) - Passou")
        else:
            print("Auth - Siginup - Verificando criação de conta válida (Sem healthCard) - Não Passou")
    except:
        print("Auth - Siginup - Verificando criação de conta válida (Sem email) - Não Passou")


def signup_test(host):
    s_test_0(host)
    s_test_1(host)
    s_test_2(host)

    clear_database()
