#!/bin/python3
password = b"P@ssword1"

import subprocess
import sys
try:
    __import__("bcrypt")
except ImportError:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "bcrypt"])
finally:
    globals()["bcrypt"] = __import__("bcrypt")
from bcrypt import hashpw, gensalt
hashed = hashpw(password, gensalt())
print(hashed.decode())
