# -*- coding: utf-8 -*-

import sys
import codecs
stdin = codecs.getreader("utf-8")(sys.stdin)

lines = [line.strip() for line in stdin]
has_metro = lambda x: x == u"■"
states = [map(has_metro, reversed(line)) for line in zip(*lines)]
for st in states:
    print st
