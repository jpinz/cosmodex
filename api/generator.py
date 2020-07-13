import pandas as pd
import os
import re
import json
from lxml import etree
from io import StringIO
import requests
import urllib
regex = re.compile('[^a-zA-Z]')

parser = etree.HTMLParser()


def get_path(alien):
    return os.getcwd() + "/api/" + alien


def create_directory(path):
    try:
        os.mkdir(path)
    except OSError:
        print("Creation of the directory %s failed" % path)
    else:
        print("Successfully created the directory %s " % path)


def get_card(alien):
    if(alien == "Alien"):
        page = requests.get(
            'https://cosmicencounter.fandom.com/wiki/Alien_(race)')
    else:
        page = requests.get('https://cosmicencounter.fandom.com/wiki/' + alien)
    html = page.content.decode("utf-8")

    tree = etree.parse(StringIO(html), parser=parser)
    alien_name = tree.xpath('//h1[@class="page-header__title"]/text()')
    if(alien_name[0] != alien and alien_name[0] != "Alien (race)"):
        print("Differing alien names")
        exit(-1)

    image = ''
    for elt in tree.xpath('//a[@class="image image-thumbnail"]'):
        image = elt.attrib['href']
        if('.png' in image):
            image = image.split('.png')[0] + '.png'
        elif('.jpg' in image):
            image = image.split('.jpg')[0] + '.jpg'

    if(not image):
        return
    img_data = requests.get(image).content
    alien = regex.sub('', row['name'])
    with open(get_path(alien) + '/' + alien + '.jpg', 'wb') as handler:
        handler.write(img_data)


def save_data(alien, data):
    data.to_json(get_path(alien) + '/' + alien + '.json')


aliens = pd.read_json('F:/Development/cosmodex/api/aliens.json')
print(aliens.head())
for index, row in aliens.iterrows():
    alien = regex.sub('', row['name'])
    print(alien)
    create_directory('api/' + alien)
    get_card(row['name'])
    save_data(alien, row)
