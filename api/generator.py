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
        return False
    else:
        print("Successfully created the directory %s " % path)
        return True


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


def create_html(alien):
    f = open(get_path(alien + '/index.html'), 'w')

    message = """<html>
    <head><title>{title}</title></head>
    <body>
    <h1>{title}</h1>
    <br />
    <img src="{img}" />
    <br />
    <a href={img}>Image</a>
    <br />
    <a href={json}>json</a>
    </body>
    </html>""".format(title=alien, img=alien + '.jpg',
                      json=alien + '.json')

    f.write(message)
    f.close()


def create_alien_list(aliens):

    f = open(get_path('/index.html'), 'w')

    aliens_html = ""

    for alien in aliens:
        aliens_html += "<li><a href='./" + alien + "/index.html'>" + alien + "</a></li>"

    message = """<html>
    <head><title>Aliens</title></head>
    <body>
    <h1>All aliens</h1>
    <br />
    <ul>{aliens}</ul>
    </body>
    </html>""".format(aliens=aliens_html)

    f.write(message)
    f.close()


aliens = pd.read_json('F:/Development/cosmodex/api/aliens.json')
alien_names = []
for index, row in aliens.iterrows():
    alien = regex.sub('', row['name'])
    print(alien)
    if(create_directory('api/' + alien)):
        get_card(row['name'])
        save_data(alien, row)
        create_html(alien)
    alien_names.append(alien)
create_alien_list(alien_names)
