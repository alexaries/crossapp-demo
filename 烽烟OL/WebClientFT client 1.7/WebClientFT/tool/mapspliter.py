#!/usr/bin/env python
# coding:utf-8

import os
import shutil
import Image

TITE_SIZE = 256
THUMB_SIZE = 6

SOURCE_PATH = 'D:/code/newx2.source/WebClientFT/maps'
SAVE_PATH = 'D:/code/newx2.source/WebClientFT/bin/res'


def splite(filepath):
    sourceimg = Image.open(filepath)
    sourcefilename = os.path.split(filepath)[1]
    sourcefilename = os.path.splitext(sourcefilename)[0]
    savepath = os.path.join(SAVE_PATH, sourcefilename)
    titepath = os.path.join(savepath, 'tiles')
    if os.path.exists(titepath):
        shutil.rmtree(titepath)
    os.makedirs(titepath)

    print 'splite %s' % sourcefilename

    (source_w, source_h) = sourceimg.size
    thumb_img = sourceimg.resize((source_w / THUMB_SIZE, source_h / THUMB_SIZE), Image.ANTIALIAS)
    thumbpath = os.path.join(savepath, "tiles.jpg")
    if os.path.exists(thumbpath):
        os.remove(thumbpath)
    thumb_img.save(thumbpath)

    x_count = (source_w + TITE_SIZE - 1) / TITE_SIZE
    y_count = (source_h + TITE_SIZE - 1) / TITE_SIZE
    for i in range(x_count):
        for j in range(y_count):
            left = i * TITE_SIZE
            upper = j * TITE_SIZE
            right = left + TITE_SIZE
            down = upper + TITE_SIZE
            if right > source_w:
                right = source_w
            if down > source_h:
                down = source_h
            box = (left, upper, right, down)
            piecename = "%d_%d.jpg" % (j, i)
            piecesavepath = os.path.join(titepath, piecename)
            piece = sourceimg.crop(box)
            piece.save(piecesavepath)


def main():
    files = os.listdir(SOURCE_PATH)
    for f in files:
        filepath = os.path.join(SOURCE_PATH, f)
        splite(filepath)

if __name__ == '__main__':
    main()
