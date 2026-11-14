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
      120,
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
      100,
      9,
      40,
      16
     ],
     "text": "v0.2",
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
      200,
      8,
      120,
      16
     ],
     "text": "ENVELOPE",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1
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
      390,
      8,
      80,
      16
     ],
     "text": "PLAY",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1
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
      485,
      8,
      80,
      16
     ],
     "text": "RANDOM",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0,
     "fontface": 1
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
     "text": "notein",
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
     "id": "obj-7",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      224,
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
     "id": "obj-8",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      258,
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
     "id": "obj-9",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      292,
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
     "id": "obj-10",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      326,
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
     "id": "obj-11",
     "maxclass": "message",
     "patching_rect": [
      20,
      360,
      120,
      22
     ],
     "text": "midinote $1 0 0 0 0 0",
     "numinlets": 2,
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
     "id": "obj-13",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      428,
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
     "id": "obj-14",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      462,
      120,
      22
     ],
     "text": "pack 0 0 0 0. 0. 0.",
     "numinlets": 6,
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
     "id": "obj-16",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      530,
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
     "id": "obj-17",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      564,
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
     "id": "obj-18",
     "maxclass": "newobj",
     "patching_rect": [
      20,
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
     "id": "obj-19",
     "maxclass": "newobj",
     "patching_rect": [
      20,
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
     "id": "obj-20",
     "maxclass": "newobj",
     "patching_rect": [
      20,
      666,
      120,
      22
     ],
     "text": "expr (1.-$f2) + $f2*pow($f1/127.\\, 1.5)",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
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
     "id": "obj-22",
     "maxclass": "newobj",
     "patching_rect": [
      20,
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
     "id": "obj-23",
     "maxclass": "newobj",
     "patching_rect": [
      20,
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
     "id": "obj-24",
     "maxclass": "newobj",
     "patching_rect": [
      190,
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
     "id": "obj-25",
     "maxclass": "newobj",
     "patching_rect": [
      190,
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
     "id": "obj-26",
     "maxclass": "newobj",
     "patching_rect": [
      190,
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
     "id": "obj-27",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      122,
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
     "id": "obj-28",
     "maxclass": "message",
     "patching_rect": [
      190,
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
     "id": "obj-29",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      190,
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
     "id": "obj-32",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      292,
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
     "id": "obj-35",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      394,
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
     "id": "obj-36",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      428,
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
     "id": "obj-37",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      462,
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
     "id": "obj-38",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      496,
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
     "id": "obj-39",
     "maxclass": "message",
     "patching_rect": [
      190,
      530,
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
     "id": "obj-40",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      564,
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
     "id": "obj-41",
     "maxclass": "message",
     "patching_rect": [
      190,
      598,
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
     "id": "obj-42",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      632,
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
     "id": "obj-43",
     "maxclass": "live.gain~",
     "patching_rect": [
      190,
      666,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      600,
      6,
      42,
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
     "id": "obj-44",
     "maxclass": "newobj",
     "patching_rect": [
      190,
      700,
      120,
      22
     ],
     "text": "*~ 0.447",
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
     "text": "*~ 0.447",
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
     "id": "obj-47",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      20,
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
     "id": "obj-48",
     "maxclass": "live.dial",
     "patching_rect": [
      360,
      54,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      195,
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
     "id": "obj-49",
     "maxclass": "live.dial",
     "patching_rect": [
      360,
      88,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      240,
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
     "id": "obj-50",
     "maxclass": "live.dial",
     "patching_rect": [
      360,
      122,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      285,
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
     "id": "obj-51",
     "maxclass": "live.dial",
     "patching_rect": [
      360,
      156,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      330,
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
     "id": "obj-52",
     "maxclass": "live.dial",
     "patching_rect": [
      360,
      190,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      385,
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
     "id": "obj-53",
     "maxclass": "live.dial",
     "patching_rect": [
      360,
      224,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      385,
      90,
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
     "id": "obj-54",
     "maxclass": "live.dial",
     "patching_rect": [
      360,
      258,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      430,
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
     "id": "obj-55",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      292,
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
     "id": "obj-56",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      326,
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
     "id": "obj-57",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      360,
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
     "id": "obj-58",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      394,
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
     "id": "obj-59",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      428,
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
     "id": "obj-60",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      462,
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
     "id": "obj-61",
     "maxclass": "newobj",
     "patching_rect": [
      360,
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
     "id": "obj-62",
     "maxclass": "comment",
     "patching_rect": [
      360,
      530,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      485,
      24,
      80,
      16
     ],
     "text": "Chord window",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0
    }
   },
   {
    "box": {
     "id": "obj-63",
     "maxclass": "live.numbox",
     "patching_rect": [
      360,
      564,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      485,
      40,
      50,
      15
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Chord Window",
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
     "id": "obj-64",
     "maxclass": "live.text",
     "patching_rect": [
      360,
      598,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      485,
      66,
      50,
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
     "id": "obj-65",
     "maxclass": "live.numbox",
     "patching_rect": [
      360,
      632,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      540,
      66,
      50,
      16
     ],
     "numinlets": 1,
     "numoutlets": 2,
     "outlettype": [
      "",
      "float"
     ],
     "parameter_enable": 1,
     "varname": "Seed Value",
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
     "id": "obj-66",
     "maxclass": "live.text",
     "patching_rect": [
      360,
      666,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      485,
      86,
      105,
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
     "text": "Re-roll"
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
     "id": "obj-68",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      734,
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
     "id": "obj-69",
     "maxclass": "newobj",
     "patching_rect": [
      360,
      768,
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
     "id": "obj-70",
     "maxclass": "panel",
     "patching_rect": [
      530,
      20,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      28,
      176,
      60
     ],
     "numinlets": 1,
     "numoutlets": 0,
     "bgcolor": [
      0.2,
      0.2,
      0.2,
      1.0
     ],
     "rounded": 4,
     "background": 1
    }
   },
   {
    "box": {
     "id": "obj-71",
     "maxclass": "comment",
     "patching_rect": [
      530,
      54,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      16,
      50,
      170,
      16
     ],
     "text": "Drop a folder of one-shots here",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0
    }
   },
   {
    "box": {
     "id": "obj-72",
     "maxclass": "dropfile",
     "patching_rect": [
      530,
      88,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      28,
      176,
      60
     ],
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
     "id": "obj-73",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      122,
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
     "id": "obj-74",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      156,
      120,
      22
     ],
     "text": "js multikey_loader.js ---mkpool",
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
     "id": "obj-75",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      190,
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
     "id": "obj-76",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      224,
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
     "id": "obj-77",
     "maxclass": "live.text",
     "patching_rect": [
      530,
      258,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      92,
      80,
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
     "id": "obj-78",
     "maxclass": "newobj",
     "patching_rect": [
      530,
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
     "id": "obj-79",
     "maxclass": "message",
     "patching_rect": [
      530,
      326,
      120,
      22
     ],
     "text": "loadfolder",
     "numinlets": 2,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-80",
     "maxclass": "live.text",
     "patching_rect": [
      530,
      360,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      92,
      92,
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
     "text": "Add file"
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
     "id": "obj-82",
     "maxclass": "message",
     "patching_rect": [
      530,
      428,
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
     "id": "obj-83",
     "maxclass": "live.text",
     "patching_rect": [
      530,
      462,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      146,
      92,
      38,
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
     "id": "obj-84",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      496,
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
     "id": "obj-85",
     "maxclass": "message",
     "patching_rect": [
      530,
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
     "id": "obj-86",
     "maxclass": "umenu",
     "patching_rect": [
      530,
      564,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      112,
      176,
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
     "id": "obj-87",
     "maxclass": "comment",
     "patching_rect": [
      530,
      598,
      120,
      22
     ],
     "presentation": 1,
     "presentation_rect": [
      8,
      134,
      176,
      16
     ],
     "text": "0 samples",
     "numinlets": 1,
     "numoutlets": 0,
     "fontsize": 9.0
    }
   },
   {
    "box": {
     "id": "obj-88",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      632,
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
     "id": "obj-89",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      666,
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
     "id": "obj-90",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      700,
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
     "id": "obj-91",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      734,
      120,
      22
     ],
     "text": "sprintf set %ld samples (all assumed C3)",
     "numinlets": 1,
     "numoutlets": 1,
     "outlettype": [
      ""
     ]
    }
   },
   {
    "box": {
     "id": "obj-92",
     "maxclass": "newobj",
     "patching_rect": [
      530,
      768,
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
     "parameter_enable": 1,
     "varname": "mkfiles",
     "saved_attribute_attributes": {
      "valueof": {
       "parameter_longname": "mkfiles",
       "parameter_shortname": "mkfiles",
       "parameter_type": 3,
       "parameter_mmin": 0.0,
       "parameter_mmax": 1.0,
       "parameter_initial": [
        0.0
       ],
       "parameter_initial_enable": 1,
       "parameter_unitstyle": 1,
       "parameter_invisible": 1
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
     "id": "obj-94",
     "maxclass": "newobj",
     "patching_rect": [
      700,
      54,
      120,
      22
     ],
     "text": "t b b b b b b b b b b",
     "numinlets": 1,
     "numoutlets": 10,
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
      "bang"
     ]
    }
   },
   {
    "box": {
     "id": "obj-95",
     "maxclass": "message",
     "patching_rect": [
      700,
      88,
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
     "id": "obj-96",
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
      "obj-6",
      1
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
      "obj-7",
      0
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
      "obj-11",
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
      "obj-9",
      1
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
      "obj-12",
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
      "obj-14",
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
      "obj-15",
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
      "obj-13",
      1
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
      1
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
      "obj-14",
      3
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
      "obj-18",
      1
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
      "obj-19",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-19",
      3
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
      "obj-19",
      2
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
      0
     ],
     "destination": [
      "obj-14",
      5
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
      "obj-14",
      4
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
      "obj-14",
      1
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
      "obj-14",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-19",
      4
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
      "obj-25",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-25",
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
      0
     ],
     "destination": [
      "obj-24",
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
      "obj-27",
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
      "obj-27",
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
      "obj-14",
      2
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
      "obj-27",
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
      "obj-27",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-25",
      1
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
      "obj-32",
      0
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
      "obj-34",
      7
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
      "obj-27",
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
      "obj-21",
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
      "obj-42",
      0
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
      "obj-33",
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
      "obj-44",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-10",
      1
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
      "obj-44",
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
      "obj-45",
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
      "obj-43",
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
      "obj-43",
      1
     ],
     "destination": [
      "obj-46",
      1
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
      "obj-47",
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
      "obj-56",
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
      "obj-47",
      0
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
      "obj-47",
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
      "obj-58",
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
      "obj-59",
      0
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
      "obj-47",
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
      "obj-60",
      0
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
      "obj-20",
      1
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
      "obj-61",
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
      "obj-22",
      1
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
      "obj-17",
      1
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
      "obj-26",
      1
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
      "obj-32",
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
      "obj-36",
      1
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
      "obj-67",
      1
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
      "obj-69",
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
      "obj-65",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-72",
      1
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
      "obj-72",
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
      "obj-76",
      0
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
      "obj-75",
      0
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
      "obj-77",
      0
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
      "obj-79",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-78",
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
      "obj-74",
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
      "obj-81",
      0
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
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-81",
      1
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
      "obj-82",
      0
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
      "obj-83",
      0
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
      "obj-84",
      1
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
      "obj-74",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-74",
      1
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
      "obj-74",
      0
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
      2
     ],
     "destination": [
      "obj-27",
      1
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-89",
      1
     ],
     "destination": [
      "obj-90",
      0
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
      "obj-12",
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
      "obj-87",
      0
     ]
    }
   },
   {
    "patchline": {
     "source": [
      "obj-74",
      2
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
      "obj-92",
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
      "obj-93",
      0
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
      "obj-38",
      0
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
      "obj-94",
      9
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
      "obj-95",
      0
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
      "obj-94",
      8
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
      "obj-94",
      7
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
      "obj-94",
      6
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
      "obj-94",
      5
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
      "obj-94",
      4
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
      "obj-94",
      3
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
      "obj-94",
      2
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
      "obj-94",
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
      "obj-94",
      0
     ],
     "destination": [
      "obj-41",
      0
     ]
    }
   }
  ],
  "openinpresentation": 1,
  "devicewidth": 650.0,
  "latency": 0,
  "is_mpe": 0,
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