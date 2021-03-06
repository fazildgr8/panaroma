ls -1 *.warp.f > files.txt

cat files.txt | tr '\n' ' ' > files_one_line.txt

echo "rm -f pairlist.txt"

awk '{ for (i=1; i <= NF; i++) { \
         j = i % NF + 1; \
         print "echo \"Matching image " i " to " j "\"\n../Features.exe matchFeatures " $i, $j " 0.7 match_" i "_" j ".txt " 2; \
       } \
     } ' files_one_line.txt

awk '{ for (i=1; i <= NF; i++) { \
         j = i % NF + 1; \
         print "echo \"Aligning image " i " to " j "\"\n../../Panorama.exe alignPair " $i, $j " match_" i "_" j ".txt 1000 4.0 | tail -1 > align_" i "_" j ".txt\necho `basename " $i " .f`.tga `basename " $j " .f`.tga `cat align_" i "_" j ".txt` >> pairlist.txt"; \
       } \
     } ' files_one_line.txt
