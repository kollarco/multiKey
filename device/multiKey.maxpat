{
 "patcher": {
  "fileversion": 1,
  "appversion": {
   "major": 9,
   "minor": 0,
   "revision": 7,
   "architecture": "x64",
   "modernui": 1
  },
  "classnamespace": "box",
  "rect": [
   100.0,
   100.0,
   1200.0,
   800.0
  ],
  "default_fontsize": 10.0,
  "default_fontface": 0,
  "default_fontname": "Arial",
  "gridonopen": 1,
  "gridsize": [
   15.0,
   15.0
  ],
  "boxes": [
   {
    "box": {
     "id": "obj-1",
     "maxclass": "comment",
     "patching_rect": [
      20,
      20,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      4,
      80,
      22
     ],
     "text": "multiKey",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 16.0,
     "fontface": 1
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "comment",
     "patching_rect": [
      20,
      54,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      84,
      9,
      34,
      16
     ],
     "text": "v0.8",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "comment",
     "patching_rect": [
      20,
      88,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      24,
      120,
      14
     ],
     "text": "ENVELOPE",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1,
     "varname": "g_obj3"
    }
   },
   {
    "box": {
     "id": "obj-4",
     "maxclass": "comment",
     "patching_rect": [
      20,
      122,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      444,
      24,
      80,
      14
     ],
     "text": "PLAY",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1,
     "varname": "g_obj4"
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "comment",
     "patching_rect": [
      20,
      156,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      548,
      24,
      80,
      14
     ],
     "text": "RANDOM",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1,
     "varname": "g_obj5"
    }
   },
   {
    "box": {
     "id": "obj-6",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      190,
      120,
      22
     ],
     "text": "midiin",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-7",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      224,
      120,
      22
     ],
     "text": "split 0 127",
     "numinlets": 3,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-8",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      258,
      120,
      22
     ],
     "text": "split 128 239",
     "numinlets": 3,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-9",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      292,
      120,
      22
     ],
     "text": "t i i b",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "int",
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-10",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      326,
      120,
      22
     ],
     "text": "expr $i1 >> 4",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-11",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      360,
      120,
      22
     ],
     "text": "expr ($i1 & 15) + 1",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-12",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      394,
      120,
      22
     ],
     "text": "i",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-13",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      428,
      120,
      22
     ],
     "text": "i",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-14",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      462,
      120,
      22
     ],
     "text": "zl group 2",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "message",
     "patching_rect": [
      20,
      496,
      120,
      22
     ],
     "text": "zlclear",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-16",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      530,
      120,
      22
     ],
     "text": "t b l b",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "bang",
      "",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-17",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      564,
      120,
      22
     ],
     "text": "pack 0 0 0 0",
     "numinlets": 4,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-18",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      598,
      120,
      22
     ],
     "text": "unpack 0 0",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      632,
      120,
      22
     ],
     "text": "route 9 8 14",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-20",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      666,
      120,
      22
     ],
     "text": "zl slice 2",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-21",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      700,
      120,
      22
     ],
     "text": "append 0",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-22",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      734,
      120,
      22
     ],
     "text": "t l l",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-23",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      768,
      120,
      22
     ],
     "text": "zl nth 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      20,
      120,
      22
     ],
     "text": "zl slice 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-25",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      54,
      120,
      22
     ],
     "text": "pack 0 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-26",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      88,
      120,
      22
     ],
     "text": "t l l",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-27",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      122,
      120,
      22
     ],
     "text": "zl nth 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-28",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      156,
      120,
      22
     ],
     "text": "expr $i2 + $i3*128",
     "numinlets": 3,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-29",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      190,
      120,
      22
     ],
     "text": "zl rev",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-30",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      224,
      120,
      22
     ],
     "text": "route 0",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-31",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      258,
      120,
      22
     ],
     "text": "poly~ multikey.voice 32 @steal 1 @args ---mkpool",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "signal",
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "message",
     "patching_rect": [
      190,
      292,
      120,
      22
     ],
     "text": "midinote $1 0 0 0 0 0 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-33",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      326,
      120,
      22
     ],
     "text": "gate 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      360,
      120,
      22
     ],
     "text": "unpack 0 0",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-35",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      394,
      120,
      22
     ],
     "text": "pack 0 0 0 0. 0. 0. 0",
     "numinlets": 7,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-36",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      428,
      120,
      22
     ],
     "text": "prepend midinote",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-37",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      462,
      120,
      22
     ],
     "text": "t i i",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-38",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      496,
      120,
      22
     ],
     "text": "expr $i1 - 60 + $i2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-39",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      530,
      120,
      22
     ],
     "text": "+ 0.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-40",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      564,
      120,
      22
     ],
     "text": "i",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-41",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      598,
      120,
      22
     ],
     "text": "i",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-42",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      632,
      120,
      22
     ],
     "text": "t b i b i b",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
      "bang",
      "int",
      "bang",
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-43",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      666,
      120,
      22
     ],
     "text": "expr ((1.-$f2) + $f2*pow($f1/127.\\, 1.5)) * $f3",
     "numinlets": 3,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-44",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      700,
      120,
      22
     ],
     "text": "random 10001",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-45",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      734,
      120,
      22
     ],
     "text": "expr ($f1/5000.-1.)*$f2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-46",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      768,
      120,
      22
     ],
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-47",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      20,
      120,
      22
     ],
     "text": "onebang 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-48",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      54,
      120,
      22
     ],
     "text": "t b b b",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "bang",
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-49",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      88,
      120,
      22
     ],
     "text": "delay 30",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-50",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      122,
      120,
      22
     ],
     "text": "coll",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-51",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      156,
      120,
      22
     ],
     "text": "t l b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-52",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      190,
      120,
      22
     ],
     "text": "random 10000",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-53",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      224,
      120,
      22
     ],
     "text": "/ 10000.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-54",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      258,
      120,
      22
     ],
     "text": "append 0.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-55",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      292,
      120,
      22
     ],
     "text": "expr ($f4 < $f3) * $i2 + ($f4 >= $f3) * $i1",
     "numinlets": 4,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-56",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      326,
      120,
      22
     ],
     "text": "t b i",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-57",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      360,
      120,
      22
     ],
     "text": "+ 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-58",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      394,
      120,
      22
     ],
     "text": "gate 4",
     "numinlets": 2,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-59",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      428,
      120,
      22
     ],
     "text": "t i i",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-60",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      462,
      120,
      22
     ],
     "text": "expr $i1*($i2==0) + $i2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-61",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      496,
      120,
      22
     ],
     "text": "coll",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-62",
     "maxclass": "message",
     "patching_rect": [
      360,
      530,
      120,
      22
     ],
     "text": "clear",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-63",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      564,
      120,
      22
     ],
     "text": "urn 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-64",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      598,
      120,
      22
     ],
     "text": "+ 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-65",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      632,
      120,
      22
     ],
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-66",
     "maxclass": "message",
     "patching_rect": [
      360,
      666,
      120,
      22
     ],
     "text": "clear",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-67",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      700,
      120,
      22
     ],
     "text": "urn 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-68",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      734,
      120,
      22
     ],
     "text": "+ 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-69",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      768,
      120,
      22
     ],
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-70",
     "maxclass": "message",
     "patching_rect": [
      530,
      20,
      120,
      22
     ],
     "text": "clear",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-71",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      54,
      120,
      22
     ],
     "text": "urn 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-72",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      88,
      120,
      22
     ],
     "text": "+ 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-73",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      122,
      120,
      22
     ],
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-74",
     "maxclass": "message",
     "patching_rect": [
      530,
      156,
      120,
      22
     ],
     "text": "clear",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-75",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      190,
      120,
      22
     ],
     "text": "urn 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-76",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      224,
      120,
      22
     ],
     "text": "+ 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-77",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      258,
      120,
      22
     ],
     "text": "t b b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-78",
     "maxclass": "message",
     "patching_rect": [
      530,
      292,
      120,
      22
     ],
     "text": "clear",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-79",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      326,
      120,
      22
     ],
     "text": "coll",
     "numinlets": 1,
     "numoutlets": 4,
     "outlettype": [
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-80",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      360,
      120,
      22
     ],
     "text": "unpack 0. 0.",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "float",
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-81",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      394,
      120,
      22
     ],
     "text": "gate 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-82",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      428,
      120,
      22
     ],
     "text": "gate 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-83",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      462,
      120,
      22
     ],
     "text": "transport",
     "numinlets": 2,
     "numoutlets": 9,
     "outlettype": [
      "int",
      "int",
      "float",
      "float",
      "float",
      "",
      "int",
      "float",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-84",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      496,
      120,
      22
     ],
     "text": "expr int(($f1+30.)/60.)",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-85",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      530,
      120,
      22
     ],
     "text": "expr int(fmod($f1*104729. + $f2*7919.\\, 2147483000.)) + 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-86",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      564,
      120,
      22
     ],
     "text": "prepend seed",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-87",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      598,
      120,
      22
     ],
     "text": "live.thisdevice",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "bang",
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-88",
     "maxclass": "message",
     "patching_rect": [
      530,
      632,
      120,
      22
     ],
     "text": "path live_set",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-89",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      666,
      120,
      22
     ],
     "text": "live.path",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-90",
     "maxclass": "message",
     "patching_rect": [
      530,
      700,
      120,
      22
     ],
     "text": "property is_playing",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-91",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      734,
      120,
      22
     ],
     "text": "live.observer",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-92",
     "maxclass": "live.gain~",
     "patching_rect": [
      530,
      768,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      668,
      6,
      44,
      156
     ],
     "numinlets": 2,
     "numoutlets": 5,
     "outlettype": [
      "signal",
      "signal",
      "",
      "float",
      "list"
     ],
     "parameter_enable": 1,
     "varname": "Volume",
     "orientation": 1,
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Volume",
       "parameter_shortname": "Volume",
       "parameter_type": 0,
       "parameter_mmin": -70.0,
       "parameter_mmax": 6.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 4
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-93",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      20,
      120,
      22
     ],
     "text": "*~ 0.316",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-94",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      54,
      120,
      22
     ],
     "text": "*~ 0.316",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-95",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      88,
      120,
      22
     ],
     "text": "plugout~",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "signal",
      "signal"
     ]
    }
   },
   {
    "box": {
     "id": "obj-96",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      122,
      120,
      22
     ],
     "text": "s ---mkpool-params",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": []
    }
   },
   {
    "box": {
     "id": "obj-97",
     "maxclass": "live.dial",
     "patching_rect": [
      700,
      156,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      38,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Attack",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Attack",
       "parameter_shortname": "Attack",
       "parameter_type": 0,
       "parameter_mmin": 0.0,
       "parameter_mmax": 5000.0,
       "parameter_initial": [
        1.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 2,
       "parameter_exponent": 3.0
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-98",
     "maxclass": "live.dial",
     "patching_rect": [
      700,
      190,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      300,
      38,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Decay",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Decay",
       "parameter_shortname": "Decay",
       "parameter_type": 0,
       "parameter_mmin": 1.0,
       "parameter_mmax": 10000.0,
       "parameter_initial": [
        600.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 2,
       "parameter_exponent": 3.0
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-99",
     "maxclass": "live.dial",
     "patching_rect": [
      700,
      224,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      344,
      38,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Sustain",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Sustain",
       "parameter_shortname": "Sustain",
       "parameter_type": 0,
       "parameter_mmin": 0.0,
       "parameter_mmax": 100.0,
       "parameter_initial": [
        100.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 5
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-100",
     "maxclass": "live.dial",
     "patching_rect": [
      700,
      258,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      388,
      38,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Release",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Release",
       "parameter_shortname": "Release",
       "parameter_type": 0,
       "parameter_mmin": 1.0,
       "parameter_mmax": 10000.0,
       "parameter_initial": [
        250.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 2,
       "parameter_exponent": 3.0
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-101",
     "maxclass": "live.dial",
     "patching_rect": [
      700,
      292,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      444,
      38,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Spread",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Spread",
       "parameter_shortname": "Spread",
       "parameter_type": 0,
       "parameter_mmin": 0.0,
       "parameter_mmax": 100.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 5
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-102",
     "maxclass": "live.dial",
     "patching_rect": [
      700,
      326,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      488,
      38,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Transpose",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Transpose",
       "parameter_shortname": "Transpose",
       "parameter_type": 1,
       "parameter_mmin": -48.0,
       "parameter_mmax": 48.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 7
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-103",
     "maxclass": "live.dial",
     "patching_rect": [
      700,
      360,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      444,
      100,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "VelVol",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Vel > Vol",
       "parameter_shortname": "Vel > Vol",
       "parameter_type": 0,
       "parameter_mmin": 0.0,
       "parameter_mmax": 100.0,
       "parameter_initial": [
        70.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 5
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-104",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      394,
      120,
      22
     ],
     "text": "prepend attack",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-105",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      428,
      120,
      22
     ],
     "text": "prepend decay",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-106",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      462,
      120,
      22
     ],
     "text": "prepend release",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-107",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      496,
      120,
      22
     ],
     "text": "/ 100.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-108",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      530,
      120,
      22
     ],
     "text": "prepend sustain",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-109",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      564,
      120,
      22
     ],
     "text": "/ 100.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-110",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      598,
      120,
      22
     ],
     "text": "/ 100.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-111",
     "maxclass": "comment",
     "patching_rect": [
      700,
      632,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      548,
      38,
      80,
      14
     ],
     "text": "Chord window",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "varname": "g_obj111"
    }
   },
   {
    "box": {
     "id": "obj-112",
     "maxclass": "live.numbox",
     "patching_rect": [
      700,
      666,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      548,
      52,
      60,
      15
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "ChordWindow",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Chord Window",
       "parameter_shortname": "Chord Window",
       "parameter_type": 0,
       "parameter_mmin": 0.0,
       "parameter_mmax": 100.0,
       "parameter_initial": [
        30.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 2
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-113",
     "maxclass": "live.text",
     "patching_rect": [
      700,
      700,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      548,
      74,
      60,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 1,
     "varname": "Seed",
     "mode": 1,
     "text": "Seed",
     "texton": "Seed",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Seed",
       "parameter_shortname": "Seed",
       "parameter_type": 2,
       "parameter_mmin": 0.0,
       "parameter_mmax": 1.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 9,
       "parameter_enum": [
        "off",
        "on"
       ]
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-114",
     "maxclass": "live.numbox",
     "patching_rect": [
      700,
      734,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      548,
      94,
      60,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "SeedValue",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Seed Value",
       "parameter_shortname": "Seed Value",
       "parameter_type": 0,
       "parameter_mmin": 1.0,
       "parameter_mmax": 9999.0,
       "parameter_initial": [
        1.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 0,
       "parameter_steps": 9999
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-115",
     "maxclass": "live.text",
     "patching_rect": [
      700,
      768,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      548,
      114,
      60,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 0,
     "mode": 0,
     "text": "Re-roll",
     "varname": "g_obj115"
    }
   },
   {
    "box": {
     "id": "obj-116",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      20,
      120,
      22
     ],
     "text": "route bang 1",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-117",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      54,
      120,
      22
     ],
     "text": "random 9999",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-118",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      88,
      120,
      22
     ],
     "text": "+ 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-119",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      122,
      120,
      22
     ],
     "text": "pack 0 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-120",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      156,
      120,
      22
     ],
     "text": "zl rev",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-121",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      190,
      120,
      22
     ],
     "text": "route 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-122",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      224,
      120,
      22
     ],
     "text": "s ---mkpool-bend",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": []
    }
   },
   {
    "box": {
     "id": "obj-123",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      258,
      120,
      22
     ],
     "text": "expr ($f1-8192.)/8192.*$f2",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-124",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      292,
      120,
      22
     ],
     "text": "prepend master",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-125",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      326,
      120,
      22
     ],
     "text": "unpack 0 0",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-126",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      360,
      120,
      22
     ],
     "text": "expr ($f1-8192.)/8192.*48.",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-127",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      394,
      120,
      22
     ],
     "text": "pack 0 0.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-128",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      428,
      120,
      22
     ],
     "text": "prepend note",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-129",
     "maxclass": "comment",
     "patching_rect": [
      870,
      462,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      488,
      100,
      60,
      14
     ],
     "text": "Wheel range",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "varname": "g_obj129"
    }
   },
   {
    "box": {
     "id": "obj-130",
     "maxclass": "live.numbox",
     "patching_rect": [
      870,
      496,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      488,
      116,
      44,
      15
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "PBRange",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "PB Range",
       "parameter_shortname": "PB Range",
       "parameter_type": 1,
       "parameter_mmin": 0.0,
       "parameter_mmax": 48.0,
       "parameter_initial": [
        2.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 7
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-131",
     "maxclass": "waveform~",
     "patching_rect": [
      870,
      530,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      26,
      236,
      80
     ],
     "numinlets": 5,
     "numoutlets": 6,
     "outlettype": [
      "float",
      "float",
      "float",
      "float",
      "list",
      ""
     ],
     "ignoreclick": 1,
     "background": 1,
     "bgcolor": [
      0.12,
      0.12,
      0.12,
      1.0
     ],
     "waveformcolor": [
      0.55,
      0.83,
      0.93,
      1.0
     ],
     "selectioncolor": [
      0.0,
      0.0,
      0.0,
      0.0
     ]
    }
   },
   {
    "box": {
     "id": "obj-132",
     "maxclass": "dropfile",
     "patching_rect": [
      870,
      564,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      26,
      180,
      80
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "border": 0
    }
   },
   {
    "box": {
     "id": "obj-133",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      598,
      120,
      22
     ],
     "text": "polybuffer~ ---mkpool",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-134",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      632,
      120,
      22
     ],
     "text": "buffer~ ---mkempty 10",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "float",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-135",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      666,
      120,
      22
     ],
     "text": "js multikey_loader.js ---mkpool ---mkempty",
     "numinlets": 1,
     "numoutlets": 9,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-136",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      700,
      120,
      22
     ],
     "text": "unpack 0 0 0 0 0 0 0 0",
     "numinlets": 1,
     "numoutlets": 8,
     "outlettype": [
      "int",
      "int",
      "int",
      "int",
      "int",
      "int",
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-137",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      734,
      120,
      22
     ],
     "text": "prepend drop",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-138",
     "maxclass": "newobj",
     "patching_rect": [
      870,
      768,
      120,
      22
     ],
     "text": "prepend droptype",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-139",
     "maxclass": "live.text",
     "patching_rect": [
      1040,
      20,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      132,
      66,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 0,
     "mode": 0,
     "text": "Load folder"
    }
   },
   {
    "box": {
     "id": "obj-140",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      54,
      120,
      22
     ],
     "text": "route bang 1",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-141",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      88,
      120,
      22
     ],
     "text": "opendialog fold",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-142",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      122,
      120,
      22
     ],
     "text": "prepend loadfolderpath",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-143",
     "maxclass": "live.text",
     "patching_rect": [
      1040,
      156,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      78,
      132,
      52,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 0,
     "mode": 0,
     "text": "Add file"
    }
   },
   {
    "box": {
     "id": "obj-144",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      190,
      120,
      22
     ],
     "text": "route bang 1",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-145",
     "maxclass": "message",
     "patching_rect": [
      1040,
      224,
      120,
      22
     ],
     "text": "addfile",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-146",
     "maxclass": "live.text",
     "patching_rect": [
      1040,
      258,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      134,
      132,
      56,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 0,
     "mode": 0,
     "text": "Remove"
    }
   },
   {
    "box": {
     "id": "obj-147",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      292,
      120,
      22
     ],
     "text": "route bang 1",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-148",
     "maxclass": "message",
     "patching_rect": [
      1040,
      326,
      120,
      22
     ],
     "text": "removesel",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-149",
     "maxclass": "live.text",
     "patching_rect": [
      1040,
      360,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      194,
      132,
      50,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 0,
     "mode": 0,
     "text": "Clear"
    }
   },
   {
    "box": {
     "id": "obj-150",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      394,
      120,
      22
     ],
     "text": "route bang 1",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-151",
     "maxclass": "message",
     "patching_rect": [
      1040,
      428,
      120,
      22
     ],
     "text": "clear",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-152",
     "maxclass": "umenu",
     "patching_rect": [
      1040,
      462,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      110,
      236,
      18
     ],
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "int",
      "",
      ""
     ],
     "items": [
      "(no samples - drop a folder)"
     ]
    }
   },
   {
    "box": {
     "id": "obj-153",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      496,
      120,
      22
     ],
     "text": "prepend select",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-154",
     "maxclass": "comment",
     "patching_rect": [
      1040,
      530,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      118,
      9,
      126,
      14
     ],
     "text": "drop a folder on the waveform",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "textjustification": 2
    }
   },
   {
    "box": {
     "id": "obj-155",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      564,
      120,
      22
     ],
     "text": "route count",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-156",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      598,
      120,
      22
     ],
     "text": "t i i i",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "int",
      "int",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-157",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      632,
      120,
      22
     ],
     "text": "> 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-158",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      666,
      120,
      22
     ],
     "text": "pattr mkfiles",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ],
     "varname": "mkfiles",
     "saved_object_attributes": {
      "parameter_enable": 1,
      "parameter_mappable": 0
     },
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "mkfiles",
       "parameter_shortname": "mkfiles",
       "parameter_type": 3,
       "parameter_invisible": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-159",
     "maxclass": "newobj",
     "patching_rect": [
      1040,
      700,
      120,
      22
     ],
     "text": "prepend restore",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-160",
     "maxclass": "comment",
     "patching_rect": [
      1040,
      734,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      26,
      300,
      16
     ],
     "text": "No sound selected",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 11.0,
     "fontface": 1,
     "varname": "s_obj160"
    }
   },
   {
    "box": {
     "id": "obj-161",
     "maxclass": "comment",
     "patching_rect": [
      1040,
      768,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      44,
      300,
      28
     ],
     "text": "Settings for the sound selected in the list on the left, on top of the Global settings. Solo: every note plays this sound (click again to leave).",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "linecount": 2,
     "varname": "s_obj161"
    }
   },
   {
    "box": {
     "id": "obj-162",
     "maxclass": "live.dial",
     "patching_rect": [
      1210,
      20,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      78,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "SoundVolume",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Sound Volume",
       "parameter_shortname": "Volume",
       "parameter_type": 0,
       "parameter_mmin": -36.0,
       "parameter_mmax": 12.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 0,
       "parameter_unitstyle": 4,
       "parameter_invisible": 2
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-163",
     "maxclass": "live.dial",
     "patching_rect": [
      1210,
      54,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      304,
      78,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "SoundTranspose",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Sound Transpose",
       "parameter_shortname": "Transpose",
       "parameter_type": 1,
       "parameter_mmin": -24.0,
       "parameter_mmax": 24.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 0,
       "parameter_unitstyle": 7,
       "parameter_invisible": 2
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-164",
     "maxclass": "live.text",
     "patching_rect": [
      1210,
      88,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      191,
      28,
      51,
      15
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 0,
     "mode": 0,
     "text": "Preview"
    }
   },
   {
    "box": {
     "id": "obj-165",
     "maxclass": "live.text",
     "patching_rect": [
      1210,
      122,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      360,
      82,
      60,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ],
     "parameter_enable": 1,
     "mode": 1,
     "text": "Solo",
     "texton": "Solo",
     "varname": "SoloBtn",
     "activebgoncolor": [
      0.33,
      0.62,
      0.92,
      1.0
     ],
     "bgoncolor": [
      0.33,
      0.62,
      0.92,
      1.0
     ],
     "activetextoncolor": [
      0.0,
      0.0,
      0.0,
      1.0
     ],
     "textoncolor": [
      0.0,
      0.0,
      0.0,
      1.0
     ],
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Solo",
       "parameter_shortname": "Solo",
       "parameter_type": 2,
       "parameter_mmin": 0.0,
       "parameter_mmax": 1.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 0,
       "parameter_unitstyle": 9,
       "parameter_enum": [
        "off",
        "on"
       ],
       "parameter_invisible": 2
      },
      "activebgoncolor": {
       "expression": ""
      },
      "bgoncolor": {
       "expression": ""
      },
      "activetextoncolor": {
       "expression": ""
      },
      "textoncolor": {
       "expression": ""
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-166",
     "maxclass": "newobj",
     "patching_rect": [
      1210,
      156,
      120,
      22
     ],
     "text": "route bang 1",
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-167",
     "maxclass": "message",
     "patching_rect": [
      1210,
      190,
      120,
      22
     ],
     "text": "preview",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-168",
     "maxclass": "newobj",
     "patching_rect": [
      1210,
      224,
      120,
      22
     ],
     "text": "prepend solo",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-169",
     "maxclass": "newobj",
     "patching_rect": [
      1210,
      258,
      120,
      22
     ],
     "text": "prepend soundvol",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-170",
     "maxclass": "newobj",
     "patching_rect": [
      1210,
      292,
      120,
      22
     ],
     "text": "prepend soundtrn",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-171",
     "maxclass": "newobj",
     "patching_rect": [
      1210,
      326,
      120,
      22
     ],
     "text": "route name vol trn label tp solo preview solobtn",
     "numinlets": 1,
     "numoutlets": 9,
     "outlettype": [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-172",
     "maxclass": "live.tab",
     "patching_rect": [
      1210,
      360,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      28,
      80,
      16
     ],
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Zones",
     "num_lines_patching": 1,
     "num_lines_presentation": 1,
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Zones",
       "parameter_shortname": "Zones",
       "parameter_type": 2,
       "parameter_mmin": 0.0,
       "parameter_mmax": 1.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 9,
       "parameter_enum": [
        "Off",
        "On"
       ]
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-173",
     "maxclass": "live.dial",
     "patching_rect": [
      1210,
      394,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      344,
      24,
      44,
      48
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Crossfade",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Crossfade",
       "parameter_shortname": "Crossfade",
       "parameter_type": 0,
       "parameter_mmin": 0.0,
       "parameter_mmax": 12.0,
       "parameter_initial": [
        3.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 7
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-174",
     "maxclass": "comment",
     "patching_rect": [
      1210,
      428,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      46,
      80,
      14
     ],
     "text": "ZONES",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1,
     "varname": "z_obj174"
    }
   },
   {
    "box": {
     "id": "obj-175",
     "maxclass": "comment",
     "patching_rect": [
      1210,
      462,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      396,
      22,
      262,
      56
     ],
     "text": "Low up to B1, Mid C2-B3, High from C4. Near a border, notes can also pick from the neighbouring zone: 50/50 at the border, fading to 0 at the Crossfade distance. Low plays an octave up, High an octave down.",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "linecount": 4,
     "varname": "z_obj175"
    }
   },
   {
    "box": {
     "id": "obj-176",
     "maxclass": "newobj",
     "patching_rect": [
      1210,
      496,
      120,
      22
     ],
     "text": "prepend zones",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-177",
     "maxclass": "newobj",
     "patching_rect": [
      1210,
      530,
      120,
      22
     ],
     "text": "prepend xfade",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-178",
     "maxclass": "panel",
     "patching_rect": [
      1210,
      564,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256.0,
      100,
      130.55555555555554,
      26
     ],
     "numinlets": 1,
     "numoutlets": 0,
     "bgcolor": [
      0.85,
      0.45,
      0.25,
      1.0
     ],
     "mode": 0,
     "rounded": 0,
     "varname": "z_obj178"
    }
   },
   {
    "box": {
     "id": "obj-179",
     "maxclass": "comment",
     "patching_rect": [
      1210,
      598,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      260.0,
      105,
      60,
      16
     ],
     "text": "LOW",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1,
     "varname": "z_obj179"
    }
   },
   {
    "box": {
     "id": "obj-180",
     "maxclass": "panel",
     "patching_rect": [
      1210,
      632,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      386.55555555555554,
      100,
      133.33333333333337,
      26
     ],
     "numinlets": 1,
     "numoutlets": 0,
     "bgcolor": [
      0.35,
      0.65,
      0.45,
      1.0
     ],
     "mode": 0,
     "rounded": 0,
     "varname": "z_obj180"
    }
   },
   {
    "box": {
     "id": "obj-181",
     "maxclass": "comment",
     "patching_rect": [
      1210,
      666,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      390.55555555555554,
      105,
      60,
      16
     ],
     "text": "MID",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1,
     "varname": "z_obj181"
    }
   },
   {
    "box": {
     "id": "obj-182",
     "maxclass": "panel",
     "patching_rect": [
      1210,
      700,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      519.8888888888889,
      100,
      136.1111111111111,
      26
     ],
     "numinlets": 1,
     "numoutlets": 0,
     "bgcolor": [
      0.35,
      0.55,
      0.85,
      1.0
     ],
     "mode": 0,
     "rounded": 0,
     "varname": "z_obj182"
    }
   },
   {
    "box": {
     "id": "obj-183",
     "maxclass": "comment",
     "patching_rect": [
      1210,
      734,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      523.8888888888889,
      105,
      60,
      16
     ],
     "text": "HIGH",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1,
     "varname": "z_obj183"
    }
   },
   {
    "box": {
     "id": "obj-184",
     "maxclass": "panel",
     "patching_rect": [
      1210,
      768,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      378.55555555555554,
      96,
      16,
      34
     ],
     "numinlets": 1,
     "numoutlets": 0,
     "bgcolor": [
      1.0,
      1.0,
      1.0,
      0.35
     ],
     "mode": 0,
     "rounded": 0,
     "varname": "zxf1"
    }
   },
   {
    "box": {
     "id": "obj-185",
     "maxclass": "panel",
     "patching_rect": [
      1380,
      20,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      511.8888888888889,
      96,
      16,
      34
     ],
     "numinlets": 1,
     "numoutlets": 0,
     "bgcolor": [
      1.0,
      1.0,
      1.0,
      0.35
     ],
     "mode": 0,
     "rounded": 0,
     "varname": "zxf2"
    }
   },
   {
    "box": {
     "id": "obj-186",
     "maxclass": "comment",
     "patching_rect": [
      1380,
      54,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      248.0,
      132,
      30,
      14
     ],
     "text": "C0",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 8.0,
     "varname": "z_obj186"
    }
   },
   {
    "box": {
     "id": "obj-187",
     "maxclass": "comment",
     "patching_rect": [
      1380,
      88,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      381.33333333333337,
      132,
      30,
      14
     ],
     "text": "C2",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 8.0,
     "varname": "z_obj187"
    }
   },
   {
    "box": {
     "id": "obj-188",
     "maxclass": "comment",
     "patching_rect": [
      1380,
      122,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      514.6666666666667,
      132,
      30,
      14
     ],
     "text": "C4",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 8.0,
     "varname": "z_obj188"
    }
   },
   {
    "box": {
     "id": "obj-189",
     "maxclass": "comment",
     "patching_rect": [
      1380,
      156,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      648.0,
      132,
      30,
      14
     ],
     "text": "C6",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 8.0,
     "varname": "z_obj189"
    }
   },
   {
    "box": {
     "id": "obj-190",
     "maxclass": "live.tab",
     "patching_rect": [
      1380,
      190,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      150,
      236,
      16
     ],
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "zonesel",
     "num_lines_patching": 1,
     "num_lines_presentation": 1,
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Pool Zone",
       "parameter_shortname": "Pool Zone",
       "parameter_type": 2,
       "parameter_mmin": 0.0,
       "parameter_mmax": 2.0,
       "parameter_initial": [
        1.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 9,
       "parameter_enum": [
        "Low",
        "Mid",
        "High"
       ],
       "parameter_invisible": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-191",
     "maxclass": "newobj",
     "patching_rect": [
      1380,
      224,
      120,
      22
     ],
     "text": "prepend zone",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-192",
     "maxclass": "live.tab",
     "patching_rect": [
      1380,
      258,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      256,
      4,
      210,
      16
     ],
     "numinlets": 1,
     "numoutlets": 3,
     "outlettype": [
      "",
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Tab",
     "num_lines_patching": 1,
     "num_lines_presentation": 1,
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "Tab",
       "parameter_shortname": "Tab",
       "parameter_type": 2,
       "parameter_mmin": 0.0,
       "parameter_mmax": 2.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 9,
       "parameter_enum": [
        "Global",
        "Sound",
        "Zones"
       ],
       "parameter_invisible": 1
      }
     }
    }
   },
   {
    "box": {
     "id": "obj-193",
     "maxclass": "newobj",
     "patching_rect": [
      1380,
      292,
      120,
      22
     ],
     "text": "sel 0 1 2",
     "numinlets": 4,
     "numoutlets": 4,
     "outlettype": [
      "bang",
      "bang",
      "bang",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-194",
     "maxclass": "newobj",
     "patching_rect": [
      1380,
      326,
      120,
      22
     ],
     "text": "thispatcher",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-195",
     "maxclass": "message",
     "patching_rect": [
      1380,
      360,
      120,
      22
     ],
     "text": "script show g_obj3, script show g_obj4, script show g_obj5, script show Attack, script show Decay, script show Sustain, script show Release, script show Spread, script show Transpose, script show VelVol, script show g_obj111, script show ChordWindow, script show Seed, script show SeedValue, script show g_obj115, script show g_obj129, script show PBRange, script hide s_obj160, script hide s_obj161, script hide SoundVolume, script hide SoundTranspose, script hide SoloBtn, script hide Zones, script hide Crossfade, script hide z_obj174, script hide z_obj175, script hide z_obj178, script hide z_obj179, script hide z_obj180, script hide z_obj181, script hide z_obj182, script hide z_obj183, script hide zxf1, script hide zxf2, script hide z_obj186, script hide z_obj187, script hide z_obj188, script hide z_obj189",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-196",
     "maxclass": "message",
     "patching_rect": [
      1380,
      394,
      120,
      22
     ],
     "text": "script hide g_obj3, script hide g_obj4, script hide g_obj5, script hide Attack, script hide Decay, script hide Sustain, script hide Release, script hide Spread, script hide Transpose, script hide VelVol, script hide g_obj111, script hide ChordWindow, script hide Seed, script hide SeedValue, script hide g_obj115, script hide g_obj129, script hide PBRange, script show s_obj160, script show s_obj161, script show SoundVolume, script show SoundTranspose, script show SoloBtn, script hide Zones, script hide Crossfade, script hide z_obj174, script hide z_obj175, script hide z_obj178, script hide z_obj179, script hide z_obj180, script hide z_obj181, script hide z_obj182, script hide z_obj183, script hide zxf1, script hide zxf2, script hide z_obj186, script hide z_obj187, script hide z_obj188, script hide z_obj189",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-197",
     "maxclass": "message",
     "patching_rect": [
      1380,
      428,
      120,
      22
     ],
     "text": "script hide g_obj3, script hide g_obj4, script hide g_obj5, script hide Attack, script hide Decay, script hide Sustain, script hide Release, script hide Spread, script hide Transpose, script hide VelVol, script hide g_obj111, script hide ChordWindow, script hide Seed, script hide SeedValue, script hide g_obj115, script hide g_obj129, script hide PBRange, script hide s_obj160, script hide s_obj161, script hide SoundVolume, script hide SoundTranspose, script hide SoloBtn, script show Zones, script show Crossfade, script show z_obj174, script show z_obj175, script show z_obj178, script show z_obj179, script show z_obj180, script show z_obj181, script show z_obj182, script show z_obj183, script show zxf1, script show zxf2, script show z_obj186, script show z_obj187, script show z_obj188, script show z_obj189",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-198",
     "maxclass": "newobj",
     "patching_rect": [
      1380,
      462,
      120,
      22
     ],
     "text": "t b b b b b b b b b b b b b b b",
     "numinlets": 1,
     "numoutlets": 15,
     "outlettype": [
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-199",
     "maxclass": "message",
     "patching_rect": [
      1380,
      496,
      120,
      22
     ],
     "text": "init",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-200",
     "maxclass": "comment",
     "patching_rect": [
      600,
      5,
      500,
      20
     ],
     "text": "multiKey main patcher - generated by tools/build_device.py. Edit the script, not this file.",
     "numinlets": 1,
     "numoutlets": 0
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-6",
      0
     ],
     "destination": [
      "obj-7",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-7",
      1
     ],
     "destination": [
      "obj-8",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-8",
      0
     ],
     "destination": [
      "obj-9",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      2
     ],
     "destination": [
      "obj-15",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-15",
      0
     ],
     "destination": [
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      1
     ],
     "destination": [
      "obj-11",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-11",
      0
     ],
     "destination": [
      "obj-13",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      0
     ],
     "destination": [
      "obj-10",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-10",
      0
     ],
     "destination": [
      "obj-12",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-7",
      0
     ],
     "destination": [
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-14",
      0
     ],
     "destination": [
      "obj-16",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-16",
      2
     ],
     "destination": [
      "obj-13",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-13",
      0
     ],
     "destination": [
      "obj-17",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-16",
      1
     ],
     "destination": [
      "obj-18",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-18",
      1
     ],
     "destination": [
      "obj-17",
      3
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-18",
      0
     ],
     "destination": [
      "obj-17",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-16",
      0
     ],
     "destination": [
      "obj-12",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-12",
      0
     ],
     "destination": [
      "obj-17",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-17",
      0
     ],
     "destination": [
      "obj-19",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-19",
      1
     ],
     "destination": [
      "obj-20",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-20",
      0
     ],
     "destination": [
      "obj-21",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-19",
      0
     ],
     "destination": [
      "obj-22",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-21",
      0
     ],
     "destination": [
      "obj-22",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-22",
      1
     ],
     "destination": [
      "obj-23",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-22",
      0
     ],
     "destination": [
      "obj-24",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-24",
      1
     ],
     "destination": [
      "obj-25",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-19",
      2
     ],
     "destination": [
      "obj-26",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-26",
      1
     ],
     "destination": [
      "obj-27",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-26",
      0
     ],
     "destination": [
      "obj-28",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-25",
      0
     ],
     "destination": [
      "obj-29",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-29",
      0
     ],
     "destination": [
      "obj-30",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-30",
      0
     ],
     "destination": [
      "obj-32",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-32",
      0
     ],
     "destination": [
      "obj-31",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-30",
      1
     ],
     "destination": [
      "obj-33",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-33",
      0
     ],
     "destination": [
      "obj-34",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-23",
      0
     ],
     "destination": [
      "obj-35",
      6
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-35",
      0
     ],
     "destination": [
      "obj-36",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-36",
      0
     ],
     "destination": [
      "obj-31",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-34",
      1
     ],
     "destination": [
      "obj-37",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-37",
      1
     ],
     "destination": [
      "obj-38",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-38",
      0
     ],
     "destination": [
      "obj-39",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-39",
      0
     ],
     "destination": [
      "obj-35",
      3
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-37",
      0
     ],
     "destination": [
      "obj-40",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-37",
      0
     ],
     "destination": [
      "obj-41",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-34",
      0
     ],
     "destination": [
      "obj-42",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-42",
      3
     ],
     "destination": [
      "obj-43",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-42",
      2
     ],
     "destination": [
      "obj-44",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-44",
      0
     ],
     "destination": [
      "obj-45",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-45",
      0
     ],
     "destination": [
      "obj-35",
      5
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-43",
      0
     ],
     "destination": [
      "obj-35",
      4
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-42",
      1
     ],
     "destination": [
      "obj-35",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-42",
      0
     ],
     "destination": [
      "obj-40",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-40",
      0
     ],
     "destination": [
      "obj-35",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-42",
      4
     ],
     "destination": [
      "obj-46",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-46",
      1
     ],
     "destination": [
      "obj-47",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-47",
      0
     ],
     "destination": [
      "obj-48",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-48",
      2
     ],
     "destination": [
      "obj-49",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-49",
      0
     ],
     "destination": [
      "obj-47",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-46",
      0
     ],
     "destination": [
      "obj-41",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-41",
      0
     ],
     "destination": [
      "obj-50",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-50",
      0
     ],
     "destination": [
      "obj-51",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-51",
      1
     ],
     "destination": [
      "obj-52",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-52",
      0
     ],
     "destination": [
      "obj-53",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-53",
      0
     ],
     "destination": [
      "obj-54",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-51",
      0
     ],
     "destination": [
      "obj-54",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-54",
      0
     ],
     "destination": [
      "obj-55",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-55",
      0
     ],
     "destination": [
      "obj-56",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-56",
      1
     ],
     "destination": [
      "obj-57",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-57",
      0
     ],
     "destination": [
      "obj-58",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-56",
      0
     ],
     "destination": [
      "obj-58",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-60",
      0
     ],
     "destination": [
      "obj-59",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-61",
      0
     ],
     "destination": [
      "obj-60",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-48",
      0
     ],
     "destination": [
      "obj-62",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-58",
      0
     ],
     "destination": [
      "obj-63",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-62",
      0
     ],
     "destination": [
      "obj-63",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-63",
      0
     ],
     "destination": [
      "obj-64",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-64",
      0
     ],
     "destination": [
      "obj-61",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-63",
      1
     ],
     "destination": [
      "obj-65",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-65",
      1
     ],
     "destination": [
      "obj-66",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-66",
      0
     ],
     "destination": [
      "obj-63",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-65",
      0
     ],
     "destination": [
      "obj-63",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-58",
      1
     ],
     "destination": [
      "obj-67",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-62",
      0
     ],
     "destination": [
      "obj-67",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-67",
      0
     ],
     "destination": [
      "obj-68",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-68",
      0
     ],
     "destination": [
      "obj-61",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-67",
      1
     ],
     "destination": [
      "obj-69",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-69",
      1
     ],
     "destination": [
      "obj-70",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-70",
      0
     ],
     "destination": [
      "obj-67",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-69",
      0
     ],
     "destination": [
      "obj-67",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-58",
      2
     ],
     "destination": [
      "obj-71",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-62",
      0
     ],
     "destination": [
      "obj-71",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-71",
      0
     ],
     "destination": [
      "obj-72",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-72",
      0
     ],
     "destination": [
      "obj-61",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-71",
      1
     ],
     "destination": [
      "obj-73",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-73",
      1
     ],
     "destination": [
      "obj-74",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-74",
      0
     ],
     "destination": [
      "obj-71",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-73",
      0
     ],
     "destination": [
      "obj-71",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-58",
      3
     ],
     "destination": [
      "obj-75",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-62",
      0
     ],
     "destination": [
      "obj-75",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-75",
      0
     ],
     "destination": [
      "obj-76",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-76",
      0
     ],
     "destination": [
      "obj-61",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-75",
      1
     ],
     "destination": [
      "obj-77",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-77",
      1
     ],
     "destination": [
      "obj-78",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-78",
      0
     ],
     "destination": [
      "obj-75",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-77",
      0
     ],
     "destination": [
      "obj-75",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-59",
      1
     ],
     "destination": [
      "obj-79",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-79",
      0
     ],
     "destination": [
      "obj-80",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-80",
      1
     ],
     "destination": [
      "obj-39",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-80",
      0
     ],
     "destination": [
      "obj-43",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-59",
      0
     ],
     "destination": [
      "obj-35",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-48",
      1
     ],
     "destination": [
      "obj-81",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-81",
      0
     ],
     "destination": [
      "obj-82",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-82",
      0
     ],
     "destination": [
      "obj-83",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-83",
      7
     ],
     "destination": [
      "obj-84",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-84",
      0
     ],
     "destination": [
      "obj-85",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-85",
      0
     ],
     "destination": [
      "obj-86",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-86",
      0
     ],
     "destination": [
      "obj-63",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-86",
      0
     ],
     "destination": [
      "obj-67",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-86",
      0
     ],
     "destination": [
      "obj-71",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-86",
      0
     ],
     "destination": [
      "obj-75",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-86",
      0
     ],
     "destination": [
      "obj-52",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-86",
      0
     ],
     "destination": [
      "obj-44",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-88",
      0
     ],
     "destination": [
      "obj-89",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-89",
      0
     ],
     "destination": [
      "obj-91",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-90",
      0
     ],
     "destination": [
      "obj-91",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-91",
      0
     ],
     "destination": [
      "obj-82",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-31",
      0
     ],
     "destination": [
      "obj-93",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-31",
      1
     ],
     "destination": [
      "obj-94",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-93",
      0
     ],
     "destination": [
      "obj-92",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-94",
      0
     ],
     "destination": [
      "obj-92",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-92",
      0
     ],
     "destination": [
      "obj-95",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-92",
      1
     ],
     "destination": [
      "obj-95",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-97",
      0
     ],
     "destination": [
      "obj-104",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-104",
      0
     ],
     "destination": [
      "obj-96",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-98",
      0
     ],
     "destination": [
      "obj-105",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-105",
      0
     ],
     "destination": [
      "obj-96",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-100",
      0
     ],
     "destination": [
      "obj-106",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-106",
      0
     ],
     "destination": [
      "obj-96",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-99",
      0
     ],
     "destination": [
      "obj-107",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-107",
      0
     ],
     "destination": [
      "obj-108",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-108",
      0
     ],
     "destination": [
      "obj-96",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-103",
      0
     ],
     "destination": [
      "obj-109",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-109",
      0
     ],
     "destination": [
      "obj-43",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-101",
      0
     ],
     "destination": [
      "obj-110",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-110",
      0
     ],
     "destination": [
      "obj-45",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-102",
      0
     ],
     "destination": [
      "obj-38",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-112",
      0
     ],
     "destination": [
      "obj-49",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-113",
      0
     ],
     "destination": [
      "obj-81",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-114",
      0
     ],
     "destination": [
      "obj-85",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-115",
      0
     ],
     "destination": [
      "obj-116",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-116",
      0
     ],
     "destination": [
      "obj-117",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-116",
      1
     ],
     "destination": [
      "obj-117",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-117",
      0
     ],
     "destination": [
      "obj-118",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-118",
      0
     ],
     "destination": [
      "obj-114",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-27",
      0
     ],
     "destination": [
      "obj-119",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-28",
      0
     ],
     "destination": [
      "obj-119",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-119",
      0
     ],
     "destination": [
      "obj-120",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-120",
      0
     ],
     "destination": [
      "obj-121",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-121",
      0
     ],
     "destination": [
      "obj-123",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-123",
      0
     ],
     "destination": [
      "obj-124",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-124",
      0
     ],
     "destination": [
      "obj-122",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-121",
      1
     ],
     "destination": [
      "obj-125",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-125",
      1
     ],
     "destination": [
      "obj-126",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-126",
      0
     ],
     "destination": [
      "obj-127",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-125",
      0
     ],
     "destination": [
      "obj-127",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-127",
      0
     ],
     "destination": [
      "obj-128",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-128",
      0
     ],
     "destination": [
      "obj-122",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-130",
      0
     ],
     "destination": [
      "obj-123",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      8
     ],
     "destination": [
      "obj-61",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      7
     ],
     "destination": [
      "obj-50",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      6
     ],
     "destination": [
      "obj-136",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      0
     ],
     "destination": [
      "obj-63",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      4
     ],
     "destination": [
      "obj-64",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      1
     ],
     "destination": [
      "obj-67",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      5
     ],
     "destination": [
      "obj-68",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      2
     ],
     "destination": [
      "obj-71",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      6
     ],
     "destination": [
      "obj-72",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      3
     ],
     "destination": [
      "obj-75",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-136",
      7
     ],
     "destination": [
      "obj-76",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      3
     ],
     "destination": [
      "obj-79",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      4
     ],
     "destination": [
      "obj-131",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-132",
      1
     ],
     "destination": [
      "obj-138",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-132",
      0
     ],
     "destination": [
      "obj-137",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-138",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-137",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-139",
      0
     ],
     "destination": [
      "obj-140",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-140",
      0
     ],
     "destination": [
      "obj-141",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-140",
      1
     ],
     "destination": [
      "obj-141",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-141",
      0
     ],
     "destination": [
      "obj-142",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-142",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-143",
      0
     ],
     "destination": [
      "obj-144",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-144",
      0
     ],
     "destination": [
      "obj-145",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-144",
      1
     ],
     "destination": [
      "obj-145",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-145",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-146",
      0
     ],
     "destination": [
      "obj-147",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-147",
      0
     ],
     "destination": [
      "obj-148",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-147",
      1
     ],
     "destination": [
      "obj-148",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-148",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-149",
      0
     ],
     "destination": [
      "obj-150",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-150",
      0
     ],
     "destination": [
      "obj-151",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-150",
      1
     ],
     "destination": [
      "obj-151",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-151",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      1
     ],
     "destination": [
      "obj-152",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-152",
      0
     ],
     "destination": [
      "obj-153",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-153",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      0
     ],
     "destination": [
      "obj-155",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-155",
      0
     ],
     "destination": [
      "obj-156",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-156",
      1
     ],
     "destination": [
      "obj-157",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-157",
      0
     ],
     "destination": [
      "obj-33",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      2
     ],
     "destination": [
      "obj-158",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-158",
      0
     ],
     "destination": [
      "obj-159",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-159",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-164",
      0
     ],
     "destination": [
      "obj-166",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-166",
      0
     ],
     "destination": [
      "obj-167",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-166",
      1
     ],
     "destination": [
      "obj-167",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-167",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-165",
      0
     ],
     "destination": [
      "obj-168",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-168",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-162",
      0
     ],
     "destination": [
      "obj-169",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-163",
      0
     ],
     "destination": [
      "obj-170",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-169",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-170",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-135",
      5
     ],
     "destination": [
      "obj-171",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      0
     ],
     "destination": [
      "obj-160",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      1
     ],
     "destination": [
      "obj-162",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      2
     ],
     "destination": [
      "obj-163",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      3
     ],
     "destination": [
      "obj-154",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      5
     ],
     "destination": [
      "obj-60",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      6
     ],
     "destination": [
      "obj-31",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      7
     ],
     "destination": [
      "obj-165",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-172",
      0
     ],
     "destination": [
      "obj-176",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-173",
      0
     ],
     "destination": [
      "obj-177",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-176",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-177",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-190",
      0
     ],
     "destination": [
      "obj-191",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-191",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-192",
      0
     ],
     "destination": [
      "obj-193",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-193",
      0
     ],
     "destination": [
      "obj-195",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-195",
      0
     ],
     "destination": [
      "obj-194",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-193",
      1
     ],
     "destination": [
      "obj-196",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-196",
      0
     ],
     "destination": [
      "obj-194",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-193",
      2
     ],
     "destination": [
      "obj-197",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-197",
      0
     ],
     "destination": [
      "obj-194",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-171",
      4
     ],
     "destination": [
      "obj-194",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-87",
      0
     ],
     "destination": [
      "obj-198",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-199",
      0
     ],
     "destination": [
      "obj-135",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      14
     ],
     "destination": [
      "obj-192",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      13
     ],
     "destination": [
      "obj-172",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      12
     ],
     "destination": [
      "obj-190",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      11
     ],
     "destination": [
      "obj-173",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      10
     ],
     "destination": [
      "obj-199",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      9
     ],
     "destination": [
      "obj-97",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      8
     ],
     "destination": [
      "obj-98",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      7
     ],
     "destination": [
      "obj-99",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      6
     ],
     "destination": [
      "obj-100",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      5
     ],
     "destination": [
      "obj-103",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      4
     ],
     "destination": [
      "obj-102",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      3
     ],
     "destination": [
      "obj-101",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      2
     ],
     "destination": [
      "obj-130",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      1
     ],
     "destination": [
      "obj-88",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-198",
      0
     ],
     "destination": [
      "obj-90",
      0
     ]
    }
   }
  ],
  "openinpresentation": 1,
  "devicewidth": 720.0,
  "latency": 0,
  "is_mpe": 1,
  "external_mpe_tuning_enabled": 0,
  "minimum_live_version": "",
  "minimum_max_version": "",
  "platform_compatibility": 0,
  "project": {
   "version": 1,
   "creationdate": 3877494390,
   "modificationdate": 3877494390,
   "viewrect": [
    0.0,
    0.0,
    300.0,
    500.0
   ],
   "autoorganize": 1,
   "hideprojectwindow": 1,
   "showdependencies": 1,
   "autolocalize": 0,
   "contents": {
    "patchers": {}
   },
   "layout": {},
   "searchpath": {},
   "detailsvisible": 0,
   "amxdtype": 1768515945,
   "readonly": 0,
   "devpathtype": 0,
   "devpath": ".",
   "sortmode": 0,
   "viewmode": 0,
   "includepackages": 0
  },
  "dependency_cache": [
   {
    "name": "multikey.voice.maxpat",
    "bootpath": ".",
    "type": "JSON",
    "implicit": 1
   },
   {
    "name": "multikey_loader.js",
    "bootpath": ".",
    "type": "TEXT",
    "implicit": 1
   }
  ]
 }
}