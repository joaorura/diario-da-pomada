from utils import clear_database
import requests

from tests.auth_signup import signup_send


DATA_TEST = {
        "email": "test@test.com",
        "birthDate": "1999-02-02",
        "fullName": "Test test",
        "password": "709030",
        "healthCard": "012345678901234",
        "nationalCard": "12654624455"
    }


def user_send(host, token):
    response = requests.get(f'{host}/user', headers={"Authorization": f"Bearer {token}"})
    return response


def test_0(host, token):
    response = user_send(host, token)

    data = response.json()

    print("User - Verificando acesso aos dados", end="")

    try:
        if response.status_code == 200 \
            and len(data.keys()) == 7 \
            and data['role'] == 'user' \
            and data['nationalCard'] == DATA_TEST['nationalCard'] \
            and data['email'] == DATA_TEST['email'] \
            and data['_id'] is not None \
            and data['birthDate'].replace("T00:00:00.000Z", "") == DATA_TEST['birthDate'] \
            and data['fullName'] == DATA_TEST['fullName'] \
            and data['healthCard'] == DATA_TEST['healthCard']:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")    



def user_test(host):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print("Auth - User - Falha em preparar ambiente!!!")
        return
    
    data = response.json()
    token = data["access_token"]

    test_0(host, token)

    clear_database()
