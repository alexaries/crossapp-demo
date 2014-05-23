#!/usr/bin/env python
# coding:utf-8

import os
import time

RES_ROOT_PATH = '../bin/res'


def pack(dirpath):
    asfilecontent = """package {
    import flash.display.*;
    public class %s extends Sprite {
%s
        public var infos:Array = [%s]
    }
}
"""
    asitemcontent = """        [Embed(source='%s',compression="true",quality ='80')]
        public var %s:Class; //%s
"""
    asfilename = os.path.split(dirpath)[1]
    imgs = os.listdir(dirpath)

    asitems = ''
    names = ''

    for img in imgs:
        imgname, typestr = os.path.splitext(img)
        if '.png' == typestr:
            pngsyspath = os.path.join(dirpath, img)
            pngstatinfo = os.stat(pngsyspath)
            timestr = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(pngstatinfo.st_ctime))
            asitem = asitemcontent % (img, imgname, timestr)
            asitems += asitem
            names += '"%s", ' % imgname

    filecontent = asfilecontent % (asfilename, asitems, names)

    assyspath = os.path.join(dirpath, '%s.%s' % (asfilename, 'as'))
    if os.path.exists(assyspath):
        oldasstr = open(assyspath, 'r').read()
        if oldasstr == filecontent:
            print 'no change in %s' % assyspath
            return

    asfile = open(assyspath, 'w')
    asfile.write(filecontent)
    asfile.close()
    os.system('mxmlc %s' % assyspath)
    print 'pack char res %s' % assyspath


def main():
    resdirs = os.listdir(RES_ROOT_PATH)
    for chardir in resdirs:
        if 0 == chardir.find('char'):
            pack(os.path.join(RES_ROOT_PATH, chardir))

if __name__ == '__main__':
    main()
