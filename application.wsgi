import sys
sys.path.insert(0, '/var/www/html/catalog')

print sys.path

from catalog import app as application
