************************************************************
*****                                                  *****
*****           SystemVerilog for Verification         *****
*****                                                  *****
*****             Copyright (c) 2007, 2008             *****
*****               Willamette HDL, Inc.               *****
*****                                                  *****
************************************************************

#### Requirements: 
  Sun Solaris >= 2.6, or Linux
  QuestaSim v6.3a or later
  nedit v5.5+ (optional)
     freeware from nedit.org with SystemVerilog pattern recognition

#### To prepare the labs for a class:

1. tar -zxvf <path to file_name.tgz>
(or first gunzip <path to file_name.tgz>
then tar -xvf <path to file_name.tar> if -z option unsupported)

#### Database checkout using QuestaSim



   $ cd (top_level_directory)/Router/complete
   $ make

   The output should end with:
   
   # Coverage = 100%
   #
   # ********************************
   #     Coverage goal met: 100 !!!
   # ********************************
   #
   # 507 packets sent, 419 packets received, 0 errors
   #
   # ********************************
   # ********************************
   #
   # Break at ./test_router.sv line 135
   # Stopped at ./router.sv line 20
   #  quit -f


#### To set up SystemVerilog pattern recognition for nedit:
   - cp .nedit to student home directory
   or
   - invoke nedit -import .sv_nedit_pats (located in the top level dir )
   - under "preferences" select "save defaults"
   - quit nedit
   
#### Emacs mode files are also provided
   - .emacs
   - verilog-mode.el   
