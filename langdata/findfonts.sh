#!/bin/bash
 text2image --find_fonts \
 --fonts_dir /home/ubuntu/.fonts \
 --text xsa.txt \
 --min_coverage .5  \
 --outputbase ~/tmp \
 --render_per_font false \
 |& grep raw \
  | sed -e 's/ :.*//g'  > xsa.fontslist.txt

 