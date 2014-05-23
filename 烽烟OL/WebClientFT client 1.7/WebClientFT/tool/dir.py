#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import time
import stat
from xml.dom import minidom
import shutil


ROOTPATH = "../bin/res"
TARGETPATH = "../bin/res"


def create_xml():
    xml_dom = minidom.Document()
    root = xml_dom.createElement('data')
    xml_dom.appendChild(root)
    pareDirs(xml_dom, root, ROOTPATH)
    write_xml(xml_dom)


def write_xml(dom):
    xml_str = dom.toprettyxml(indent="\t", newl="\n", encoding="utf-8")
    f = file(os.path.join(ROOTPATH, 'res.xml'), 'w')
    f.write(xml_str)
    f.close()
    print 'write xml file'


def pareDirs(xmldoc, root, path):
    dirs = os.listdir(path)
    for d in dirs:
        wholepath = os.path.join(path, d)
        if os.path.isdir(wholepath):
            package_node = xmldoc.createElement('assetpackage')
            root.appendChild(package_node)

            package_node.attributes['id'] = d

            package_node.attributes['path'] = 'res/' + d + '/'

            print 'paredir %s' % d

            praePackage(xmldoc, package_node, wholepath, d)


def praePackage(xmldoc, node, dirpath, dirname):
    fs = os.listdir(dirpath)
    for f in fs:
        id, ftype = os.path.splitext(f)
        wholefilename = os.path.join(dirpath, f)
        if os.path.isdir(wholefilename):
            continue
        if 0 == dirname.find('char') and '.swf' != ftype:
            continue
        #if '.png' == ftype:
        #    os.system('optipng %s' % wholefilename)
        fst = os.stat(wholefilename)
        t = fst[stat.ST_MTIME]
        t = time.strftime('%Y%m%d%H%M%S', time.localtime(t))
        #print """       <asset id="%s" path="%s" ver="%s" />""" % (id, f, t)
        assetnode = xmldoc.createElement('asset')
        node.appendChild(assetnode)
        assetnode.attributes['id'] = id
        assetnode.attributes['path'] = f
        assetnode.attributes['type'] = '0'
        if '.int' == ftype:
            assetnode.attributes['type'] = '1'
        elif '.swf' == ftype:
            assetnode.attributes['type'] = '2'
        if 0 == dirname.find('char'):
            assetnode.attributes['type'] = '3'
        assetnode.attributes['ver'] = t

        print '\tpare package %s' % id


def copytree(src, dst):
    shutil.rmtree(TARGETPATH)
    shutil.copytree(ROOTPATH, TARGETPATH)


def main():
    create_xml()
    #copytree(ROOTPATH, TARGETPATH)

if __name__ == '__main__':
    main()
