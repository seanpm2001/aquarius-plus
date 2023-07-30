#pragma once

#if _WIN32
#    define _CRT_SECURE_NO_WARNINGS
#endif

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdarg.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <assert.h>
#include <fcntl.h>
#include <errno.h>

#include <string>
#include <vector>
#include <memory>
#include <functional>

#ifdef __APPLE__
#    include <sys/stat.h>
#    include <sys/types.h>
#    include <pwd.h>
#    include <uuid/uuid.h>
#endif

#if _WIN32
#    include "getopt.h"
#    include <direct.h>
#    include <io.h>
#    include <sys/types.h>
#    include <sys/stat.h>
#    define strdup _strdup
#    define unlink _unlink
#    define rmdir _rmdir
#    define open _open
#    define close _close
#    define read _read
#    define write _write
#    define lseek _lseek
#    define mkdir _mkdir
#    define strncasecmp _strnicmp
#    define strcasecmp _stricmp
#else
#    include <unistd.h>
#    include <sys/stat.h>
#endif

#define CPU_FREQ (3579545)

#define VIDEO_WIDTH (352)
#define VIDEO_HEIGHT (240)

void reset(void);

static inline void stripTrailingSlashes(std::string &path) {
    // Leave a slash at the start of the string intact
    while (path.size() > 2 && (path.back() == '/' || path.back() == '\\'))
        path.pop_back();
}