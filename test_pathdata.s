
test_paths_data_table::
     DW test_path_00
     DW test_path_01
     DW test_path_02
     DW test_path_03
     DW test_path_04
     DW test_path_05
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0
     DW 0


test_path_00::
  DB  $05               ;; number of nodes

  DB  $08              ;; direction
  DW  $0020              ;; distance
  DB  $01              ;; xpos
  DB  $14              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $04              ;; direction
  DW  $0020              ;; distance
  DB  $01              ;; xpos
  DB  $18              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $00              ;; direction
  DW  $0020              ;; distance
  DB  $05              ;; xpos
  DB  $18              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $04              ;; direction
  DW  $0020              ;; distance
  DB  $05              ;; xpos
  DB  $14              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0C              ;; direction
  DW  $0000              ;; distance
  DB  $0B              ;; xpos
  DB  $14              ;; ypos
  DB  $02              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2



test_path_01::
  DB  $05               ;; number of nodes

  DB  $0C              ;; direction
  DW  $0020              ;; distance
  DB  $15              ;; xpos
  DB  $0C              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $00              ;; direction
  DW  $0020              ;; distance
  DB  $11              ;; xpos
  DB  $0C              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $02              ;; direction
  DW  $0017              ;; distance
  DB  $11              ;; xpos
  DB  $05              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $06              ;; direction
  DW  $0017              ;; distance
  DB  $13              ;; xpos
  DB  $03              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $08              ;; direction
  DW  $0020              ;; distance
  DB  $15              ;; xpos
  DB  $05              ;; ypos
  DB  $01              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2



test_path_02::
  DB  $06               ;; number of nodes

  DB  $04              ;; direction
  DW  $0060              ;; distance
  DB  $2D              ;; xpos
  DB  $14              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $06              ;; direction
  DW  $004A              ;; distance
  DB  $34              ;; xpos
  DB  $14              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0A              ;; direction
  DW  $002B              ;; distance
  DB  $36              ;; xpos
  DB  $16              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0C              ;; direction
  DW  $0010              ;; distance
  DB  $34              ;; xpos
  DB  $18              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0E              ;; direction
  DW  $002B              ;; distance
  DB  $2D              ;; xpos
  DB  $18              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $02              ;; direction
  DW  $0017              ;; distance
  DB  $2B              ;; xpos
  DB  $16              ;; ypos
  DB  $01              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2



test_path_03::
  DB  $04               ;; number of nodes

  DB  $0C              ;; direction
  DW  $0020              ;; distance
  DB  $18              ;; xpos
  DB  $29              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0E              ;; direction
  DW  $002B              ;; distance
  DB  $15              ;; xpos
  DB  $29              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $00              ;; direction
  DW  $0040              ;; distance
  DB  $13              ;; xpos
  DB  $27              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $08              ;; direction
  DW  $0010              ;; distance
  DB  $13              ;; xpos
  DB  $23              ;; ypos
  DB  $02              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2



test_path_04::
  DB  $04               ;; number of nodes

  DB  $08              ;; direction
  DW  $0040              ;; distance
  DB  $24              ;; xpos
  DB  $23              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0A              ;; direction
  DW  $002B              ;; distance
  DB  $24              ;; xpos
  DB  $27              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0C              ;; direction
  DW  $0018              ;; distance
  DB  $22              ;; xpos
  DB  $29              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $04              ;; direction
  DW  $0010              ;; distance
  DB  $1E              ;; xpos
  DB  $29              ;; ypos
  DB  $02              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2



test_path_05::
  DB  $06               ;; number of nodes

  DB  $04              ;; direction
  DW  $0020              ;; distance
  DB  $22              ;; xpos
  DB  $01              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $08              ;; direction
  DW  $0018              ;; distance
  DB  $26              ;; xpos
  DB  $01              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0A              ;; direction
  DW  $002D              ;; distance
  DB  $26              ;; xpos
  DB  $04              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $04              ;; direction
  DW  $0020              ;; distance
  DB  $22              ;; xpos
  DB  $08              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $0E              ;; direction
  DW  $002D              ;; distance
  DB  $26              ;; xpos
  DB  $08              ;; ypos
  DB  $00              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2

  DB  $00              ;; direction
  DW  $0018              ;; distance
  DB  $22              ;; xpos
  DB  $04              ;; ypos
  DB  $01              ;; control
  DB  $00              ;; control value
  DB  $00              ;; control value 2



test_path_06::


test_path_07::


test_path_08::


test_path_09::


test_path_10::


test_path_11::


test_path_12::


test_path_13::


test_path_14::


test_path_15::


test_path_16::


test_path_17::


test_path_18::


test_path_19::


test_path_20::


test_path_21::


test_path_22::


test_path_23::


test_path_24::


test_path_25::


test_path_26::


test_path_27::


test_path_28::


test_path_29::


test_path_30::


test_path_31::


test_path_32::


test_path_33::


test_path_34::


test_path_35::


test_path_36::


test_path_37::


test_path_38::


test_path_39::


test_path_40::


test_path_41::


test_path_42::


test_path_43::


test_path_44::


test_path_45::


test_path_46::


test_path_47::


test_path_48::


test_path_49::


test_path_50::


test_path_51::


test_path_52::


test_path_53::


test_path_54::


test_path_55::


test_path_56::


test_path_57::


test_path_58::


test_path_59::


test_path_60::


test_path_61::


test_path_62::


test_path_63::

