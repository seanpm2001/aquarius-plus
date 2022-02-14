#pragma once

#if _WIN32
#    define _CRT_SECURE_NO_WARNINGS
#endif

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

#if _WIN32
#    include "getopt.h"
#    include <direct.h>
#    include <io.h>
#    define strdup _strdup
#    define unlink _unlink
#    define rmdir _rmdir
#else
#    include <unistd.h>
#endif

#define CPU_FREQ (3579545)
