from utils import clear_database
import requests
from requests.models import Response

from tests.auth_signup import signup_send


DATA_TEST = {
        "email": "test@test.com",
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": "012345678901234",
        "nationalCard": "12654624455"
    }

def signin_send(host, data):
    response = requests.post(f'{host}/auth/signin', data=data)
    return response


def test0(host):
    data_login = {
        "username": DATA_TEST["email"],
        "password": DATA_TEST['password']
    }

    response = signin_send(host, data_login)
    data = response.json()
    
    try:
        if response.status_code == 201 and len(data.keys()) == 1 and data['access_token'] is not None:
            print("Auth - Signin - Verificando login (email) - Passou")
        else:
            print("Auth - Signin - Verificando login (email) - Não Passou")
    except:
        print("Auth - Signin - Verificando login (email) - Não Passou")

def test1(host):
    data_login = {
        "username": DATA_TEST["email"],
        "password": DATA_TEST['password'] + "1"
    }

    response = signin_send(host, data_login)
    data = response.json()
    
    try:
        if response.status_code == 401:
            print("Auth - Signin - Verificando login (Senha Errada) - Passou")
        else:
            print("Auth - Signin - Verificando login (Senha Errada) - Não Passou")
    except:
        print("Auth - Signin - Verificando login (Senha Errada) - Não Passou")

def test2(host):
    data_login = {
        "username": DATA_TEST["email"] + "1",
        "password": DATA_TEST['password']
    }

    response = signin_send(host, data_login)
    data = response.json()
    
    print("Auth - Signin - Verificando login (Email Errado)", end="")

    try:
        if response.status_code == 401:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")


def sigin_test(host):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print("Auth - Signin - Falha em preparar ambiente!!!")
        return

    test0(host)
    test1(host)
    test2(host)

    clear_database()
