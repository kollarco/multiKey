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
     "maxclass": "newobj",
     "patching_rect": [
      20,
      20,
      120,
      22
     ],
     "text": "in 1",
     "numinlets": 0,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-2",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      54,
      120,
      22
     ],
     "text": "unpack 0 0 0 0. 0. 0. 0",
     "numinlets": 1,
     "numoutlets": 7,
     "outlettype": [
      "int",
      "int",
      "int",
      "float",
      "float",
      "float",
      "int"
     ]
    }
   },
   {
    "box": {
     "id": "obj-3",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      88,
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
     "id": "obj-4",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      122,
      120,
      22
     ],
     "text": "f",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
     ]
    }
   },
   {
    "box": {
     "id": "obj-5",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      156,
      120,
      22
     ],
     "text": "f",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
     ]
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
     "text": "expr pow(2.\\, $f1/12.)",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
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
     "text": "f",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
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
     "text": "sel 0",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
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
     "text": "t b b b b b i",
     "numinlets": 1,
     "numoutlets": 6,
     "outlettype": [
      "bang",
      "bang",
      "bang",
      "bang",
      "bang",
      "int"
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
     "text": "sprintf set #1.%ld",
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
     "text": "groove~ #1.1 2 @loop 0",
     "numinlets": 3,
     "numoutlets": 3,
     "outlettype": [
      "signal",
      "signal",
      "signal"
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
     "text": "info~ #1.1",
     "numinlets": 1,
     "numoutlets": 11,
     "outlettype": [
      "",
      "",
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
     "id": "obj-13",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      428,
      120,
      22
     ],
     "text": "t f f",
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
     "id": "obj-14",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      462,
      120,
      22
     ],
     "text": "expr min(1.\\, 1.41421*cos(($f1+1.)*0.785398))",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-15",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      496,
      120,
      22
     ],
     "text": "expr min(1.\\, 1.41421*sin(($f1+1.)*0.785398))",
     "numinlets": 1,
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
     "text": "sig~ 1.",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "pak 0. 0.",
     "numinlets": 2,
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
     "text": "expr pow(2.\\, ($f1+$f2)/12.)",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-19",
     "maxclass": "message",
     "patching_rect": [
      20,
      632,
      120,
      22
     ],
     "text": "$1 3",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
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
     "text": "line~ 1.",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "signal",
      "bang"
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
     "text": "*~",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "== 0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
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
     "text": "t i b",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-24",
     "maxclass": "message",
     "patching_rect": [
      190,
      20,
      120,
      22
     ],
     "text": "0.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
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
     "text": "r #1-bend",
     "numinlets": 0,
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
     "text": "route note master",
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
     "id": "obj-27",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      122,
      120,
      22
     ],
     "text": "unpack 0 0.",
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "int",
      "float"
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
     "text": "f",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "float"
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
     "text": "sel 1",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
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
     "id": "obj-31",
     "maxclass": "message",
     "patching_rect": [
      190,
      258,
      120,
      22
     ],
     "text": "0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-32",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      292,
      120,
      22
     ],
     "text": "adsr~ 1 600 1. 250",
     "numinlets": 5,
     "numoutlets": 4,
     "outlettype": [
      "signal",
      "signal",
      "",
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
     "text": "sel 0",
     "numinlets": 2,
     "numoutlets": 2,
     "outlettype": [
      "bang",
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-34",
     "maxclass": "message",
     "patching_rect": [
      190,
      360,
      120,
      22
     ],
     "text": "0",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-35",
     "maxclass": "message",
     "patching_rect": [
      190,
      394,
      120,
      22
     ],
     "text": "0",
     "numinlets": 2,
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
     "text": "r #1-params",
     "numinlets": 0,
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
     "text": "route attack decay sustain release",
     "numinlets": 1,
     "numoutlets": 5,
     "outlettype": [
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
     "id": "obj-38",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      496,
      120,
      22
     ],
     "text": "thispoly~",
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
     "id": "obj-39",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      530,
      120,
      22
     ],
     "text": "== 1",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "int"
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
     "text": "*~ 0.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "+~",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "*~",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "*~",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "*~ 1.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "*~ 1.",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      "signal"
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
     "text": "out~ 1",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": []
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
     "text": "out~ 2",
     "numinlets": 1,
     "numoutlets": 0,
     "outlettype": []
    }
   },
   {
    "box": {
     "id": "obj-48",
     "maxclass": "comment",
     "patching_rect": [
      400,
      10,
      400,
      20
     ],
     "text": "multiKey voice. #1 = pool name. Input: pitch vel index semitones amp pan channel",
     "numinlets": 1,
     "numoutlets": 0
    }
   }
  ],
  "lines": [
   {
    "patchline": {
     "source": [
      "obj-1",
      0
     ],
     "destination": [
      "obj-2",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-2",
      6
     ],
     "destination": [
      "obj-3",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-2",
      5
     ],
     "destination": [
      "obj-4",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-2",
      4
     ],
     "destination": [
      "obj-5",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-2",
      3
     ],
     "destination": [
      "obj-6",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-6",
      0
     ],
     "destination": [
      "obj-7",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-2",
      2
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
      1
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
      5
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
      "obj-11",
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
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-9",
      4
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
      "obj-9",
      3
     ],
     "destination": [
      "obj-4",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-4",
      0
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
      1
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
      "obj-13",
      0
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
      "obj-9",
      2
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
      "obj-17",
      0
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
      0
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
      "obj-16",
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
      "obj-20",
      0
     ],
     "destination": [
      "obj-21",
      1
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
      "obj-11",
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
      "obj-3",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-3",
      0
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
      "obj-23",
      1
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
      "obj-23",
      0
     ],
     "destination": [
      "obj-22",
      1
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
      "obj-17",
      1
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
      "obj-27",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-27",
      1
     ],
     "destination": [
      "obj-28",
      1
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
      "obj-22",
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
      "obj-28",
      0
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
      "obj-17",
      0
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
      "obj-30",
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
      "obj-31",
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
      "obj-11",
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
      "obj-5",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-5",
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
      "obj-2",
      1
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
      "obj-33",
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
      "obj-35",
      0
     ],
     "destination": [
      "obj-22",
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
      "obj-32",
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
      "obj-37",
      0
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
      "obj-32",
      1
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
      "obj-32",
      2
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-37",
      2
     ],
     "destination": [
      "obj-32",
      3
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-37",
      3
     ],
     "destination": [
      "obj-32",
      4
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
      "obj-38",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-12",
      8
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
      "obj-39",
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
      "obj-11",
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
      "obj-11",
      1
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
      "obj-40",
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
      "obj-11",
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
      "obj-32",
      0
     ],
     "destination": [
      "obj-42",
      1
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
      "obj-43",
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
      "obj-43",
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
      "obj-44",
      0
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
      "obj-45",
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
      "obj-44",
      1
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
      "obj-45",
      1
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
      "obj-46",
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
      "obj-47",
      0
     ]
    }
   }
  ]
 }
}