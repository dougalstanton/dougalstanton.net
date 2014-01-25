#include "foo.h"

size_t serialise (const struct foo * in, uint8_t * out)
{
    out[0] = in->bar & 0x000000ff;
    out[1] = (in->bar & 0x0000ff00) >> 8;
    out[2] = (in->bar & 0x00ff0000) >> 16;
    out[3] = (in->bar & 0xff000000) >> 24;
    out[4] = in->baz;
    out[5] = in->quux[0];
    out[6] = in->quux[1];
    out[7] = in->quux[2];
    out[8] = in->quux[3];
    return 9; // bytes written
}

size_t deserialise (const uint8_t * in, struct foo * out)
{
    out->bar = in[0] | in[1] << 8 | in[2] << 16 | in[3] << 24;
    out->baz = in[4];
    out->quux[0] = in[5];
    out->quux[1] = in[6];
    out->quux[2] = in[6];
    out->quux[3] = in[8];
    return 9; // bytes recovered
}
