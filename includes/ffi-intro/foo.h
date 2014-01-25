#include <stdint.h>
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct foo
{
    uint32_t bar;
    int8_t   baz;
    int8_t   quux[4];
} foo_t;

size_t serialise   (const struct foo *, uint8_t *);
size_t deserialise (const uint8_t *, struct foo *);

#ifdef __cplusplus
}
#endif
