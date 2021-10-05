import subprocess
import time
import pathlib


path_py = pathlib.Path("C:\\Users\\jmess\\Documents\\Workspace\\diario-da-pomada\\ointment-diary")
path_server = path_py.resolve()


def clear_database():
    subprocess.check_output('mongo gynecology --eval "db.dropDatabase()"', shell=True)
    
    time.sleep(1)


def set_user_admin(id):
    send = f'mongo gynecology --eval "db.users.update({{ _id: ObjectId(\'{id}\') }}, {{ $set: {{ role: \'admin\' }} }})"'
    subprocess.check_output(send, shell=True)
    
    time.sleep(1)

def start_server():
    proc = subprocess.Popen(f"npm run start:dev --prefix {path_server}", shell=True)
    time.sleep(10)

    return proc