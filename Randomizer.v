//*****************Randomizer**************************************
module Randomizer(input clk, input reset,input load,input wire[15:1] seed,input enable ,input d,output reg q,output reg[15:1]check);
reg [15:1] r_reg;
reg[15:1] r_next;
reg out;
initial begin 
r_reg=15'b011011100010101; //initialzed vector
end 
always @(posedge clk) 
begin
check=r_reg;
if(load) // if true , seed value that will be given in testbench will be set to r_reg
begin
r_reg=seed;
end
if(reset)
begin
r_reg=15'b011011100010101;
end
if(enable)
begin 
out=r_reg[2]^r_reg[1]; // 1,2 are bit [14] && bit[15] in sequence
r_next={out,r_reg[15:2]};
r_reg<=r_next;
end 
q=out^d;
end
endmodule
//******************Testbench************************************
module Randomizer_test_bench(check);
wire  q  ;
reg clk,reset,d,enable ;
output wire [15:1] check;

reg load; //should be reg to be change in initial begin block

reg [15:1] seed=15'b100100100100100;//initial value for the seed just for test , change it if you want

reg [96:1]hexaout; //The Data out in hexadecimal base
reg [96:1]hexain; //The Data in in hexadecimal base
localparam period=10;


Randomizer MB1(clk,reset,load,seed,enable,d,q,check);//calling randomizer module
always 
begin
#(period/2) clk=~clk;
end

initial begin 
$display(" time    r_reg          out  in  enable "); 

enable=0; //******NOTE******** "at this case because of enable=0, the data out will appear as " x" in transcript
 reset=1;
 clk=1;
 d=1;
hexain[96]=d;
//load=1;
$strobe(" %g     \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
# (period) enable=1'b1; load=0; reset=0;
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
#(period) d=1'b0;hexain[95]=d; //10
hexaout[96]=q;// the out (q )of the pervious time not the current
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
# (period) d=1'b1; hexain[94]=d; //20
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[95]=q;
# (period) d=1'b0; hexain[93]=d; //30
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[94]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1; hexain[92]=d;//40
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[93]=q;
# (period)  d=1'b1;hexain[91]=d; //50
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[92]=q;
# (period)  d=1'b0; hexain[90]=d;//60
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[91]=q;
# (period)  d=1'b0; hexain[89]=d; //70
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[90]=q;
//++++++++++++++++++++++++++
# (period)  d=1'b1; hexain[88]=d;//80
$strobe(" %g    \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[89]=q;
# (period)  d=1'b0; hexain[87]=d;//90
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[88]=q;
# (period)  d=1'b1; hexain[86]=d;//100
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[87]=q;
# (period)  d=1'b1;hexain[85]=d; //110
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[86]=q;
//++++++++++++++++++++++++=
# (period)  d=1'b1; hexain[84]=d;//120
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[85]=q;
# (period)  d=1'b1; hexain[83]=d; //130
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[84]=q;
# (period)  d=1'b0; hexain[82]=d;//140
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[83]=q;
# (period)  d=1'b0; hexain[81]=d; //150
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[82]=q;
//++++++++++++++++++++++=
# (period)  d=1'b1; hexain[80]=d;//160
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[81]=q;
# (period)  d=1'b1; hexain[79]=d; //170
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[80]=q;
# (period)  d=1'b0; hexain[78]=d;//180
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[79]=q;
# (period)  d=1'b1; hexain[77]=d;//190
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[78]=q;
//+++++++++++++++++++++++
# (period)  d=1'b0; hexain[76]=d;//200
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[77]=q;
# (period)  d=1'b0; hexain[75]=d;//210
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[76]=q;
# (period)  d=1'b1; hexain[74]=d;//220
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[75]=q;
# (period)  d=1'b0; hexain[73]=d; //230
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[74]=q;
//++++++++++++++++++++++++++
# (period)  d=1'b0; hexain[72]=d;//240
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[73]=q;
# (period)  d=1'b0; hexain[71]=d;//250
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[72]=q;
# (period)  d=1'b0; hexain[70]=d;//260
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[71]=q;
# (period)  d=1'b1; hexain[69]=d;//270
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[70]=q;
//+++++++++++++++++++++++

# (period)  d=1'b0;  hexain[68]=d; //280
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[69]=q;
# (period)  d=1'b0;  hexain[67]=d; //290
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[68]=q;
# (period)  d=1'b0; hexain[66]=d; //300
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[67]=q;
# (period)  d=1'b1;  hexain[65]=d;//310
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[66]=q;
//+++++++++++++++++++++++++
# (period)  d=1'b0;  hexain[64]=d;//320
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[65]=q;
# (period)  d=1'b1;  hexain[63]=d;//330
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[64]=q;
# (period)  d=1'b0;  hexain[62]=d;//340
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[63]=q;
# (period)  d=1'b0; hexain[61]=d; //350
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[62]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1;  hexain[60]=d;//360
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[61]=q;
# (period)  d=1'b1;  hexain[59]=d;//370
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[60]=q;
# (period)  d=1'b0;  hexain[58]=d;//380
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[59]=q;
# (period)  d=1'b1;  hexain[57]=d;//390
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[58]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1;  hexain[56]=d;//400
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[57]=q;
# (period)  d=1'b0;  hexain[55]=d;//410
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[56]=q;
# (period)  d=1'b1;  hexain[54]=d; //420
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[55]=q;
# (period)  d=1'b0;  hexain[53]=d;//430
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[54]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1;  hexain[52]=d;//440
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[53]=q;
# (period)  d=1'b1;  hexain[51]=d;//450
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[52]=q;
# (period)  d=1'b1;  hexain[50]=d;//460
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[51]=q;
# (period)  d=1'b0;  hexain[49]=d;//470
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[50]=q;
//++++++++++++++++++++++++
# (period)  d=1'b0; hexain[48]=d;//480
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[49]=q;
# (period)  d=1'b0; hexain[47]=d;//490
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[48]=q;
# (period)  d=1'b0; hexain[46]=d;//500
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[47]=q;
# (period)  d=1'b1; hexain[45]=d; //510
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[46]=q;
//++++++++++++++++++++++++
# (period)  d=1'b0; hexain[44]=d;//520
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[45]=q;
# (period)  d=1'b1; hexain[43]=d; //530
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[44]=q;
# (period)  d=1'b0; hexain[42]=d;//540
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[43]=q;
# (period)  d=1'b1; hexain[41]=d;//550
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[42]=q;
//++++++++++++++++++++++++
# (period)  d=1'b0; hexain[40]=d;//560
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[41]=q;
# (period)  d=1'b1; hexain[39]=d; //570
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[40]=q;
# (period)  d=1'b1; hexain[38]=d; //580
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[39]=q;
# (period)  d=1'b1; hexain[37]=d; //590
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[38]=q;
//++++++++++++++++++++++++
# (period)  d=1'b0; hexain[36]=d;//600
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[37]=q;
# (period)  d=1'b1; hexain[35]=d;//610
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[36]=q;
# (period)  d=1'b1; hexain[34]=d; //620
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[35]=q;
# (period)  d=1'b1;hexain[33]=d; //630
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[34]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1; hexain[32]=d;//640
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[33]=q;
# (period)  d=1'b1; hexain[31]=d; //650
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[32]=q;
# (period)  d=1'b0; hexain[30]=d;//660
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[31]=q;
# (period)  d=1'b0; hexain[29]=d;//670
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[30]=q;
//++++++++++++++++++++++++
# (period)  d=1'b0;  hexain[28]=d;//680
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[29]=q;
# (period)  d=1'b1; hexain[27]=d;//690
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[28]=q;
# (period)  d=1'b1; hexain[26]=d;//700
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[27]=q;
# (period)  d=1'b0; hexain[25]=d;//710
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[26]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1; hexain[24]=d;//720
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[25]=q;
# (period)  d=1'b1; hexain[23]=d;//730
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[24]=q;
# (period)  d=1'b0; hexain[22]=d;//740
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[23]=q;
# (period)  d=1'b1; hexain[21]=d;//750
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[22]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1; hexain[20]=d;//760
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[21]=q;
# (period)  d=1'b0; hexain[19]=d;//780
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[20]=q;
# (period)  d=1'b1; hexain[18]=d;//790
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[19]=q;
# (period)  d=1'b1; hexain[17]=d;//800
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[18]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1; hexain[16]=d;//810
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[17]=q;
# (period)  d=1'b1; hexain[15]=d; //820
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[16]=q;
# (period)  d=1'b1;  hexain[14]=d;//830
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[15]=q;
# (period)  d=1'b1; hexain[13]=d;//840
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[14]=q;
//++++++++++++++++++++++++
# (period)  d=1'b0; hexain[12]=d;//850
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[13]=q;
# (period)  d=1'b1; hexain[11]=d;//860
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[12]=q;
# (period)  d=1'b0; hexain[10]=d;//870
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[11]=q;
# (period)  d=1'b0; hexain[9]=d;//880
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[10]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1; hexain[8]=d;//890
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[9]=q;
# (period)  d=1'b1; hexain[7]=d;//900
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[8]=q;
# (period)  d=1'b0; hexain[6]=d;//910
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[7]=q;
# (period)  d=1'b0; hexain[5]=d;//920
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[6]=q;
//++++++++++++++++++++++++
# (period)  d=1'b1; hexain[4]=d;//930
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[5]=q;
# (period)  d=1'b0; hexain[3]=d;//940
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[4]=q;
# (period)  d=1'b0; hexain[2]=d; //950
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[3]=q;
# (period)  d=1'b1;  hexain[1]=d;//960
$strobe(" %g   \t%b  \t%b  \t%b  \t%b  ",$time ,check,q,d,enable);
hexaout[2]=q;
//++++++++++++++++++++++++
#5
hexaout[1]=q;
$display(" ***********************************************************");
$display("                                                            ");
$display("the hexadecimal DataIn :%h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h",hexain[96:93],hexain[92:89]
,hexain[88:85],hexain[84:81],hexain[80:77],hexain[76:73],hexain[72:69]
,hexain[68:65],hexain[64:61],hexain[60:57],hexain[56:53],hexain[52:49]
,hexain[48:45],hexain[44:41],hexain[40:37],hexain[36:33],hexain[32:29]
,hexain[28:25],hexain[24:21],hexain[20:17],hexain[16:13],hexain[12:9]
,hexain[8:5],hexain[4:1]);
$display("                                                              ");
$display(" *****************************//******************************");
$display("                                                              ");
$display("the hexadecimal DataOut :%h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h %h%h",hexaout[96:93],hexaout[92:89]
,hexaout[88:85],hexaout[84:81],hexaout[80:77],hexaout[76:73],hexaout[72:69]
,hexaout[68:65],hexaout[64:61],hexaout[60:57],hexaout[56:53],hexaout[52:49]
,hexaout[48:45],hexaout[44:41],hexaout[40:37],hexaout[36:33],hexaout[32:29]
,hexaout[28:25],hexaout[24:21],hexaout[20:17],hexaout[16:13],hexaout[12:9]
,hexaout[8:5],hexaout[4:1]);
$display("                                                              ");
$display(" *****************************//******************************");
$finish;
end

endmodule 