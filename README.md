# Demonstrate lld static link failure

When `make run-lld` is invoked it also passes --reproduce=main-lld-repro.tar
which can be untar'd so all files used to produce main-lld are available.

# lld fails

main-lld Fails with a seg fault

```
wink@wink-desktop:~/prgs/explore-cpp/lld-static-link-bug (master)
$ make run-lld
clang++ -fuse-ld=lld  -g -o main-lld  -v -static -pthread main.cpp -Wl,--reproduce=main-lld-repro
clang version 6.0.0 (tags/RELEASE_600/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Selected GCC installation: /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
 "/usr/bin/clang-6.0" -cc1 -triple x86_64-pc-linux-gnu -emit-obj -mrelax-all -disable-free -disable-llvm-verifier -discard-value-names -main-file-name main.cpp -static-define -mrelocation-model pic -pic-level 2 -pic-is-pie -mthread-model posix -mdisable-fp-elim -fmath-errno -masm-verbose -mconstructor-aliases -munwind-tables -fuse-init-array -target-cpu x86-64 -dwarf-column-info -debug-info-kind=limited -dwarf-version=4 -debugger-tuning=gdb -v -resource-dir /usr/lib/clang/6.0.0 -internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1 -internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu -internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward -internal-isystem /usr/local/include -internal-isystem /usr/lib/clang/6.0.0/include -internal-externc-isystem /include -internal-externc-isystem /usr/include -fdeprecated-macro -fdebug-compilation-dir /home/wink/prgs/explore-cpp/lld-static-link-bug -ferror-limit 19 -fmessage-length 122 -pthread -stack-protector 2 -fobjc-runtime=gcc -fcxx-exceptions -fexceptions -fdiagnostics-show-option -fcolor-diagnostics -o /tmp/main-aae38f.o -x c++ main.cpp
clang -cc1 version 6.0.0 based upon LLVM 6.0.0 default target x86_64-pc-linux-gnu
ignoring nonexistent directory "/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1
 /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu
 /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward
 /usr/local/include
 /usr/lib/clang/6.0.0/include
 /usr/include
End of search list.
 "/usr/bin/ld.lld" -m elf_x86_64 -static -o main-lld /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crt1.o /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crti.o /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtbeginT.o -L/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1 -L/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64 -L/usr/bin/../lib64 -L/lib/../lib64 -L/usr/lib/../lib64 -L/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../.. -L/usr/bin/../lib -L/lib -L/usr/lib /tmp/main-aae38f.o --reproduce=main-lld-repro -lstdc++ -lm --start-group -lgcc -lgcc_eh -lpthread -lc --end-group /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtend.o /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crtn.o
./main-lld 1 2 3
make: *** [Makefile:3: run-lld] Segmentation fault (core dumped)
wink@wink-desktop:~/prgs/explore-cpp/lld-static-link-bug (master)
$ coredumpctl gdb
           PID: 31660 (main-lld)
           UID: 1000 (wink)
           GID: 100 (users)
        Signal: 11 (SEGV)
     Timestamp: Thu 2018-07-05 13:06:30 PDT (3s ago)
  Command Line: ./main-lld 1 2 3
    Executable: /home/wink/prgs/explore-cpp/lld-static-link-bug/main-lld
 Control Group: /user.slice/user-1000.slice/session-c2.scope
          Unit: session-c2.scope
         Slice: user-1000.slice
       Session: c2
     Owner UID: 1000 (wink)
       Boot ID: a39916a44af64ce3836e760848efaaac
    Machine ID: 8f80fd742eae4659baed812cd07a9439
      Hostname: wink-desktop
       Storage: /var/lib/systemd/coredump/core.main-lld.1000.a39916a44af64ce3836e760848efaaac.31660.1530821190000000.lz4
       Message: Process 31660 (main-lld) of user 1000 dumped core.
                
                Stack trace of thread 31660:
                #0  0x0000000000384256 n/a (/home/wink/prgs/explore-cpp/lld-static-link-bug/main-lld)

GNU gdb (GDB) 8.1
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /home/wink/prgs/explore-cpp/lld-static-link-bug/main-lld...done.
[New LWP 31660]
Core was generated by `./main-lld 1 2 3'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x0000000000384256 in _dl_get_origin ()
(gdb) bt
#0  0x0000000000384256 in _dl_get_origin ()
#1  0x00000000003838bf in _dl_non_dynamic_init ()
#2  0x00000000002ef141 in __libc_init_first ()
#3  0x00000000002eee37 in __libc_start_main ()
#4  0x000000000025302a in _start ()
(gdb) disassemble $rax
Dump of assembler code for function __mempcpy_avx_unaligned_erms:
   0x0000000000364ca0 <+0>:	mov    rax,rdi
   0x0000000000364ca3 <+3>:	add    rax,rdx
   0x0000000000364ca6 <+6>:	jmp    0x364cb3 <__memmove_avx_unaligned_erms+3>
End of assembler dump.
(gdb) 
```
# Using gold succeeds

```
wink@wink-desktop:~/prgs/explore-cpp/lld-static-link-bug (master)
$ make run-gold
clang++ -fuse-ld=gold -g -o main-gold -v -static -pthread main.cpp
clang version 6.0.0 (tags/RELEASE_600/final)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/lib/gcc/x86_64-pc-linux-gnu/8.1.1
Found candidate GCC installation: /usr/lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Selected GCC installation: /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64
 "/usr/bin/clang-6.0" -cc1 -triple x86_64-pc-linux-gnu -emit-obj -mrelax-all -disable-free -disable-llvm-verifier -discard-value-names -main-file-name main.cpp -static-define -mrelocation-model pic -pic-level 2 -pic-is-pie -mthread-model posix -mdisable-fp-elim -fmath-errno -masm-verbose -mconstructor-aliases -munwind-tables -fuse-init-array -target-cpu x86-64 -dwarf-column-info -debug-info-kind=limited -dwarf-version=4 -debugger-tuning=gdb -v -resource-dir /usr/lib/clang/6.0.0 -internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1 -internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu -internal-isystem /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward -internal-isystem /usr/local/include -internal-isystem /usr/lib/clang/6.0.0/include -internal-externc-isystem /include -internal-externc-isystem /usr/include -fdeprecated-macro -fdebug-compilation-dir /home/wink/prgs/explore-cpp/lld-static-link-bug -ferror-limit 19 -fmessage-length 122 -pthread -stack-protector 2 -fobjc-runtime=gcc -fcxx-exceptions -fexceptions -fdiagnostics-show-option -fcolor-diagnostics -o /tmp/main-5e9cbb.o -x c++ main.cpp
clang -cc1 version 6.0.0 based upon LLVM 6.0.0 default target x86_64-pc-linux-gnu
ignoring nonexistent directory "/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1
 /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/x86_64-pc-linux-gnu
 /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../include/c++/8.1.1/backward
 /usr/local/include
 /usr/lib/clang/6.0.0/include
 /usr/include
End of search list.
 "/usr/bin/ld.gold" -m elf_x86_64 -static -o main-gold /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crt1.o /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crti.o /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtbeginT.o -L/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1 -L/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64 -L/usr/bin/../lib64 -L/lib/../lib64 -L/usr/lib/../lib64 -L/usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../.. -L/usr/bin/../lib -L/lib -L/usr/lib /tmp/main-5e9cbb.o -lstdc++ -lm --start-group -lgcc -lgcc_eh -lpthread -lc --end-group /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/crtend.o /usr/bin/../lib64/gcc/x86_64-pc-linux-gnu/8.1.1/../../../../lib64/crtn.o
./main-gold 4 5 6
argv[0]: ./main-gold
argv[1]: 4
argv[2]: 5
argv[3]: 6
```
