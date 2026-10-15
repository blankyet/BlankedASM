cp blsm_v1.blsm tmp.hex

# macros which save %rip to stack. This allows dynamyc jumps in code
sed -i -E 's/jmp_mark 0x([0-9a-fA-F]{8})/SKP16    mov_stbl rstack to rsi add_stbl $labels to rsi add_stbl 0x\1 to rsi readv_stbl rsi to rax jmp rax 909090/' tmp.hex
sed -i -E 's/mark 0x([0-9a-fA-F]{8})/saveaddr rax mov_stbl rstack to rsi add_stbl $labels to rsi add_stbl 0x\1 to rsi setv_stbl rax to rsi/' tmp.hex


sed -i -E 's/jmp_mark 0x([0-9a-fA-F]{2})/SKP16    mov_stbl rstack to rsi add_stbl $labels to rsi add_stbl 0x\1 to rsi readv_stbl rsi to rax jmp rax 909090/' tmp.hex
sed -i -E 's/mark 0x([0-9a-fA-F]{2})/saveaddr rax mov_stbl rstack to rsi add_stbl $labels to rsi add_stbl 0x\1 to rsi setv_stbl rax to rsi/' tmp.hex

sed -i -E 's/read_var 0x([0-9a-fA-F]{2}) to rax/SKP14 mov_stbl rstack to rsi  add_stbl $vars to rsi  add_stbl 0x\1 to rsi readv_stbl rsi to rax 909090/' tmp.hex
sed -i -E 's/set_var rax to 0x([0-9a-fA-F]{2})/SKP14 mov_stbl rstack to rsi  add_stbl $vars to rsi  add_stbl 0x\1 to rsi setv_stbl rax to rsi 909090/' tmp.hex

# offsets in stack
# basically variables
sed -i 's/$file_descriptor/0x00000080/' tmp.hex
sed -i 's/$in_buffer/0x00000160/'       tmp.hex
sed -i 's/$labels/0x00000600/'          tmp.hex
sed -i 's/$vars/0x00001200/'            tmp.hex
sed -i 's/$tokens/0x00001600/'          tmp.hex
sed -i 's/$jmp_map/0x00002000/'         tmp.hex
sed -i 's/$inrlbls/0x00022000/'         tmp.hex
sed -i 's/$out_buffer/0x00042000/'      tmp.hex


sed -i -E 's/mov16 0x([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) to rax/mov16 \8\7\6\5\4\3\2\1 to rax/g' tmp.hex
sed -i -E 's/mov16 ([0-9a-fA-F]{16}) to rax/SKP0A48B8\1/' tmp.hex

sed -i -E 's/mov16 0x([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) to rcx/mov16 \8\7\6\5\4\3\2\1 to rcx/g' tmp.hex
sed -i -E 's/mov16 ([0-9a-fA-F]{16}) to rcx/SKP0A48B9\1/' tmp.hex


sed -i -E 's/mov16 0x([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) to rbx/mov16 \8\7\6\5\4\3\2\1 to rbx/g' tmp.hex
sed -i -E 's/mov16 ([0-9a-fA-F]{16}) to rbx/48BB\1/' tmp.hex


sed -i -E 's/mem 0x([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})/mem \8\7\6\5\4\3\2\1/g' tmp.hex
sed -i -E 's/mem ([0-9a-fA-F]{16})/SKP08\1/' tmp.hex

sed -i 's/saveaddr rax/E800000000584883E805/g' tmp.hex


sed -i 's/test rax/SKP034885C0/' tmp.hex
sed -i -E 's/jz 0x([0-9a-fA-F]{2})/74\1/' tmp.hex
sed -i -E 's/jnz 0x([0-9a-fA-F]{2})/75\1/' tmp.hex
sed -i -E 's/jmp rax/FFE0/g' tmp.hex

sed -i -E 's/jne 0x([0-9a-fA-F]{2})/75\1/g' tmp.hex
sed -i -E 's/je 0x([0-9a-fA-F]{2})/74\1/g' tmp.hex
sed -i -E 's/ja 0x([0-9a-fA-F]{2})/77\1/g' tmp.hex
sed -i -E 's/jb 0x([0-9a-fA-F]{2})/72\1/g' tmp.hex
sed -i -E 's/jge 0x([0-9a-fA-F]{2})/7D\1/g' tmp.hex
sed -i -E 's/jg 0x([0-9a-fA-F]{2})/7F\1/g' tmp.hex
sed -i -E 's/jl 0x([0-9a-fA-F]{2})/7C\1/g' tmp.hex
sed -i -E 's/jle 0x([0-9a-fA-F]{2})/7E\1/g' tmp.hex

sed -i 's/mov r15 to rax/4989F8/g' tmp.hex

sed -i 's/xor r15 to r15/4D31FF/' tmp.hex
sed -i 's/add 0x01 to r15/4983C701/' tmp.hex

sed -i 's/mov_stbl rstack to rsi/4889E6/' tmp.hex
sed -i 's/mov rstack to rsi/SKP034889E6/' tmp.hex

sed -i 's/mov rstack to rdi/SKP034889E7/' tmp.hex
sed -i 's/mov rstack to rax/SKP034889E0/' tmp.hex
sed -i 's/mov rax to rbx/SKP034889C3/' tmp.hex
sed -i 's/mov rbx to rdi/SKP034889DF/' tmp.hex
sed -i 's/mov rstack to rsi/SKP03 4889E6/' tmp.hex
sed -i 's/mov rstack to rbp/SKP034889E5/' tmp.hex
sed -i 's/mov rax to rdx/SKP034889C2/' tmp.hex
sed -i 's/mov rbp to rsi/SKP034889EE/' tmp.hex
sed -i 's/mov rax to rdi/SKP034889C7/' tmp.hex
sed -i 's/mov rax to rcx/SKP034889C1/' tmp.hex
sed -i 's/mov rax to rsi/SKP034889C6/' tmp.hex
sed -i 's/mov rdi to rax/SKP034889F8/' tmp.hex
sed -i 's/mov rbx to rcx/SKP034889D9/' tmp.hex
sed -i 's/mov rbx to rax/SKP034889D8/' tmp.hex
sed -i 's/mov rdi to rcx/SKP034889F9/' tmp.hex
sed -i 's/mov rsi to rax/SKP034889F0/g' tmp.hex
sed -i 's/mov rdx to rax/SKP034889D0/g' tmp.hex
sed -i 's/mov rcx to rax/SKP034889C8/g' tmp.hex
sed -i 's/mov rsi to rstack/SKP034889F4/g' tmp.hex
sed -i 's/and rbx to rax/SKP03 4821C3/' tmp.hex
sed -i 's/and rdx to rax/SKP034821C2/' tmp.hex
sed -i 's/and rcx to rbx/SKP034821CB/' tmp.hex
sed -i 's/and rbx to rcx/SKP034821D9/' tmp.hex
sed -i 's/and rax to rcx/SKP034821C1/' tmp.hex


sed -i 's/mov rdi to rbp/4889EF/' tmp.hex

sed -i 's/readv_stbl rsi to rax/488B06/' tmp.hex
sed -i 's/readv rsi to rax/SKP03488B06/' tmp.hex

sed -i 's/setv rax to rbp/SKP03488945/g' tmp.hex
sed -i 's/setv rax to rsi/SKP03 488906/g' tmp.hex
sed -i 's/setv rax to rcx/SKP03 488901/g' tmp.hex
sed -i 's/setv rbx to rsi/SKP03 48891E/g' tmp.hex
sed -i 's/setv_stbl rax to rsi/488906/g' tmp.hex

sed -i 's/cmp rcx to rax/4839C8/g' tmp.hex
sed -i 's/cmp rcx to rbx/483BD9/g' tmp.hex
sed -i 's/cmp rax to rbx/483BD8/g' tmp.hex
sed -i 's/cmp rdi to rax/4839C7/g' tmp.hex
sed -i 's/cmp rbx to rax/4839C3/g' tmp.hex


sed -i -E 's/add_stbl 0x([0-9a-fA-F]+)/add_stbl 0000000\1/g' tmp.hex
sed -i -E 's/add_stbl ([0-9a-fA-F]*)([0-9a-fA-F]{8}) to/add_stbl \2 to/g' tmp.hex

sed -i -E 's/add 0x([0-9a-fA-F]+)/add 0000000\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]*)([0-9a-fA-F]{8}) to/add \2 to/g' tmp.hex




sed -i -E 's/sub 0x([0-9a-fA-F]+)/sub 0000000\1/g' tmp.hex
sed -i -E 's/sub ([0-9a-fA-F]*)([0-9a-fA-F]{8}) to/sub \2 to/g' tmp.hex


sed -i -E 's/sub ([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) to/sub \4\3\2\1 to/g' tmp.hex

sed -i -E 's/sub ([0-9a-fA-F]{8}) to rax/4881E8\1/g' tmp.hex
sed -i -E 's/sub ([0-9a-fA-F]{8}) to rcx/4881E9\1/g' tmp.hex
sed -i -E 's/sub ([0-9a-fA-F]{8}) to rdx/4881EA\1/g' tmp.hex
sed -i -E 's/sub ([0-9a-fA-F]{8}) to rbx/4881EB\1/g' tmp.hex
sed -i -E 's/sub ([0-9a-fA-F]{8}) to rstack/4881EC\1/g' tmp.hex   # rsp
sed -i -E 's/sub ([0-9a-fA-F]{8}) to rbp/4881ED\1/g' tmp.hex
sed -i -E 's/sub ([0-9a-fA-F]{8}) to rsi/4881EE\1/g' tmp.hex
sed -i -E 's/sub ([0-9a-fA-F]{8}) to rdi/4881EF\1/g' tmp.hex

sed -i -E 's/add rdi to rax/4801F8/g' tmp.hex
sed -i -E 's/add rdi to rcx/4801F9/g' tmp.hex
sed -i -E 's/add rdi to rdx/4801FA/g' tmp.hex    
sed -i -E 's/add rdi to rbx/4801FB/g' tmp.hex    
sed -i -E 's/add rdi to rsp/4801FC/g' tmp.hex    
sed -i -E 's/add rdi to rbp/4801FD/g' tmp.hex    
sed -i -E 's/add rdi to rsi/4801FE/g' tmp.hex    
sed -i -E 's/add rdi to rdi/4801FF/g' tmp.hex    
sed -i -E 's/add rax to rbx/4801C3/g' tmp.hex    
sed -i -E 's/add rdx to rax/4801D0/g' tmp.hex    
sed -i -E 's/add rax to rdi/4801C7/g' tmp.hex    

sed -i -E 's/add rbx to rdx/4801DA/g' tmp.hex 
sed -i -E 's/add rax to rsi/4801C6/g' tmp.hex 

sed -i -E 's/sub rax to rsi/482BF0/g' tmp.hex 
sed -i -E 's/sub rax to rcx/4829C1/g' tmp.hex 
sed -i -E 's/sub rdi to rax/4829F8/g' tmp.hex 


# for small numbers
sed -i -E 's/add_stbl 000000([0-7][0-9a-fA-F]) to rsi/4883C6\1/g' tmp.hex
sed -i -E 's/add 000000([0-7][0-9a-fA-F]) to rsi/SKP044883C6\1/g' tmp.hex
sed -i -E 's/add 000000([0-7][0-9a-fA-F]) to rdi/SKP044883C7\1/g' tmp.hex
sed -i -E 's/add 000000([0-7][0-9a-fA-F]) to rbp/SKP044883C5\1/g' tmp.hex

sed -i -E 's/sub 000000([0-7][0-9a-fA-F]) to rdi/SKP074883EF\1/g' tmp.hex
sed -i -E 's/sub 000000([0-7][0-9a-fA-F]) to rstack/SKP074883EC\1/g' tmp.hex

sed -i -E 's/neg rdi/48F7DF/g' tmp.hex
# for big numbers
sed -i -E 's/add_stbl ([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) to/add_stbl \4\3\2\1 to/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) to/add \4\3\2\1 to/g' tmp.hex

sed -i -E 's/add_stbl ([0-9a-fA-F]{8}) to rsi/4881C6\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rsi/SKP074881C6\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rdi/SKP074881C7\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rax/SKP07 4881C0\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rcx/SKP074881C1\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rdx/SKP074881C2\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rbx/SKP074881C3\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rstack/SKP074881C4\1/g' tmp.hex
sed -i -E 's/add ([0-9a-fA-F]{8}) to rbp/SKP074881C5\1/g' tmp.hex

sed -i -E 's/shiftl rbp by 0x([0-9a-fA-F]{2})/48C1E5\1/g' tmp.hex
sed -i -E 's/shiftl rdx by 0x([0-9a-fA-F]{2})/48C1E2\1/g' tmp.hex
sed -i -E 's/shiftl rsi by 0x([0-9a-fA-F]{2})/48C1E6\1/g' tmp.hex
sed -i -E 's/shiftl rax by 0x([0-9a-fA-F]{2})/48C1E0\1/g' tmp.hex
sed -i -E 's/shiftl rcx by 0x([0-9a-fA-F]{2})/48C1E1\1/g' tmp.hex

sed -i -E 's/shiftl rcx by rax/C4E2F9F7C9/g' tmp.hex


sed -i -E 's/mov 0x([0-9a-fA-F]+)/mov 0000000\1/g' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]*)([0-9a-fA-F]{8}) to/mov \2 to/g' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2}) to/mov \4\3\2\1 to/g' tmp.hex

sed -i -E 's/or rdx to rax/4809C2/g' tmp.hex
sed -i -E 's/or rcx to rax/4809C8/g' tmp.hex


sed -i 's/syscall/SKP020F05/'  tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rax/SKP07 48 C7 C0\1/' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rcx/SKP07 48 C7 C1\1/' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rdx/SKP0748C7C2\1/' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rbx/SKP0748C7C3\1/' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rstack/SKP0748C7C4\1/' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rbp/SKP0748C7C5\1/' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rsi/SKP0748C7C6\1/' tmp.hex
sed -i -E 's/mov ([0-9a-fA-F]{8}) to rdi/SKP0748C7C7\1/' tmp.hex

sed -i 's/push rax/SKP01 50/' tmp.hex
sed -i 's/push rsi/SKP01 56/' tmp.hex
sed -i 's/push rdi/SKP01 57/' tmp.hex

sed -i 's/pop rsi/SKP01 5E/' tmp.hex

# skp Skips all runable code if r15 is 0
# this allows to go through all code and skip computations
# on save_mark do smthing
# thus we can jump to marks which come after save_mark
sed -i -E 's/SKP([0-9a-fA-F]{2})/4D85FF74 \1 /g' tmp.hex

sed -i 's/;.*//' tmp.hex

sed -i 's/[[:space:]]//g' tmp.hex

tr -d '\n' < tmp.hex > main.tmp && mv main.tmp tmp.hex

if awk '/[^0-9a-fA-F[:space:]]/ { print "FAIL: Bad hex input on line " NR ": \"" $0 "\""; exit 1 }' tmp.hex; then
    xxd -r -p tmp.hex blsm_v1.bin
else
    exit 1
fi

rm tmp.hex
cat blsm_v1.bin

