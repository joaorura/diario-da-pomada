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


def questions_weekly_send(host, token, data):
    response = requests.post(f'{host}/questions/weekly', headers={"Authorization": f"Bearer {token}"}, json=data)
    return response


def create_user(host):
    response = signup_send(host, DATA_TEST)

    if response.status_code != 201:
        print("Questions Weekly - Falha em preparar ambiente!!!")
        return
    
    data = response.json()
    token = data["access_token"]

    return token

def test_0(host):
    date_mens = datetime.today() - relativedelta(day=10)
    date = datetime.today() + relativedelta(day=8)

    data_week = {
        "dificuldadeIntroducao": False,
        "aplicouDormirSexo": True,
        "sentiuIncomodo": True,
        "tipoIncomodo": "Outros",
        "outroTipoIncomodo": "Teste teste",
        "tipoSujeiraCalcinha": "Pastosa",
        "outroTipoSujeiraCalcinha": "",
        "tipoCorResiduoCalcinha": "Amarelada",
        "outroTipoCorResiduoCalcinha": "",
        "sanguePresente": False,
        "dificuldadeSexo": False,
        "tipoDificuldadeSexo": "",
        "menstruouRecentemente": True,
        "dataMenstruacao": date_mens.strftime('%Y-%m-%d'),
        "mestruacaoIgualAnterior": True,
        "tipoMestruacaoDiferente": "",
        "parouUso": False,
        "motivoParadaUso": "",
        "dataDeMarcacao": date.strftime('%Y-%m-%d'),
        "dataDePreenchimento": date.strftime('%Y-%m-%d')
    }
    
    token = create_user(host)

    response = questions_weekly_send(host, token, data_week)
    print("Questions Weekly - Enviando questões", end="")

    try:
        if response.status_code == 201:
            print(" - Passou")
        else:
            print(" - Não Passou")
    except:
            print(" - Não Passou")

    clear_database()

def questions_week_test(host):
    test_0(host)
