module cover_group;
bit clk;
enum {sml_pkt, med_pkt, lrg_pkt} ether_pkts;
bit[1:0] mp3_data, noise, inter_fr_gap;


covergroup net_mp3 () @(posedge clk);
  type_option.comment = "Coverage model for network MP3 player";
  option.auto_bin_max = 256;
          Mp3 : coverpoint mp3_data;    	
          Junk: coverpoint noise;
          epkt:  coverpoint ether_pkts;
        Traffic: cross epkt, Mp3;   	// 2 coverpoints
endgroup

net_mp3 mp3_1 = new();
net_mp3 mp3_2 = new();

endmodule
