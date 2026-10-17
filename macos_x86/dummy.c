__attribute__((used, section("__BLSM,__my_code")))
unsigned char big_space[1024 * 1024] = {0x90};  // 1 MiB

int main(int argc, char **argv) {
    ((void (*)(int, char **))big_space)(argc, argv);
    return 0;
}
