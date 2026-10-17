./blsm_v0.sh > tmp1.bin

clang -arch x86_64 dummy.c \
    -Wl,-segprot,__BLSM,rwx,rwx \
    -o blsm_v1

llvm-objcopy --update-section __BLSM,__my_code=tmp1.bin \
    blsm_v1 blsm_v1.tmp

mv blsm_v1.tmp blsm_v1
chmod +x blsm_v1

./blsm_v1 > tmp2.bin

clang -arch x86_64 dummy.c \
    -Wl,-segprot,__BLSM,rwx,rwx \
    -o blsm_v2

llvm-objcopy --update-section __BLSM,__my_code=tmp2.bin \
    blsm_v2 blsm_v2.tmp

mv blsm_v2.tmp blsm_v2
chmod +x blsm_v2

echo "Blsm v2 assembled!!!\n"


./blsm_v2 blsm_v2.blsm blsm
echo "Blsm v3 assembled!!!\n"


rm -f blsm_v2 && ./blsm blsm_v2.blsm blsm_v2
rm -f blsm    && ./blsm_v2 blsm_v2.blsm blsm
rm -f blsm_v2 && ./blsm blsm_v2.blsm blsm_v2
rm -f blsm    && ./blsm_v2 blsm_v2.blsm blsm


echo "Blsm fully compiles itself!!!\n"

echo "Usage: ./blsm <file.blsm> [output_name | -j]"
echo "try ./blsm demos/hello_world.blsm -j"
echo "try ./blsm demos/hello_world.blsm hi && ./hi"
echo "try ./blsm demos/cat.blsm -j blsm_v2.blsm"
echo "try ./blsm demos/server.blsm -j"
