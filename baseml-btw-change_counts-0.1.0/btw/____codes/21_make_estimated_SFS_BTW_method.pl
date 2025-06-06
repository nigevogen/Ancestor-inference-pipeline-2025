open (IN1,"anc_site_probs.txt");
@str1 = <IN1>;
open (IN2,"original_aln.txt");
@str2 = <IN2>;

$sample_start = $ARGV[0];
$sample_end = $ARGV[1];
$sample_num = $sample_end - $sample_start + 1;

$n=1;
foreach $_ (@str2) {
    if ($_ =~ /^\w\w\w\w\w\w\w/) {
        ${'SEQ'.$n} = $_;
        @{'SEQ'.$n} = split //, ${'SEQ'.$n};
        $n++;
    }
}

for ($n1=1;$n1<=$sample_num;$n1++) {
    @freq_spec_TC[$n1]=0;
    @freq_spec_TA[$n1]=0;
    @freq_spec_TG[$n1]=0;
    @freq_spec_CT[$n1]=0;
    @freq_spec_CA[$n1]=0;
    @freq_spec_CG[$n1]=0;
    @freq_spec_AT[$n1]=0;
    @freq_spec_AC[$n1]=0;
    @freq_spec_AG[$n1]=0;
    @freq_spec_GT[$n1]=0;
    @freq_spec_GC[$n1]=0;
    @freq_spec_GA[$n1]=0;
}


$poly=0;
$poly2=0;
for ($n=0;$n<=$#SEQ1;$n++) {
    $site = $n;
    $check3=0;
    
    $n2 = 1;
    for ($n1=$sample_start;$n1<=$sample_end;$n1++) {
        ${'sample'.$n2} = @{'SEQ'.$n1}[$site];
        $n2++;
    }
    $ref1 = $sample1;
    for ($n1=1;$n1<=$sample_num;$n1++) {
        if (${'sample'.$n1} ne $ref1) {
            $check3=1;
            $ref2 = ${'sample'.$n1};
        }
    }
    if ($check3==1) {
        for ($n1=1;$n1<=$sample_num;$n1++) {
            if ((${'sample'.$n1} ne $ref1) && (${'sample'.$n1} ne $ref2)) {
                printf "$ref1 $ref2 ${'sample'.$n1} more than three state at $site th site\n";
            }
        }
        $poly++;
    }

    while (@str1[$n] =~ /(\w)\t(0\.\d+)/g) {
        $check1=0;
        $check2=0;
        $check4=0;
        $anc = $1;
        $freq = $2;
        
        $der1 = "X";
        $der2 = "Y";

        for ($n1=1;$n1<=$sample_num;$n1++) {
            if (${'sample'.$n1} ne $anc) {
                if (($der1 eq "X") || (${'sample'.$n1} eq $der1)) {
                    $check1++;
                    $der1 = ${'sample'.$n1};
                }
                elsif (${'sample'.$n1} ne $der1) {
                    $check2++;
                    $der2 = ${'sample'.$n1};
                    $check4=1;
                }
            }
        }
        #if ($check4==1) {
        #    printf "$site $anc $der1 $der2 $freq\n";
        #}

        
        if ($anc eq "T") {
            if ($der1 eq "C") {
                @freq_spec_TC[$check1] = @freq_spec_TC[$check1] + $freq;
            }
            if ($der1 eq "A") {
                @freq_spec_TA[$check1] = @freq_spec_TA[$check1] + $freq;
            }
            if ($der1 eq "G") {
                @freq_spec_TG[$check1] = @freq_spec_TG[$check1] + $freq;
            }
            if ($der2 eq "C") {
                @freq_spec_TC[$check2] = @freq_spec_TC[$check2] + $freq;
            }
            if ($der2 eq "A") {
                @freq_spec_TA[$check2] = @freq_spec_TA[$check2] + $freq;
            }
            if ($der2 eq "G") {
                @freq_spec_TG[$check2] = @freq_spec_TG[$check2] + $freq;
            }
        }
        if ($anc eq "C") {
            if ($der1 eq "T") {
                @freq_spec_CT[$check1] = @freq_spec_CT[$check1] + $freq;
            }
            if ($der1 eq "A") {
                @freq_spec_CA[$check1] = @freq_spec_CA[$check1] + $freq;
            }
            if ($der1 eq "G") {
                @freq_spec_CG[$check1] = @freq_spec_CG[$check1] + $freq;
            }
            if ($der2 eq "T") {
                @freq_spec_CT[$check2] = @freq_spec_CT[$check2] + $freq;
            }
            if ($der2 eq "A") {
                @freq_spec_CA[$check2] = @freq_spec_CA[$check2] + $freq;
            }
            if ($der2 eq "G") {
                @freq_spec_CG[$check2] = @freq_spec_CG[$check2] + $freq;
            }
        }
        if ($anc eq "A") {
            if ($der1 eq "T") {
                @freq_spec_AT[$check1] = @freq_spec_AT[$check1] + $freq;
            }
            if ($der1 eq "C") {
                @freq_spec_AC[$check1] = @freq_spec_AC[$check1] + $freq;
            }
            if ($der1 eq "G") {
                @freq_spec_AG[$check1] = @freq_spec_AG[$check1] + $freq;
            }
            if ($der2 eq "T") {
                @freq_spec_AT[$check2] = @freq_spec_AT[$check2] + $freq;
            }
            if ($der2 eq "C") {
                @freq_spec_AC[$check2] = @freq_spec_AC[$check2] + $freq;
            }
            if ($der2 eq "G") {
                @freq_spec_AG[$check2] = @freq_spec_AG[$check2] + $freq;
            }
        }
        if ($anc eq "G") {
            if ($der1 eq "T") {
                @freq_spec_GT[$check1] = @freq_spec_GT[$check1] + $freq;
            }
            if ($der1 eq "C") {
                @freq_spec_GC[$check1] = @freq_spec_GC[$check1] + $freq;
            }
            if ($der1 eq "A") {
                @freq_spec_GA[$check1] = @freq_spec_GA[$check1] + $freq;
            }
            if ($der2 eq "T") {
                @freq_spec_GT[$check2] = @freq_spec_GT[$check2] + $freq;
            }
            if ($der2 eq "C") {
                @freq_spec_GC[$check2] = @freq_spec_GC[$check2] + $freq;
            }
            if ($der2 eq "A") {
                @freq_spec_GA[$check2] = @freq_spec_GA[$check2] + $freq;
            }
        }
    }
    while (@str1[$n] =~ /(\w)\t(1)\t/g) {
        $check1=0;
        $check2=0;
        $check4=0;
        $anc = $1;
        $freq = $2;
        
        $der1 = "X";
        $der2 = "Y";
        
        for ($n1=1;$n1<=$sample_num;$n1++) {
            if (${'sample'.$n1} ne $anc) {
                if (($der1 eq "X") || (${'sample'.$n1} eq $der1)) {
                    $check1++;
                    $der1 = ${'sample'.$n1};
                }
                elsif (${'sample'.$n1} ne $der1) {
                    $check2++;
                    $der2 = ${'sample'.$n1};
                    $check4=1;
                }
            }
        }
        #if ($check4==1) {
        #    printf "$site $anc $der1 $der2 $freq\n";
        #}
        
        if ($anc eq "T") {
            if ($der1 eq "C") {
                @freq_spec_TC[$check1] = @freq_spec_TC[$check1] + 1;
            }
            if ($der1 eq "A") {
                @freq_spec_TA[$check1] = @freq_spec_TA[$check1] + 1;
            }
            if ($der1 eq "G") {
                @freq_spec_TG[$check1] = @freq_spec_TG[$check1] + 1;
            }
            if ($der2 eq "C") {
                @freq_spec_TC[$check2] = @freq_spec_TC[$check2] + 1;
            }
            if ($der2 eq "A") {
                @freq_spec_TA[$check2] = @freq_spec_TA[$check2] + 1;
            }
            if ($der2 eq "G") {
                @freq_spec_TG[$check2] = @freq_spec_TG[$check2] + 1;
            }
        }
        if ($anc eq "C") {
            if ($der1 eq "T") {
                @freq_spec_CT[$check1] = @freq_spec_CT[$check1] + 1;
            }
            if ($der1 eq "A") {
                @freq_spec_CA[$check1] = @freq_spec_CA[$check1] + 1;
            }
            if ($der1 eq "G") {
                @freq_spec_CG[$check1] = @freq_spec_CG[$check1] + 1;
            }
            if ($der2 eq "T") {
                @freq_spec_CT[$check2] = @freq_spec_CT[$check2] + 1;
            }
            if ($der2 eq "A") {
                @freq_spec_CA[$check2] = @freq_spec_CA[$check2] + 1;
            }
            if ($der2 eq "G") {
                @freq_spec_CG[$check2] = @freq_spec_CG[$check2] + 1;
            }
        }
        if ($anc eq "A") {
            if ($der1 eq "T") {
                @freq_spec_AT[$check1] = @freq_spec_AT[$check1] + 1;
            }
            if ($der1 eq "C") {
                @freq_spec_AC[$check1] = @freq_spec_AC[$check1] + 1;
            }
            if ($der1 eq "G") {
                @freq_spec_AG[$check1] = @freq_spec_AG[$check1] + 1;
            }
            if ($der2 eq "T") {
                @freq_spec_AT[$check2] = @freq_spec_AT[$check2] + 1;
            }
            if ($der2 eq "C") {
                @freq_spec_AC[$check2] = @freq_spec_AC[$check2] + 1;
            }
            if ($der2 eq "G") {
                @freq_spec_AG[$check2] = @freq_spec_AG[$check2] + 1;
            }
        }
        if ($anc eq "G") {
            if ($der1 eq "T") {
                @freq_spec_GT[$check1] = @freq_spec_GT[$check1] + 1;
            }
            if ($der1 eq "C") {
                @freq_spec_GC[$check1] = @freq_spec_GC[$check1] + 1;
            }
            if ($der1 eq "A") {
                @freq_spec_GA[$check1] = @freq_spec_GA[$check1] + 1;
            }
            if ($der2 eq "T") {
                @freq_spec_GT[$check2] = @freq_spec_GT[$check2] + 1;
            }
            if ($der2 eq "C") {
                @freq_spec_GC[$check2] = @freq_spec_GC[$check2] + 1;
            }
            if ($der2 eq "A") {
                @freq_spec_GA[$check2] = @freq_spec_GA[$check2] + 1;
            }
        }
    }
}

open (OUT1, ">>estimated_frequency_spectrum.txt");
print (OUT1 "TC\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_TC[$n1]\t");
}
print (OUT1 "\nTA\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_TA[$n1]\t");
}
print (OUT1 "\nTG\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_TG[$n1]\t");
}
print (OUT1 "\nCT\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_CT[$n1]\t");
}
print (OUT1 "\nCA\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_CA[$n1]\t");
}
print (OUT1 "\nCG\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_CG[$n1]\t");
}
print (OUT1 "\nAT\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_AT[$n1]\t");
}
print (OUT1 "\nAC\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_AC[$n1]\t");
}
print (OUT1 "\nAG\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_AG[$n1]\t");
}
print (OUT1 "\nGT\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_GT[$n1]\t");
}
print (OUT1 "\nGC\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_GC[$n1]\t");
}
print (OUT1 "\nGA\t");
for ($n1=1;$n1<=$sample_num-1;$n1++) {
    print (OUT1 "@freq_spec_GA[$n1]\t");
}
print (OUT1 "\n");

