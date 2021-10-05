import requests
import time
import subprocess
import pathlib

from utils import clear_database, start_server

from tests.auth_signup import signup_test
from tests.auth_signin import sigin_test
from tests.user_get import user_test
from tests.user_role import user_role_test
from tests.user_patch import user_patch_test
from tests.calendar_post import calendar_test
from tests.reports_specific import reports_specific_test
from tests.reports_general import reports_general_test
from tests.questions_weekly import questions_week_test
from tests.questions_daily import questions_daily_test

TENT = 2

server = False
host = "http://127.0.0.1:3000"


def all_tests():
    signup_test(host)

    sigin_test(host)

    user_test(host)
    
    user_role_test(host)

    user_patch_test(host)

    calendar_test(host)

    reports_specific_test(host)

    reports_general_test(host)

    questions_week_test(host)

    questions_daily_test(host)


def main():
    print("Limpando Banco de dados\n\n")
    clear_database()


    if server:
        print("Iniciando server ...\n\n")
        proc = start_server()

    print("\n\nExecutando Testes\n\n")

    count  = 0

    while count != TENT and count != -1:
        try:
            all_tests()

            count = -1
        except requests.exceptions.ConnectionError:
            print(f"Erro de conexão - {count}")
            count += 1
            time.sleep(5)

    if server == True:
        proc.kill


if __name__ == "__main__":
    main()
