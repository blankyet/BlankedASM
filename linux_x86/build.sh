./blsm_v0.sh > tmp1.bin
gcc dummy.c -o blsm_v1
echo "Blsm v1 assembled!!!\n"

objcopy \
    --set-section-flags .my_code=alloc,code,load \
    --update-section .my_code=tmp1.bin \
    blsm_v1 blsm_v1.tmp &&
mv blsm_v1.tmp blsm_v1
rm tmp1.bin

./blsm_v1 > tmp2.bin
gcc dummy.c -o blsm_v2
echo "Blsm v2 assembled!!!\n"

objcopy \
    --set-section-flags .my_code=alloc,code,load \
    --update-section .my_code=tmp2.bin \
    blsm_v2 blsm_v2.tmp &&
mv blsm_v2.tmp blsm_v2
rm tmp2.bin

./blsm_v2 blsm_v2.blsm blsm
echo "Blsm v3 assembled!!!\n"

./blsm blsm_v2.blsm blsm_v2
./blsm_v2 blsm_v2.blsm blsm
./blsm blsm_v2.blsm blsm_v2
./blsm_v2 blsm_v2.blsm blsm
# how deep can self bootstrap go i wonder...
./blsm blsm_v2.blsm -j blsm_v2.blsm -j blsm_v2.blsm -j blsm_v2.blsm -j blsm_v2.blsm blsm_v2

echo "Blsm fully compiles itself!!!\n"


./blsm demos/hello_world.blsm -j


echo "Usage: ./blsm <file.blsm> [output_name | -j]"
echo "try ./blsm demos/hello_world.blsm -j"
echo "try ./blsm demos/hello_world.blsm hi && ./hi"
echo "try ./blsm demos/cat.blsm -j blsm_v2.blsm"
echo "try ./blsm demos/server.blsm -j"
