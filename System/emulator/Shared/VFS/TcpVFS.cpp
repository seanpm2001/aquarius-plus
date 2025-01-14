#include "TcpVFS.h"
#ifndef _WIN32
#include <netdb.h>
#endif

#define MAX_FDS (10)

struct state {
    int sockets[MAX_FDS];
};

static struct state state;

TcpVFS::TcpVFS() {
}

TcpVFS &TcpVFS::instance() {
    static TcpVFS vfs;
    return vfs;
}

void TcpVFS::init() {
    for (int i = 0; i < MAX_FDS; i++) {
        state.sockets[i] = -1;
    }
}

static bool startsWith(const std::string &s1, const std::string &s2, bool caseSensitive = false) {
    if (caseSensitive) {
        return (strncasecmp(s1.c_str(), s2.c_str(), s2.size()) == 0);
    } else {
        return (strncmp(s1.c_str(), s2.c_str(), s2.size()) == 0);
    }
}

int TcpVFS::open(uint8_t flags, const std::string &_path) {
    (void)flags;
    printf("TCP open: %s\n", _path.c_str());

    if (!startsWith(_path, "tcp://")) {
        return ERR_PARAM;
    }
    auto colonPos = _path.find(':', 6);
    if (colonPos == std::string::npos) {
        return ERR_PARAM;
    }

    auto host    = _path.substr(6, colonPos - 6);
    auto portStr = _path.substr(colonPos + 1);

    char *endp;
    int   port = strtol(portStr.c_str(), &endp, 10);
    if (endp != portStr.c_str() + portStr.size() || port < 0 || port > 65535) {
        return ERR_PARAM;
    }

    printf("TCP host '%s'  port '%d'\n", host.c_str(), port);

    // Find free file descriptor
    int fd = -1;
    for (int i = 0; i < MAX_FDS; i++) {
        if (state.sockets[i] < 0) {
            fd = i;
            break;
        }
    }
    if (fd == -1)
        return ERR_TOO_MANY_OPEN;

#ifndef _WIN32
    // Resolve name
    struct addrinfo hints = {.ai_family = AF_INET, .ai_socktype = SOCK_STREAM};

    struct addrinfo *ai;
    if (getaddrinfo(host.c_str(), portStr.c_str(), &hints, &ai) != 0) {
        return ERR_NOT_FOUND;
    }

    printf("Name resolved!\n");

    // Open socket
    int sock = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
    if (sock < 0) {
        freeaddrinfo(ai);
        return ERR_OTHER;
    }

    if (fcntl(sock, F_SETFL, fcntl(sock, F_GETFL) | O_NONBLOCK) == -1) {
        ::close(sock);
        return ERR_OTHER;
    }

    printf("Socket opened!\n");

    // Connect to host
    int err = connect(sock, ai->ai_addr, ai->ai_addrlen);
    freeaddrinfo(ai);

    if (err != 0) {
        if (errno == EINPROGRESS) {
            struct timeval tv;
            tv.tv_sec  = 5;
            tv.tv_usec = 0;

            fd_set fdset;
            FD_ZERO(&fdset);
            FD_SET(sock, &fdset);

            // Connection in progress -> have to wait until the connecting socket is marked as writable, i.e. connection completes
            err = select(sock + 1, NULL, &fdset, NULL, &tv);
            if (err <= 0) {
                ::close(sock);
                return ERR_OTHER;
            }

        } else {
            printf("Error connecting to host!\n");
            ::close(sock);
            return ERR_NOT_FOUND;
        }
    }

    // Success!
    state.sockets[fd] = sock;
    return fd;
#endif

    return ERR_OTHER;
}

int TcpVFS::read(int fd, size_t size, void *buf) {
    (void)fd;
    (void)size;
    (void)buf;
    // printf("TCP read: %d  size: %u\n", fd, (unsigned)size);

    if (fd >= MAX_FDS || state.sockets[fd] < 0)
        return ERR_PARAM;
    int sock = state.sockets[fd];

#ifndef _WIN32
    int len = recv(sock, buf, size, 0);
    if (len < 0) {
        if (errno == EINPROGRESS || errno == EAGAIN || errno == EWOULDBLOCK) {
            return 0; // Not an error
        }
        if (errno == ENOTCONN) {
            return ERR_EOF;
        }
        return ERR_OTHER;
    }
    return len;
#endif

    return ERR_OTHER;
}

int TcpVFS::write(int fd, size_t size, const void *buf) {
    (void)fd;
    (void)size;
    (void)buf;
    // printf("TCP write: %d  size: %u\n", fd, (unsigned)size);

#ifndef _WIN32
    if (fd >= MAX_FDS || state.sockets[fd] < 0)
        return ERR_PARAM;
    int sock = state.sockets[fd];

    int            to_write = size;
    const uint8_t *data     = (const uint8_t *)buf;
    while (to_write > 0) {
        int written = send(sock, data + (size - to_write), to_write, 0);
        if (written < 0 && errno != EINPROGRESS && errno != EAGAIN && errno != EWOULDBLOCK) {
            return ERR_OTHER;
        }
        to_write -= written;
    }
    return size;
#endif

    return ERR_OTHER;
}

int TcpVFS::close(int fd) {
    printf("TCP close: %d\n", fd);

#ifndef _WIN32
    if (fd >= MAX_FDS || state.sockets[fd] < 0)
        return ERR_PARAM;
    ::close(state.sockets[fd]);
    state.sockets[fd] = -1;
#endif

    return 0;
}
