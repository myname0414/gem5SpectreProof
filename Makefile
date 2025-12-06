BUILD = build/X86/gem5.opt 
TESTBOARD = configs/learning_gem5/part1/two_level.py 
SPECTRE = spectre 

build:
	scons	build/X86/gem5.opt	-j4

hello:
    build/X86/gem5.opt	configs/learning_gem5/part1/two_level.py 

spectre:
	build/X86/gem5.opt	configs/learning_gem5/part1/two_level.py	spectre


