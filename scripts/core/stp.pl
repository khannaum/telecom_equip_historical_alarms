#!/usr/perl5/5.6.1/bin/perl

my ($hostname,$username,$spasswd);



#$hostname="10.31.24.25";
$username="login:uid=noc";

$passwd="MOBILINK9";

#$hostname="$ARGV[0]";

$hostname="$ARGV[0]";
#$username="$ARGV[1]";
$spasswd=$ARGV[2];

#print $ARGV[0],$ARGV[1];


# print $hostname,$username,$passwd;


## Connect & Login
use lib '/home/oann/logs/core/net';
use Net::Telnet();

 $host=new Net::Telnet (Timeout => 600,Prompt => '/[:<>]/');

# $host=new Net::Telnet (Timeout => 600);


$fh = $host->input_log("tmp_stp.txt");
$fh1=$host->output_log("log.txt");
$fh2=$host->dump_log("dlog.txt");

$host -> open($hostname);


#$ok = $host->waitfor('/\(/');
 
# $host -> login($username,$passwd);
 @line = $host->getline;
 @line1 = $host->getline;
 @line2 = $host->getline;
 $line3= $host->getline;


my @fields=split(/[(|,|)]/,$line3);

#print "=====",$line3,"==",@fields ;

foreach my $val (@fields) {
    print length($val),"$val\n";
    
 my $char='Connection established';
  if(length($val) >0){
   @cmd1=$host->cmd($val);
  $line4= $host->getline;
  $line5= $host->getline;
  $line6=$host->getline;
  
   print $line6;
   @be=$host->buffer_empty;

   my $passwd=':';
   my $result = index($line6, $char);
      if($result > -1){
             sleep(2);
            @cmd2=$host->cmd('login:uid=noc');
             sleep(2);
            $line4= $host->getline;
            $line5= $host->getline;
            $line6=$host->getline;
            print $line4,$line5,$line6;
            
            @cmd3=$host->cmd( String => $spasswd, Prompt => $passwd );
            $line4= $host->getline;
            $line5= $host->getline;
            $line6=$host->getline;$host->getline;$host->getline;$host->getline;
            print $line4,$line5,$line6;
             sleep(2);
             @be=$host->buffer_empty;
            @cmd4=$host->cmd('rtrv-slk');
            $line4= $host->getline;
            $line5= $host->getline;
            $line6=$host->getline;$host->getline;$host->getline;$host->getline;
            print $line4,$line5,$line6;

            $line6=$host->getlines(Timeout => '25');
            print $line6;

             sleep(2);
             @be=$host->buffer_empty;
            @cmd4=$host->cmd('rept-stat-ls');
            $line4= $host->getline;
            $line5= $host->getline;
            $line6=$host->getline;$host->getline;$host->getline;$host->getline;
            print $line4,$line5,$line6;

            $line6=$host->getlines(Timeout => '25');
            print $line6;  
            
            #sleep(5); 
            @cmd5=$host->cmd('logout');
            $line4= $host->getline;
            $line5= $host->getline;
            $line6=$host->getline;
            print $line4,$line5,$line6;
 
            @cmd6=$host->break;  
            last; 
      } 
                 
   }

  }

