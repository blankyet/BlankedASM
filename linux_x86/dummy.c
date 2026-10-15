__attribute__((section(".my_code,\"awx\",@progbits#")))
char big_space[65536] = {0x90}; // Pre-filled with 0xCC (INT 3)

int main(int argc, char **argv) {
    // Pass argc and argv explicitly to your buffer
    ((void(*)(int, char**))big_space)(argc, argv);
    return 0;
}