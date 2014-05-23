#!/usr/bin/env python
# coding:utf-8

import os
import shutil
import codecs
import Image
import xml.dom.minidom

ROOT_INUPT = '../resources/'


def pin(inpath, outdirpath, outpngname, posy):
    if not os.path.isdir(inpath):
        print '%s is not dir'
        return
    imgfs = os.listdir(inpath)
    imgfs.sort()
    isfirst = True
    outimg = 0
    startx = 0
    imglen = len(imgfs)
    showlen = imglen
    r = range(imglen)
    isreduce = 1
    if imglen >= 20:
        showlen = imglen / 2
        isreduce = 2
    savename = os.path.join(outdirpath, "%s_%d_%d" % (outpngname, showlen, 1))
    imgsize = 0

    r = r[::isreduce]
    if 0 == len(r):
        print 'no img in dir %s' % inpath
        exit(-1)
    for i in r:
        imgf = imgfs[i]
        print 'open img %s' % os.path.join(inpath, imgf)
        if '.png' != os.path.splitext(imgf)[1]:
            continue
        img = Image.open(os.path.join(inpath, imgf))
        imgsize = img.size
        if isfirst:
            outimg = Image.new('RGBA', (imgsize[0] * showlen, imgsize[1]))
            isfirst = False
        outimg.paste(img, (startx, 0))
        startx += imgsize[0]
    print savename, imgsize, posy
    savename = '%s_%d_%s.png' % (savename, imgsize[0] / 2, posy)
    outimg.save(savename)
    print 'ping png %s' % savename


def parexml(path):
    dom = xml.dom.minidom.parse(path)
    root = dom.documentElement
    items = root.getElementsByTagName('item')
    for item in items:
        input = item.getAttribute('input')
        output = item.getAttribute('output')
        posy = item.getAttribute('posy')
        isbuild = item.getAttribute('build')
        if '0' == isbuild:
            print 'no change %s' % input
            continue
        item.setAttribute('build', '0')
        if os.path.exists(output):
            shutil.rmtree(output)
        os.mkdir(output)
        itemrootpath = os.path.join(ROOT_INUPT, input)
        if not os.path.exists(itemrootpath):
            print 'no dir %s' % itemrootpath
            exit(-1)
        directdirs = os.listdir(itemrootpath)
        for directdir in directdirs:
            directpath = os.path.join(itemrootpath, directdir)
            actiondirs = os.listdir(directpath)
            for actiondir in actiondirs:
                actionpath = os.path.join(directpath, actiondir)
                outpngname = '%s%s' % (actiondir, directdir)
                pin(actionpath, output, outpngname, posy)
    f = file(path, 'w')
    writer = codecs.lookup('utf-8')[3](f)
    dom.writexml(writer, encoding='utf-8')
    writer.close()


def main():
    parexml('../resources/info.xml')

if __name__ == '__main__':
    main()
