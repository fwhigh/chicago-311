try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

config = {
    'description': 'Chicago 311',
    'author': 'F. William high',
    'url': 'https://github.com/fwhigh/chicago-311',
    'download_url': 'https://github.com/fwhigh/chicago-311',
    'author_email': 'fwhigh@gmail.com',
    'version': '0.1',
    'install_requires': ['nose'],
    'packages': ['chicago311'],
    'scripts': ['response_time_mcmc.py'],
    'name': 'projectname'
}

setup(**config)
