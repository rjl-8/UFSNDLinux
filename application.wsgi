import sys
sys.path.insert(0, '/var/www/wsgi/catalog')

print sys.path

from application import app as application
